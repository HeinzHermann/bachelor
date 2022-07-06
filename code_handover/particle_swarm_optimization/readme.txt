==========================================================================

				Manual

==========================================================================
To do:

Copy this folder in <your path>/ug4/apps/

Mandatory Path adjustment:

./config/geometry_parser.config		L.10	(adjust path to ug4)


==========================================================================

Adjust values in main_pso.lua as desired

L.35	(alpha, lower_bound, upper_bound)
L.36	(beta, lower_bound, upper_bound)

L.46	No. particles
L.47	No. groups
L.48	No. Iterations

Execute ugshell -ex ./main_pso.lua

==========================================================================

These should work without adjustment, bu can be checked in case of errors

Path adjustment in case of error: 

./main_pso.lua				L.15

./evaluate.lua				L.14

./scripts/epidemics.lua			L.31
./scripts/epidemics.lua			L.38 

./config/corona_HE.lua			L.11
./config/geometry_parser.config		L.10

==========================================================================

Output:

Given in ./evaluations/<date&time>/

Shows results in ./evaluations/<date&time>sparameters.txt/lua
I mainly used this to get a feel for the range of values

==========================================================================

