from mpl_toolkits import mplot3d

import matplotlib as mpl
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
#%matplotlib inline

# ========================================================================
# part one, parse sample data

# open and read sample file
impFile = open("./jacobi_matrix.txt", "r")
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

# close file
impFile.close()


# modify data
# remove header
del results[0] 				
# remove empty table at last position
del results[(len(results)-1)]		


for rows_i in range(len(results)):
	for cols_i in reversed(range(len(results[rows_i]))):
		if results[rows_i][cols_i] == '':
			del results[rows_i][cols_i]
		else:
			conversion = float(results[rows_i][cols_i])
			results[rows_i][cols_i] = conversion

counter = 0
var_count = len(results[0])
district_count = 26

# data structure res_sorted = [variables[districts[values]], districts[values],..]
res_sorted = []

# for every variable
for variables_i in range(var_count):
	# create new and add tables per district
	res_sorted.append([])
	for districts_i in range(district_count):
		res_sorted[variables_i].append([])


# sort values by variable and district
for rows_i in range(len(results)):
	for cols_i in range(len(results[rows_i])):
		res_sorted[cols_i][counter % district_count].append(results[rows_i][cols_i])
	counter += 1

max_values = []
for variables_i in range(len(res_sorted)):
	max_values.append(0)
	for districts_i in range(len(res_sorted[variables_i])):
		if max(res_sorted[variables_i][districts_i]) > max_values[variables_i]:
				max_values[variables_i] = max(res_sorted[variables_i][districts_i])



# ========================================================================
# part two, data analysis


# some code for plotting
fig=plt.figure()

# set plot type
#plot = ''
#plot = 'scatter'
plot = 'plot'
#plot = 'triang'

time = range(76)
districts = ['Werra-Meissner-Kreis','Kassel-City','Kassel','Waldeck-Frankenberg','Hersfeld-Rotenburg','Schwalm-Eder-Kreis','Fulda','Marburg-Biedenkopf','Lahn-Dill-Kreis','Limburg-Weilburg'
		,'Giessen','Vogelsbergkreis','Main-Kinzig-Kreis','Wetteraukreis','Rheingau-Taunus-Kreis','Hochtaunuskreis','Wiesbaden','Main-Taunus-Kreis','Frankfurt-am-Main','Offenbach-am-Main'
		,'Offenbach','Gross-Gerau','Darmstadt','Darmstadt-Dieburg','Odenwaldkreis','Bergstrasse']


if plot == 'scatter':
	ax = fig.add_subplot(111)
	#plt.rcParams['text.usetex'] = True
	#ax.set_xlabel(r'time (days)')
	#ax.set_ylabel(r'$\fract{x}{y}$')

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
	#plt.rc(usetex = True)
	plt.rcParams['text.usetex'] = True
	#ax.set_xlabel(r'time (days)')
	#ax.set_xlabel(r'time (days)')
	#ax.set_ylabel(r'$\fract{x}{y}$')

	variable, variable_n = 0, 'alpha'
	#variable, variable_n = 1, 'qq'
	set_start = 24
	#set_end = 4
	set_end = set_start + 4
	#set_end = len(sorted_tab)
	for set_i in range(set_start, min(set_end, len(res_sorted[variable]))):
		ax.plot(time, res_sorted[variable][set_i], label=districts[set_i])
		#plt.ylim(0, max_values[variable])

	plt.legend(loc='upper left')
	plt.grid()
	plt.show()

elif plot == 'triang':
	# Triangulation
	ax = Axes3D(fig)



