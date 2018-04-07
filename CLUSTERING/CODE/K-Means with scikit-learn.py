
# coding: utf-8

# #Clustering

# ##K-Means Algorithm

# This is my IPython notebook to practice, learn and demonstrate concepts in Clustering using the K-Means algorithm. This notebook will use scikit-learn, for implementation in other languages refer to the actual repo.

# K Means is an algorithm for **unsupervised clustering**: that is, finding clusters in data based on the data attributes alone (not the labels).
# 
# K Means searches for cluster centers which are the mean of the points within them, such that every point is closest to the cluster center it is assigned to.

# In[5]:

get_ipython().magic(u'matplotlib inline')
import matplotlib.pyplot as plt
import numpy as np


# In[41]:

#Generating some random samples (blobs) - basically generates random samples X, y with 3 clusters (centers parameter)
#also making it fairly easy to spot the clusters, note the cluster_std parameter
from sklearn.datasets.samples_generator import make_blobs
X, y = make_blobs(n_samples=300, centers=3,
                  random_state=0, cluster_std=0.60)
print X.shape, y.shape #y can take values 0,1,2 for 3 clusters but we're going to ignore y for the time being

# Visualizing the blobs as a scatter plot
plt.scatter(X[:, 0], X[:, 1], s=30);


# In[42]:

#The clusters are fairly easy to identify just by looking at it. But we'll now try to identify this using
#the K-Means algorithm.

from sklearn.cluster import KMeans
ktest = KMeans(n_clusters=3) #number of clusters to predict 3
ktest.fit(X) #fitting the model to X
y_pred = ktest.predict(X) #predicting labels (y) and saving to y_pred

#Plotting predicted labels as a scatter
plt.scatter(X[:,0], X[:,1], c=y_pred)

#That's pretty impressive, it identifies the clusters neatly


# In[54]:

#Let's try changing around some parameters

#If we insist of finding 4 instead of 3 clusters

ktest = KMeans(n_clusters=4) #number of clusters to predict 4
ktest.fit(X) #fitting the model to X
y_pred = ktest.predict(X) #predicting labels (y) and saving to y_pred

#Plotting predicted labels as a scatter
plt.scatter(X[:,0], X[:,1], c=y_pred)

#K-Means tries its best to find separation


# In[68]:

#Let's try changing around some parameters

#Setting max iterations to 100 instead of the default 300

ktest = KMeans(n_clusters=3, max_iter=100) #number of clusters to predict 4
ktest.fit(X) #fitting the model to X
y_pred = ktest.predict(X) #predicting labels (y) and saving to y_pred

#Plotting predicted labels as a scatter
plt.scatter(X[:,0], X[:,1], c=y_pred)

#Result doesn't look much different


# In[72]:

#Let's try to make it harder to find the clusters using the cluster_std parameter

X, y = make_blobs(n_samples=300, centers=3,
                  random_state=0, cluster_std=0.85)
print X.shape, y.shape #y can take values 0,1,2 for 3 clusters but we're going to ignore y for the time being

# Visualizing the blobs as a scatter plot
plt.scatter(X[:, 0], X[:, 1], s=30);


# In[73]:

#Now again running K-Means with just 100 iterations

ktest = KMeans(n_clusters=3, max_iter=100) #number of clusters to predict 4
ktest.fit(X) #fitting the model to X
y_pred = ktest.predict(X) #predicting labels (y) and saving to y_pred

#Plotting predicted labels as a scatter
plt.scatter(X[:,0], X[:,1], c=y_pred)

#It's actually done a pretty good job of seperating the data


# In[122]:

#Let's quickly compare cluster labels and original labels (y) using scatter plots
fig, ax=plt.subplots(1,2,figsize=(8,4))
ax[0].scatter(X[:,0], X[:,1],c=y)
ax[1].scatter(X[:,0], X[:,1],c=y_pred)

#Looks very close, K-Means has done a great job finding the clusters.


# **Example 1** Digits data available in scikit-learn

# In[128]:

from sklearn.datasets import load_digits
digits = load_digits()
print digits.keys()

#As the keys indicate, Digits dataset has images of digits stored under data and the actual digit stored under target
#There are 1797 images in total
print digits.data.shape
print digits.target

#the images are 8x8 pixels each stored as 64 dimensions to make it understandable for the ML algorithms.
print digits.images.shape


# In[162]:

#Let's ignore targets for the time being and use K-Means to find clusters in these images. We know that there are a total
#10 clusters for 0-9 digits
X,y=digits.data, digits.target
k_digits = KMeans(n_clusters=10)
y_pred=k_digits.fit_predict(X)

