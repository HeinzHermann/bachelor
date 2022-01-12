from mpl_toolkits import mplot3d

import matplotlib as mpl
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
#%matplotlib inline

# ========================================================================
# part one, parse sample data

# set up for data parsing
file_names = ["./t50_run_orig.txt","t50_run_sim.txt"]
results = []
sorted_tab = []
string = ''

for files_i in range(len(file_names)):

	# set up for next file
	results.append([])
	results[files_i].append([])
	set_i = 0

	# open and read sample file
	impFile = open(file_names[files_i], "r")
	data = impFile.read()

	# parse data and write into results table
	for char in data:
		if (char == "\t" or char == ","):
			results[files_i][set_i].append(string)
			string = ''
		elif char == "\n":
			results[files_i][set_i].append(string)
			string = ''
			set_i += 1
			results[files_i].append([])
		elif char == "\r" or char == "#":
			pass
		else:
			string += char
	

	# close file
	impFile.close()

	# remove header
	#del results[files_i][0] 				
	# remove empty table at last position
	del results[files_i][(len(results[files_i])-1)]
	sorted_tab.append([])
	count_tab = len(results[files_i][0])

	for sets in range(count_tab):
		sorted_tab[files_i].append([])
		
	counter = 0
	# convert stings to float values and sort per district
	for set_i in range(1, len(results[files_i])):
		for item_i in range(len(results[files_i][set_i])):
			# conversion
			conversion = float(results[files_i][set_i][item_i])
			results[files_i][set_i][item_i] = conversion

			sorted_tab[files_i][counter % count_tab].append(conversion)
			counter += 1


	testprint = True
	testprint = False
	if testprint:
		print(results[files_i][0])
		for table in range(len(sorted_tab[files_i])):
			print(sorted_tab[files_i][table])

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

	set_start = 1
	set_end = 27
	#set_end = len(sorted_tab)
	set_end = set_start+1 # only show one graph
	"""
	print(sorted_tab[0][0])
	print(sorted_tab[0][26])
	print(results[0][0][26])
	"""

	for file_i in range(len(results)):
		for set_i in range(set_start, set_end):
			ax.plot(sorted_tab[file_i][0], sorted_tab[file_i][set_i], label=results[file_i][0][set_i])

	plt.legend(loc='upper right')
	plt.show()

elif plot == 'triang':
	# Triangulation
	ax = Axes3D(fig)
	ax.plot_trisurf(res_sorted[0], res_sorted[1], res_sorted[2])
	#surf = ax.plot_trisurf(res_sorted[0], res_sorted[1], res_sorted[2], cmap = mpl.cm.jet, linewidth=0.1)
	plt.show()
else: pass
