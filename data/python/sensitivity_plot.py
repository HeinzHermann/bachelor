from mpl_toolkits import mplot3d

import matplotlib as mpl
import numpy as np
import matplotlib.pyplot as plt
#%matplotlib inline

# ========================================================================
# part one, parse sample data

# open and read sample file
impFile = open("./samples10k.txt", "r")
data = impFile.read()

# set up for data parsing
results = []
results.append([])
string = ''
set_i = 0

# parse data and write into results table
for char in data:
	if char == "\t":
		results[set_i].append(string)
		string = ''
	elif char == "\n":
		results[set_i].append(string)
		string = ''
		set_i += 1
		results.append([])
	else:
		string += char

# remove header
del results[0] 				
# remove empty table at last position
del results[(len(results)-1)]		


# res_sorted = [[alpha_values],[qq_values],[loss_values]]
res_sorted = [[], [], []]	
sorter = 0

# convert stings to float values and sort
for set_i in range(len(results)):
	for item_i in range(len(results[set_i])):
		# conversion
		conversion = float(results[set_i][item_i])
		results[set_i][item_i] = conversion

		# sorting
		res_sorted[sorter % 3].append(conversion)
		sorter += 1

# close file
impFile.close()


# ========================================================================
# part two, plot results

res_cut = [res_sorted[0][0:10],res_sorted[1][0:10],res_sorted[2][0:10]]

"""
test = [1,3,4,6]

test2 = np.array(test)
print(test)
print(test2)
test2.reshape(4, 4)
print(test2)
"""
# some code for plotting
alpha, qq = np.meshgrid(res_sorted[0], res_sorted[1])

fig=plt.figure()
ax=plt.axes(projection='3d')
#ax.contour3D(alpha, qq, res_sorted[2], 50, cmap='binary')
#ax.plot3D(res_sorted[0], res_sorted[1], res_sorted[2])
ax.scatter3D(res_sorted[0], res_sorted[1], res_sorted[2])
#ax.plot3D(res_cut[0], res_cut[1], res_cut[2])
#ax.scatter3D(res_cut[0], res_cut[1], res_cut[2])

ax.set_xlabel('alpha')
ax.set_ylabel('qq')
ax.set_zlabel('loss')

plt.show()
