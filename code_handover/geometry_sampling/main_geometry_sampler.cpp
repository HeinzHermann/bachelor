#include<iostream>
#include "../../core/parameter_estimation.h"
#include "../../core/parameters.h"
#include <string>

int main(){
	//Define evaluation type
	std::string dir ="<your path>/ug4/apps/epidemics_simulation/";
	std::printf("BiogasEvaluation, creation starting\n");
	co::BiogasEvaluation<co::EFloat64,co::ConfigComputation::Local,co::ConfigOutput::File> evaluator(dir, "subset_target.lua","subset_sim.lua");
	std::printf("BiogasEvaluation, creation done\n");
	//Set parameter names
	std::printf("readin parameters, starging\n");
	std::vector<std::string> param_names={"v_alpha","v_qq"};
	std::printf("readin parameters, done\n");
	//Set parameter bounds (sequentially, low, high, low, high etc.)
	std::printf("setting starting, done\n");
	std::vector<double> bounds={0.175,0.225,6.25,7.5};
	std::printf("setting bounds, done\n");
	
	int n=30; //number of samples
	
	//Call sampler (which writes results to file in the evaluations folder)
	co::sample_loss_geometry(evaluator,param_names,bounds, n);
}
