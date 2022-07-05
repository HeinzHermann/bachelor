#include<iostream>
#include "/home/marvin/Documents/ug4/plugins/ConstrainedOptimization/core/parameter_estimation.h"
#include "/home/marvin/Documents/ug4/plugins/ConstrainedOptimization/core/parameters.h"
#include <string>

int main(){

	std::vector<std::string> names={"alpha"
					//,"kappa"
					,"theta"
					,"qq"
					,"pp"
	};
	
	std::string dir ="/home/marvin/Documents/ug4/apps/epidemics_app/parameteroptimization/";
		//"/home/marvin/Documents/ug4/apps/epidemics_app/parameteroptimization/";
	
	//Bounds for each parameter are added following the order specified in the names vector. Lower bound first.
	std::vector<co::EFloat64> bounds={co::EFloat64(1e-8),co::EFloat64(0.1)
						//,co::EFloat64(1e-13),co::EFloat64(1)
						,co::EFloat64(0.00001),co::EFloat64(0.05)
						,co::EFloat64(4),co::EFloat64(8)
						,co::EFloat64(8),co::EFloat64(14)
	};


	co::PSOOptions options;
	options.set_max_iterations(10);
	options.set_n_particles(32);
	options.set_n_groups(4);
	co::EpidemicsPDEEvaluation<co::EFloat64,co::ConfigComputation::Local, co::ConfigOutput::File> evaluator(dir,"subset_target.lua", "subset_sim.lua");
	co::ParticleSwarmOptimizer<co::EpidemicsPDEEvaluation<co::EFloat64,co::ConfigComputation::Local, co::ConfigOutput::File>> pso(options,evaluator);
	co::EVarManager<co::EFloat64> estimated_parameters;
	pso.run(estimated_parameters,names,bounds);
}
