==========================================================================

				Manual

==========================================================================
To do:

Copy this folder in <your path>/ug4/apps/

Mandatory Path adjustment:

./config/geometry_parser.config		L.10	(adjust path to ug4)
./main_geometry_sampler.cpp		L. 8	(adjust path to ug4)

Copy main_geometry_sampler.cpp to <your path>/ug4/plugins/ConstrainedOptimization/examples/logistic_1/

==========================================================================

Adjust values in main_geometry_sampler.cpp as desired

L.18	bounds={min_alpha, max_alpha, min_q, max_q}
L.21	n = number of sample points 


Complile via c++ -O3 -pthread main_geometry_sampler.cpp -o name.out

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

Given in ./evaluations/<date&time>/iteration_0/samples.txt

Shows values for alpha, q and loss

==========================================================================

