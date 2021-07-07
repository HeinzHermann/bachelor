<!--- HEADER BEGIN -->
<!--- a) MathJax -->
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>
<!--- HEADER END -->

# Spread of Epidemics app
(c) 2020, G-CSC, Universität Frankfurt 
Authors: A. Nägel, G. Wittum
Extended by: D. Rastogi

## Governing equations
$$ \partial_t (\rho G) + \nabla [- \rho D \nabla G]  =  - \rho \alpha A G $$

$$ \partial_t (\rho A) + \nabla [- \rho D \nabla A]  = \rho( \alpha AG - \tau^{-1} A) $$
$$ \partial_t (\rho K) = \rho(\kappa \tau^{-1} A -  \sigma^{-1} K) $$
$$ \partial_t (\rho R) + \nabla [- \rho D \nabla A] = \rho((1-\kappa) \tau^{-1} A +   \sigma^{-1} (1-\theta) K) $$
$$ \partial_t (\rho D) = \sigma^{-1} \rho  \theta K$$

## How to run this program
Execute using 

> ugshell -ex epidemics_app/epidemics.lua [--num-refs NN] [--problem-id SS] [--debug-level MM] [--limex-num-stages LL] [--with-blocks bool]

Parameters:

* --num-refs NN: number of refinements (Default: 0) 
* --problem-id SS: name of the problem config. file (Default: "corono_DE_7Cities")         
* --debug-level MM: set debug level (Default: 0)                        
* --limex-num-stages LL: set limex stages (Default: 2)                  
* --with-blocks bool: AlgebraType, blocksize set to 5 (Default: true)      
