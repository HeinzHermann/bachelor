from mpl_toolkits import mplot3d

import matplotlib as mpl
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
#%matplotlib inline

# ========================================================================
# part one, parse sample data

# set up for data parsing
file_names = ["./76d_run_orig.txt","./60d_run_sim.txt"]
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


# set up extrapolation
temp = []
array = []
fit = []
functions = []
extrapolation = []

extra_start = 60
extra_end = 75
extrapolation.append(range(extra_start, extra_end+1))

for set_i in range(1, len(sorted_tab[1])):
	for value_i in range(len(sorted_tab[1][set_i])):
		temp.append([sorted_tab[1][0][value_i],sorted_tab[1][set_i][value_i]])
	
	array = np.array(temp)
	fit = np.polyfit(array[:,0], array[:,1], 3)
	functions.append(np.poly1d(fit))
	temp = []
	
	for extra_i in extrapolation[0]:
		temp.append(functions[set_i-1](extra_i))

	extrapolation.append(temp)
	temp = []


# modify nomiclation
modifiers = ["_orig","_sim"]

for files_i in range(2):
	for sets_i in range(len(results[files_i][0])):
		results[files_i][0][sets_i] = results[files_i][0][sets_i]+modifiers[files_i]


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
	set_end = 27
	#set_end = len(sorted_tab)
	set_end = set_start+1 # only show one graph

	for file_i in range(len(results)):
		for set_i in range(set_start, set_end):
			ax.scatter(sorted_tab[file_i][0], sorted_tab[file_i][set_i], label=results[file_i][0][set_i])

	#for set_i in range(set_start, set_end):
		#ax.scatter(extrapolation[0], extrapolation[set_i], label=results[1][0][set_i][:-3]+"extrapolation")

	plt.axvline(x=50, color='r', linestyle=':')
	plt.legend(loc='upper left')
	plt.xlabel("Time t (days)")
	plt.ylabel("Sum of Exposed")
	plt.show()

elif plot == 'plot':
	ax = fig.add_subplot(111)

	set_start = 1
	set_end = 1
	#set_end = len(sorted_tab)
	set_end = set_start+1 # only show one graph

	for file_i in range(len(results)):
		for set_i in range(set_start, set_end):
			ax.plot(sorted_tab[file_i][0], sorted_tab[file_i][set_i], label=results[file_i][0][set_i])

	for set_i in range(set_start, set_end):
		ax.plot(extrapolation[0], extrapolation[set_i], label=results[1][0][set_i][:-3]+"extrapolation")

	plt.axvline(x=60, color='r', linestyle=':')
	plt.legend(loc='upper left')
	plt.xlabel("Time t (days)")
	plt.ylabel("Sum of Exposed")
	plt.show()

elif plot == 'triang':
	# Triangulation
	ax = Axes3D(fig)
	ax.plot_trisurf(res_sorted[0], res_sorted[1], res_sorted[2])
	#surf = ax.plot_trisurf(res_sorted[0], res_sorted[1], res_sorted[2], cmap = mpl.cm.jet, linewidth=0.1)
	plt.show()
else: pass
