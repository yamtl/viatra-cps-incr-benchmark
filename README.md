# Adaptation of the incremental component of the VIATRA CPS benchmark

This benchmark is an adaptation of the incremental component of the [VIATRA CPS benchmark](https://github.com/viatra/viatra-cps-benchmark) for analyzing the performance of the [YAMTL model transformation engine](https://yamtl.github.io) in incremental model

This benchmark builds on the [adaptation of the batch component of the VIATRA CPS framework](https://github.com/yamtl/viatra-cps-batch-benchmark), where
* pointers to the specification of the original benchmark are given and the main differences, including differences with the original benchmark and the methodology used; and
* pointers to the solutions used in our benchmark are given, including the input models that have been used.

In this repository we include the solutions that have been extracted from the VIATRA CPS benchmark and our YAMTL solution.

## Model transformations used for the experiments

Below we provide pointers to the solutions of the transformation used in our adaptation of the **incremental component** of the VIATRA CPS benchmark, giving pointers to where they are defined in the original benchmark, if available. These projects have been built as separate standalone executable jars, which we call *runners*. The runners used for the experiments together with the process used to build them is explained at the end of this section.

### Solutions used in our experiments

Our solution:
* [YAMTL incremental variant (run in batch mode)](https://github.com/yamtl/viatra-cps-incr-benchmark/tree/master/m2m.incr.cps2dep.yamtl.batch)
* [YAMTL incremental variant (run in incremental mode)](https://github.com/yamtl/viatra-cps-incr-benchmark/tree/master/m2m.incr.cps2dep.yamtl)

Existing solutions that have been reused:

* [ATL (with ATOL compiler to AOF)](https://github.com/arturboronat/atol-cps)
	* reused from [its original repository](https://github.com/TheoLeCalvar/viatra-cps-benchmark) with the help of Théo Le Calvar
* [VIATRA Query Result Traceability (QRT)](https://github.com/yamtl/viatra-cps-incr-benchmark/blob/master/m2m.incr.cps2dep.viatra.qrt/src/org/eclipse/viatra/examples/cps/xform/m2m/incr/qrt/CPS2DeploymentTransformationQrt.xtend)
    * corresponds [to this case](https://github.com/viatra/viatra-docs/blob/master/cps/Query-result-traceability-M2M-transformation.adoc) in the VIATRA CPS benchmark    
* [VIATRA Explicit Traceability (EXPL](https://github.com/yamtl/viatra-cps-incr-benchmark/blob/master/m2m.incr.cps2dep.viatra.expl/src/org/eclipse/viatra/examples/cps/xform/m2m/incr/expl/CPS2DeploymentTransformation.xtend)
    * corresponds [to this case](https://github.com/viatra/viatra-docs/blob/master/cps/Explicit-traceability-M2M-transformation.adoc) in the VIATRA CPS benchmark    

From [the list of incremental solutions](https://github.com/viatra/viatra-docs/blob/master/cps/Alternative-transformation-methods.adoc#incremental) considered in the VIATRA CPS benchmarks, EXPL was the most performant in the propagation of source deltas in the original benchmark, according to [the performance analysis of the VIATRA CPS benchmark](https://github.com/viatra/viatra-cps-benchmark/wiki/Performance-evaluation#runtime).

### Runners

[This script](https://github.com/yamtl/viatra-cps-incr-benchmark/blob/master/m2m.incr.data/runIncrBenchmarks.sh) executes the different runners of the benchmark. **Beware that its full execution may well take more than twenty-four hours**. Feel free to modify the script to execute parts of it.

The runners used in our experiments can be found [here](https://github.com/yamtl/viatra-cps-incr-benchmark/tree/master/m2m.incr.data/runners). There is a runner for each solution and scenario. Each of these runners produces a CSV file, as the ones available [here](https://github.com/yamtl/viatra-cps-incr-benchmark/tree/master/m2m.incr.data/experimental-results), containing the raw data of the different experiments for each model size.

Each of this runners has been built in the Eclipse IDE by exporting the corresponding project (containing a benchmark solution) as a  `Runnable JAR file`. The following options need to be selected:
* Select the corresponding main class from the project of choice. The main class chosen must extend the benchmark harness `FullBenchmarkRunner`, included in each project. For example, [this runner](https://github.com/yamtl/viatra-cps-incr-benchmark/blob/master/m2m.incr.cps2dep.yamtl/src/main/java/experiments/yamtl/Cps2DepRunner_ClientServer_YAMTL_modification_full.xtend) for the YAMTL solution.
* Select the option `Package required libraries into generated JAR` for `library handling`.
* Provide the desired location for the JAR file. 


## Experiments

### Hardware used

MacBookPro11,5 Core i7 2.5 GHz, with four cores and 16 GB of RAM

### Software used

* CPS metamodels (0.1.0)
* VIATRA Query and Transformation SDK (1.7.2)
  * Java(TM) SE Runtime Environment (build 1.8.0\_72-b15)
* ATOL and YAMTL
  * Java(TM) SE Runtime Environment 18.9 (build 11.0.2+9-LTS)

### Raw results

* [Original results](https://github.com/yamtl/viatra-cps-batch-benchmark/tree/master/m2m.batch.data/experimental-results/XForm_CS_PS_Performance.xlsx): provided in [VIATRA CPS benchmark](https://github.com/viatra/viatra-cps-benchmark).
* [Results obtained](https://github.com/yamtl/viatra-cps-incr-benchmark/tree/master/m2m.incr.data/experimental-results) in our adapted variant of the VIATRA CPS benchmark.