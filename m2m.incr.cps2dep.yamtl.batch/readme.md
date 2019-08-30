# Benchmark CPS2DEP variant YAMTL (incremental variant run in batch mode)

This project provides a solution of the **incremental** component of the [VIATRA CPS benchmark](https://github.com/viatra/viatra-cps-benchmark) using the [YAMTL engine](https://yamtl.github.io) but it is run in **batch** mode in order to compare its performance with **incremental mode**, as configured in [this companion project](./m2m.incr.cps2dep.yamtl/).

The most relevant files are the following:

* [Transformation definition](./src/main/java/cps2dep/yamtl/Cps2DepYAMTL.xtend)
* [Runners for the various scenarios](./src/main/java/experiments/yamtl)
    * `Cps2DepRunner_YAMTL_SCENARIO`: runs one single experiment for models of different sizes of `SCENARIO`
    * `Cps2DepRunner_YAMTL_SCENARIO_full`: runs several experiments for models of different sizes of `SCENARIO`
* [Test cases](./src/test/java): more information on these test cases can be found in the following section.


## Running the benchmark

To run the benchmark:
1. Select the corresponding runner in the Gradle build file, by setting `mainClassName`
2. Run the command `./gradlew clean run  -PmainClass=MAIN_CLASS`, where `MAIN_Class` can be `experiments.yamtl.Cps2DepRunner_ClientServer_YAMTL_batch` 

## Running the benchmark sanity checks

The benchmark sanity checks have been adapted as explained [here](https://github.com/yamtl/viatra-cps-batch-benchmark/tree/master/m2m.batch.cps2dep.yamtl#benchmark-sanity-checks). In addition, changes need to be recorded explicitly, which is achieved using the method `experiments.yamtl.Cps2DepTestDriver_YAMTL::executeTransformation(String, () => Map<String,EObject>)` (under `src/test/java`).

To run the tests, run the tests with JUnit from the IDE.
