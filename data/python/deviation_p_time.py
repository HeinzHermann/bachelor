from mpl_toolkits import mplot3d

import matplotlib as mpl
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
#%matplotlib inline

# ========================================================================
# part one, parse sample data

# open and read sample file
impFile = open("./perc_diff.txt", "r")
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
	elif char == "\r" or char == "#":
		pass
	else:
		string += char

# remove header
#del results[0] 				
# remove empty table at last position
del results[(len(results)-1)]
sorted_tab = []
count_tab = len(results[0])

for sets in range(count_tab):
	sorted_tab.append([])
	
counter = 0

# convert stings to float values and sort per district
for set_i in range(1, len(results)):
	for item_i in range(len(results[set_i])):
		# conversion
		conversion = float(results[set_i][item_i])
		results[set_i][item_i] = conversion

		sorted_tab[counter % count_tab].append(conversion)
		counter += 1

# close file
impFile.close()

testprint = False
if testprint:
	print(results[0])
	for table in range(len(sorted_tab)):
		print(sorted_tab[table])

# ========================================================================
# part two, plot results

# some code for plotting
fig=plt.figure()

# set plot type
plot = ''
#plot = 'scatter'
plot = 'plot'
#plot = 'triang'


if plot == 'scatter':
	ax = fig.add_subplot(111)

	set_start = 1
	#set_end = 5
	set_end = len(sorted_tab)

	for set_i in range(set_start, set_end):
		ax.scatter(sorted_tab[0], sorted_tab[set_i], label=results[0][set_i])

	plt.legend(loc='upper right')

	"""
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
	"""

	plt.show()

elif plot == 'plot':
	ax = fig.add_subplot(111)

	set_start = 25
	set_end = 27
	#set_end = len(sorted_tab)

	for set_i in range(set_start, set_end):
		ax.plot(sorted_tab[0], sorted_tab[set_i], label=results[0][set_i])

	plt.legend(loc='upper right')
	plt.show()

elif plot == 'triang':
	# Triangulation
	ax = Axes3D(fig)
	ax.plot_trisurf(res_sorted[0], res_sorted[1], res_sorted[2])
	#surf = ax.plot_trisurf(res_sorted[0], res_sorted[1], res_sorted[2], cmap = mpl.cm.jet, linewidth=0.1)
	plt.show()

