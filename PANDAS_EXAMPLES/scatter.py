variance=[1, 2, 4, 8, 16, 32, 64, 128, 256]

bias_squared =[256, 128, 64, 32, 16, 8, 4, 2, 1]

total_error = [x + y for x, y in zip(variance, bias_squared)]


xs = [i for i,_ in enumerate(variance)]

plt.plot(xs, variance,'g-', label='variance')
# green solid line
plt.plot(xs, bias_squared, 'r-.', label='bias^2')
# red dot-dashed line
plt.plot(xs, total_error, 'b:', label='total error') # blue dotted line
# because we've assigned labels to each series
# we can get a legend for free
# loc=9 means "top center"

plt.legend(loc=9)
plt.xlabel("model complexity")
plt.title("The Bias-Variance Tradeoff")
plt.show()

friends = [ 70, 65, 72, 63, 71, 64, 60, 64, 67]
minutes = [175, 170, 205, 120, 220, 130, 105, 145, 190]
labels = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i']
plt.scatter(friends, minutes)
# label each point
for label, friend_count, minute_count in zip(labels, friends, minutes):
plt.annotate(label,xy=(friend_count, minute_count), xytext=(5, -5),textcoords='offset points')
plt.title("Daily Minutes vs. Number of Friends")

plt.xlabel("# of friends")
plt.ylabel("daily minutes spent on the site")
plt.show()

test_1_grades = [ 99, 90, 85, 97, 80]
test_2_grades = [100, 85, 60, 90, 70]
plt.scatter(test_1_grades, test_2_grades)
plt.title("Axes Aren't Comparable")
plt.xlabel("test 1 grade")
plt.ylabel("test 2 grade")
plt.show()