#Let's check the parameter cluster centers of the estimator
print k_digits.cluster_centers_.shape


# In[155]:

#The shape tells us these are centroids, that is the center of each of the clusters. In essence, 8x8 images of each of the 
#10 digits (atleast we expect it to be). Let's find out by visualizing these using scatter.

fig = plt.figure(figsize=(8,3))
for i in range(10):
    ax = fig.add_subplot(2, 5, i+1, xticks=[], yticks=[])
    ax.imshow(np.reshape(k_digits.cluster_centers_[i],(8,8)), cmap=plt.cm.binary)

#That is pretty great. It actually was able to find the clusters of the 10 digits nicely.
#Number 8 doesn't look very clear but everything else looks very good.


# In[176]:

#Let's visualize predicted labels and original labels to see if they're close.

#Now, X is a 64 dimension dataset. If we need to visualize this in 2D, we'll need to use PCA to reduce
#the dimensionality. Refer to << >> for a demonstration of PCA.

from sklearn.decomposition import RandomizedPCA
pca=RandomizedPCA(2).fit(X)
X_proj = pca.transform(X)

fig, ax = plt.subplots(1, 2, figsize=(8,4))
ax[0].scatter(X_proj[:,0], X_proj[:,1], c=y_pred)
ax[0].set_title('Clusters reduced to 2D with PCA', fontsize=10)

ax[1].scatter(X_proj[:,0], X_proj[:,1], c=y)
ax[1].set_title('Original Dataset reduced to 2D with PCA', fontsize=10)

#This looks pretty reasonable considering we never used the original labels to learn (like so with Supervised learning)
#the clusters were automatically identified and they reasonably resemble the targets.


# **Example 2** Color compression with Clustering
# 
# One interesting application of clustering is supposed to be color image compression. For example, imagine you have an image with millions of colors. In most images, a large number of the colors will be unused, and conversely a large number of pixels will have similar or identical colors. Clustering can help find N<sub>color</sub> clusters in the data, and we can use this to create a new image where the true input color is replaced by the color of the closest cluster.
# 
# Scikit-learn has a number of images that we can play with, accessed through the datasets module. Let's give this a whirl.

# In[191]:

from sklearn.datasets import load_sample_image
img=load_sample_image("china.jpg");
plt.imshow(img)


# In[192]:

#OK this is the most commonly used example of china.jpg for illustration.
#We can envision this image as a cloud of points in a 3-dimensional RGB color space, 427*640*3=819840
print img.shape


# In[193]:

#We'll rescale the colors so they lie between 0 and 1, then reshape the array to be a typical scikit-learn input:
#rescaling is very critical since we don't want to run these calculations on large numbers
img_r = (img / 255.0).reshape(-1,3)
print img_r.shape


# In[195]:

#OK now the task is to reduce the huge number of colors in this dataset to a smaller number, then use that instead
#to render the image and compare to the original.
k_colors = KMeans(n_clusters=64).fit(img_r)
y_pred=k_colors.predict(img_r)


# In[224]:

#Great, now lets look at the cluster centers. We must have a total of 64 centroids, shape must be of the input 
#dataset with 64x3 dimensions
print k_colors.cluster_centers_.shape #These are the cluster centers. That is the centroid of each of the 64 color clusters.

#these are the labels for each color in the original array. That is, for each color in the original dataset,
#it specifies the centroid of the cluster to which the color belongs. Not the location but the label. So, if we were 
#to replace each color to its closest match in the 64 colors we have selected, it would be using this label. 
#This array would be of length equal to the number of colors in the original dataset.
print k_colors.labels_.shape 

#here is a beautiful technique by using array indexes. We will specify labels as the indexes to the cluster_centers_ array 
#thereby changing cluster_centers to hold the centroid locations for each of the color points in the original dataset.
newimg=k_colors.cluster_centers_[k_colors.labels_]
print newimg.shape #great we're pretty close, just need to reshape this so we can get it to look similar to img.

newimg=np.reshape(newimg, (img.shape))
print newimg.shape #we just used img's shape to reshape, awesome we're almost there!


# In[233]:

#Now let's plot the two images side and by side and examine the differences.
fig = plt.figure(figsize=(8,8))
ax=fig.add_subplot(1,2,1,xticks=[],yticks=[],title='Original Image')
ax.imshow(img)
ax=fig.add_subplot(1,2,2,xticks=[],yticks=[],title='Color Compressed Image using K-Means')
ax.imshow(newimg)
plt.show()

