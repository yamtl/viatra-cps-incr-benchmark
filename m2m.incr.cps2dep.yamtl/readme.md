# Benchmark CPS2DEP variant YAMTL (incremental)

This project provides a solution of the **incremental** component of the [VIATRA CPS benchmark](https://github.com/viatra/viatra-cps-benchmark) using the [YAMTL engine](https://yamtl.github.io).

This project reuses the same transformation used for the batch component of the benchmark, which can be found [here](https://github.com/yamtl/viatra-cps-batch-benchmark/tree/master/m2m.batch.cps2dep.yamtl).

The most relevant changes are the following:

* [Configuration of transformation in the runners for the various scenarios](https://github.com/yamtl/viatra-cps-incr-benchmark/tree/master/m2m.incr.cps2dep.yamtl/src/main/java/experiments/yamtl)
    * `Cps2DepRunner_YAMTL_SCENARIO`: runs one single experiment for models of different sizes of `SCENARIO`
    * `Cps2DepRunner_YAMTL_SCENARIO_full`: runs several experiments for models of different sizes of `SCENARIO`
* Configuration of the project with AspectJ:
    * [Aspect](./src/main/java/cps2dep/yamtl/FeatureCallAspect.xtend)
    * [Gradle build file](./build.gradle)

To run the benchmark:
1. Select the corresponding runner in the Gradle build file, by setting `mainClassName`.
2. Run the command `./gradlew clean run` .