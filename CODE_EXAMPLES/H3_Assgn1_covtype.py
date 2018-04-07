from time import time
import os
import numpy as np
import urllib.request
from sklearn.svm import LinearSVC
from sklearn.linear_model import SGDClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, ExtraTreesClassifier
from sklearn import metrics



def read_data():
    # Download the data
    import urllib.request
    print ("Downloading data, Please Wait (11MB)...")
    opener = urllib.request.urlopen(
        'http://archive.ics.uci.edu/ml/'
        'machine-learning-databases/covtype/covtype.data.gz')
    open('covtype.data.gz', 'w').write(opener.read())

    ######################################################################
    ## Load dataset
    print("Loading dataset...")
    import gzip
    f = gzip.open('/home/ash/covtype.data.gz')
    X = np.fromstring(f.read().replace(",", " "), dtype=np.float64, sep=" ",
                      count=-1)
    X = X.reshape((581012, 55))
    f.close()

    # class 1 vs. all others.
    y = np.ones(X.shape[0]) * -1
    y[np.where(X[:, -1] == 1)] = 1
    X = X[:, :-1]

    ######################################################################
    ## Create train-test split (as [Joachims, 2006])
    print("Creating train-test split...")
    idx = np.arange(X.shape[0])
    np.random.seed(13)
    np.random.shuffle(idx)
    train_idx = idx[:522911]
    test_idx = idx[522911:]

    X_train = X[train_idx]
    y_train = y[train_idx]
    X_test = X[test_idx]
    y_test = y[test_idx]

    # free memory
    del X
    del y

    ######################################################################
    ## Standardize first 10 features (the numerical ones)
    mean = X_train.mean(axis=0)
    std = X_train.std(axis=0)
    mean[10:] = 0.0
    std[10:] = 1.0
    X_train = (X_train - mean) / std
    X_test = (X_test - mean) / std

    ######################################################################
    ## Print dataset statistics
    print("")
    print("Dataset statistics:")
    print("===================")
    print("%s %d" % ("number of features:".ljust(25),
                     X_train.shape[1]))
    print("%s %d" % ("number of classes:".ljust(25),
                     np.unique(y_train).shape[0]))
    print("%s %d (%d, %d)" % ("number of train samples:".ljust(25),
                              X_train.shape[0], np.sum(y_train == 1),
                              np.sum(y_train == -1)))
    print("%s %d (%d, %d)" % ("number of test samples:".ljust(25),
                              X_test.shape[0], np.sum(y_test == 1),
                              np.sum(y_test == -1)))
    print("")
    print("Training classifiers...")
    print("")

    ######################################################################
    ## Benchmark classifiers
    def benchmark(clf):
        t0 = time()
        clf.fit(X_train, y_train)
        train_time = time() - t0
        t0 = time()
        pred = clf.predict(X_test)
        test_time = time() - t0
        err = metrics.zero_one_loss(y_test, pred) / float(pred.shape[0])
        return err, train_time, test_time

    ######################################################################
    ## Train Liblinear model
    liblinear_parameters = {
        'loss': 'l2',
        'penalty': 'l2',
        'C': 1000,
        'dual': False,
        'tol': 1e-3,
    }
    liblinear_res = benchmark(LinearSVC(**liblinear_parameters))
    liblinear_err, liblinear_train_time, liblinear_test_time = liblinear_res

    ######################################################################
    ## Train GaussianNB model
    gnb_err, gnb_train_time, gnb_test_time = benchmark(GaussianNB())

    ######################################################################
    ## Train SGD model
    sgd_parameters = {
        'alpha': 0.001,
        'n_iter': 2,
    }
    sgd_err, sgd_train_time, sgd_test_time = benchmark(SGDClassifier(
        **sgd_parameters))

    ######################################################################
    ## Train CART model
    cart_err, cart_train_time, cart_test_time = benchmark(
        DecisionTreeClassifier(min_samples_split=5,max_depth=None))

    ######################################################################
    ## Train RandomForest model
    rf_err, rf_train_time, rf_test_time = benchmark(
        RandomForestClassifier(n_estimators=20,
                               min_samples_split=5,
                               max_depth=None))

    ######################################################################
    ## Train Extra-Trees model
    et_err, et_train_time, et_test_time = benchmark(
        ExtraTreesClassifier(n_estimators=20,
                             min_samples_split=5,
                             max_depth=None))

    ######################################################################
    ## Print classification performance
    print("")
    print("Classification performance:")
    print("===========================")
    print("")

    def print_row(clf_type, train_time, test_time, err):
        print("%s %s %s %s" % (clf_type.ljust(12),
                               ("%.4fs" % train_time).center(10),
                               ("%.4fs" % test_time).center(10),
                               ("%.4f" % err).center(10)))

    print("%s %s %s %s" % ("Classifier  ", "train-time", "test-time",
                           "error-rate"))
    print("-" * 44)
    print_row("Liblinear", liblinear_train_time, liblinear_test_time,
              liblinear_err)
    print_row("GaussianNB", gnb_train_time, gnb_test_time, gnb_err)
    print_row("SGD", sgd_train_time, sgd_test_time, sgd_err)
    print_row("CART", cart_train_time, cart_test_time, cart_err)
    print_row("RandomForest", rf_train_time, rf_test_time, rf_err)
    print_row("Extra-Trees", et_train_time, et_test_time, et_err)
    print("")
    print("")

def main():
    read_data()

if __name__ == "__main__":
    main()