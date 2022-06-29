from mpl_toolkits import mplot3d

import matplotlib as mpl
import numpy as np
import matplotlib.pyplot as plt
import statistics
from mpl_toolkits.mplot3d import Axes3D
#%matplotlib inline

# ========================================================================
# part one, parse sample data

# open and read sample file
impFile = open("./perc_diff_50d_corr.txt", "r")
data = impFile.read()

# set up for data parsing
results = []
results.append([])
string = ''
set_i = 0

# parse data and write into results table
for char in data:
	if (char == "\t" or char == ","):
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
		if (conversion != 0.0):
			results[set_i][item_i] = conversion
			sorted_tab[counter % count_tab].append(conversion)
		counter += 1

# close file
impFile.close()

testprint = False
testprint = True
if testprint:
	print(results[0])
	for table in range(len(sorted_tab)):
		print(sorted_tab[table], 'mean =', statistics.median(sorted_tab[table]))

# ========================================================================
# part two, plot results

# some code for plotting
fig=plt.figure()

# set plot type
plot = ''
#plot = 'scatter'
#plot = 'plot'
#plot = 'triang'
plot = 'box'


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

	set_start = 20
	set_end = 27
	#set_end = len(sorted_tab)

	for set_i in range(set_start, set_end):
		ax.plot(sorted_tab[0], sorted_tab[set_i], label=results[0][set_i])

	plt.legend(loc='upper right')
	plt.show()

elif plot == 'box':
	ax = fig.add_subplot(111)

	set_start = 1
	set_end = 12
	#set_end = len(sorted_tab)
	
	#ax.boxplot(sorted_tab[set_start:set_end])
	#ax.set_xticklabels(results[0][set_start:set_end], rotation=45)
	#plt.subplots_adjust(bottom=0.3)

	data_reverse = sorted_tab[set_start:set_end]

	data_reverse = []
	data_reverse.append(sorted_tab[1])
	data_reverse.append(sorted_tab[8])
	data_reverse.append(sorted_tab[10])
	
	# delete outliners
	#del data_reverse[9]
	#del data_reverse[7]
	#del data_reverse[0]

	#data_reverse = data_reverse[16:24]

	hdata = data_reverse.reverse()
	names_reverse = results[0][set_start:set_end]

	# delete outliners
	#del names_reverse[9]
	#del names_reverse[7]
	#del names_reverse[0]
	
	names_reverse = []
	names_reverse.append(results[0][1])
	names_reverse.append(results[0][8])
	names_reverse.append(results[0][10])

	
	#names_reverse = names_reverse[16:24]
	
	hnames = names_reverse.reverse()
	#ax.boxplot(data_reverse,showmeans=True, vert=0)
	ax.boxplot(data_reverse, vert=0)
	ax.set_yticklabels(names_reverse)
	plt.xlabel("Relative deviation")
	plt.subplots_adjust(left=0.3)
	#for set_i in range(set_start, set_end):
	#	ax.boxplot(sorted_tab[0], sorted_tab[set_i], label=results[0][set_i])
	
	# print statistics 
	boxres = mpl.cbook.boxplot_stats(data_reverse)
	print("boxstats:")
	print("------------------------------")
	for regions in range(len(boxres)):
		print(names_reverse[regions])
		for keys, values in boxres[regions].items():
			print(keys, ":", values)
		print("------------------------------")
	
	
	#plt.legend(loc='upper right')
	plt.show()


elif plot == 'triang':
	# Triangulation
	ax = Axes3D(fig)
	ax.plot_trisurf(res_sorted[0], res_sorted[1], res_sorted[2])
	#surf = ax.plot_trisurf(res_sorted[0], res_sorted[1], res_sorted[2], cmap = mpl.cm.jet, linewidth=0.1)
	plt.show()

