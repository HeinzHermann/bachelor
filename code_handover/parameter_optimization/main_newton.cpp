#include<iostream>
#include "/home/marvin/Documents/ug4/plugins/ConstrainedOptimization/core/parameter_estimation.h"
#include "/home/marvin/Documents/ug4/plugins/ConstrainedOptimization/core/parameters.h"
#include <string>



int main(){

// Set initial values, lower bounds and upperbounds for each parameter
co::EVar64Manager initial_vars;
co::EVar64 alpha(co::EFloat64(0.20),co::EFloat64(0.15),co::EFloat64(0.25));
//co::EVar64 kappa(co::EFloat64(0.070439024),co::EFloat64(0.05),co::EFloat64(0.1));
//co::EVar64 theta(co::EFloat64(0.148484475),co::EFloat64(0.1),co::EFloat64(0.16));
co::EVar64 qq(co::EFloat64(7),co::EFloat64(6),co::EFloat64(8));
//co::EVar64 pp(co::EFloat64(10.0),co::EFloat64(7),co::EFloat64(14));

//co::EVar64 c(co::EFloat64(0.6),co::EFloat64(0.6),co::EFloat64(2));
//co::EVar64 k(co::EFloat64(7.52149380283449),co::EFloat64(-50),co::EFloat64(50));

// add the parameters to the EVar64Manager
initial_vars.add("alpha",alpha);
//initial_vars.add("kappa",kappa);
//initial_vars.add("theta",theta);
initial_vars.add("qq",qq);
//initial_vars.add("pp",pp);

co::NewtonOptions options;
options.set_stepsize_alpha(1); // vaiable
std::string dir ="<your path>/ug4/apps/parameter_optimization/";
co::BiogasEvaluation<co::EFloat64,co::ConfigComputation::Local,co::ConfigOutput::File> evaluator(dir, "subset_target.lua", "subset_sim.lua");
co::EVarManager<co::EFloat64> estimated_vars;
co::NewtonOptimizer<decltype(evaluator)> solver(options,evaluator);

solver.change_derivative_step_size(0.01); // variable
solver.run(initial_vars,estimated_vars);

}
