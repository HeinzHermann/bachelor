==========================================================================

				Manual

==========================================================================
To do:

Copy this folder in <your path>/ug4/apps/

Mandatory Path adjustment:

./config/geometry_parser.config		L.10	(adjust path to ug4)
./main_newton.cpp			L.30	(adjust path to ug4)


==========================================================================

Adjust values in main_newton.cpp as desired

L.12	alpha (start_value, lower_bound, upper_bound)
L.15	beta (start_value, lower_bound, upper_bound)


Complile via c++ -O3 -pthread main_newton.cpp -o name.out

Execute ./name.out

==========================================================================

These should work without adjustment, bu can be checked in case of errors

Path adjustment in case of error: 

./evaluate.lua				L.14

./scripts/epidemics.lua			L.31
./scripts/epidemics.lua			L.38 

./config/corona_HE.lua			L.11
./config/geometry_parser.config		L.10

==========================================================================

Output:

Given in ./evaluations/<date&time>/

summary_of_estimation.txt shows result values.
Manual search needed for result data

==========================================================================

