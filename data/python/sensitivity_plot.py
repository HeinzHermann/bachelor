from mpl_toolkits import mplot3d

import matplotlib as mpl
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
#%matplotlib inline

# ========================================================================
# part one, parse sample data

# open and read sample file
impFile = open("./samples4k.txt", "r")
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

print("alpha: min =", min(res_sorted[0]), ", max =", max(res_sorted[0]))
print("qq: min =", min(res_sorted[1]), ", max =", max(res_sorted[1]))
print("loss: min =", min(res_sorted[2]), ", max =", max(res_sorted[2]))


# set ranges for data point removal
alpha_high = 0.25
#alpha_high = max(res_sorted[0])
alpha_low = 0.15
#alpha_low = min(res_sorted[0])
qq_high = 8.00
#qq_high = max(res_sorted[1])
qq_low = 5.5
#qq_low = min(res_sorted[1])
loss_high = 2700000000.000
loss_high = 9999999999.000
#loss_high = max(res_sorted[2])
loss_low = 0

# remove data points outsite of ranges
data_count = len(res_sorted[2])
for pos_i in range(1, data_count+1):
	if (res_sorted[0][data_count - pos_i] > alpha_high or res_sorted[0][data_count - pos_i] < alpha_low
			or res_sorted[1][data_count - pos_i] > qq_high or res_sorted[1][data_count - pos_i] < qq_low
			or res_sorted[2][data_count - pos_i] > loss_high or res_sorted[2][data_count - pos_i] < loss_low):

		#print (res_sorted[2][data_count - pos_i]) 
		del res_sorted[0][data_count - pos_i] 
		del res_sorted[1][data_count - pos_i] 
		del res_sorted[2][data_count - pos_i] 

print("alpha count =", len(res_sorted[0]))
print("qq count =", len(res_sorted[1]))
print("loss count =", len(res_sorted[2]))

print("alpha: min =", min(res_sorted[0]), ", max =", max(res_sorted[0]))
print("qq: min =", min(res_sorted[1]), ", max =", max(res_sorted[1]))
print("loss: min =", min(res_sorted[2]), ", max =", max(res_sorted[2]))


# ========================================================================
# part two, plot results

# some code for plotting
fig=plt.figure()

# set plot type
plot = 'scatter'
#plot = 'triang'


if plot == 'scatter':
	# scatter plot
	m_loss = max(res_sorted[2])
	cm = plt.get_cmap("RdYlGn")
	color = [cm(1-(loss/m_loss)) for loss in res_sorted[2]]

	ax=plt.axes(projection='3d')
	ax.scatter3D(res_sorted[0], res_sorted[1], res_sorted[2], c = color, marker = 'o')

	ax.set_xlabel('alpha')
	ax.set_ylabel('qq')
	ax.set_zlabel('loss')

	#plt.ticklabel_format(axis="z", style="sci", scilimits=(0,0))

	ax.set_xlim3d(alpha_low, alpha_high)
	ax.set_ylim3d(qq_low, qq_high)
	ax.set_zlim3d(min(res_sorted[2]), max(res_sorted[2]))

elif plot == 'triang':
	# Triangulation
	ax = Axes3D(fig)
	ax.plot_trisurf(res_sorted[0], res_sorted[1], res_sorted[2])
	#surf = ax.plot_trisurf(res_sorted[0], res_sorted[1], res_sorted[2], cmap = mpl.cm.jet, linewidth=0.1)

plt.show()

