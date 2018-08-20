# Benchmark CPS2DEP variant YAMTL (incremental variant run in batch mode)

This project provides a solution of the **incremental** component of the [VIATRA CPS benchmark](https://github.com/viatra/viatra-cps-benchmark) using the [YAMTL engine](https://yamtl.github.io) but it is run in **batch** mode in order to compare its performance with **incremental mode**, as configured in [this companion project](./m2m.incr.cps2dep.yamtl/).

The most relevant files are the following:

* [Transformation definition](./src/main/java/cps2dep/yamtl/Cps2DepYAMTL.xtend)
* [Runners for the various scenarios](./src/main/java/experiments/yamtl)
    * `Cps2DepRunner_YAMTL_SCENARIO`: runs one single experiment for models of different sizes of `SCENARIO`
    * `Cps2DepRunner_YAMTL_SCENARIO_full`: runs several experiments for models of different sizes of `SCENARIO`
* [Test cases](./src/test/java): more information on these test cases can be found in the following section.


To run the benchmark:
1. Select the corresponding runner in the Gradle build file, by setting `mainClassName`.
2. Run the command `./gradlew clean run` . (Remember to use Java 1.8).

To run the tests: run the command `./gradlew clean test` or run the project with JUnit within the IDE.
