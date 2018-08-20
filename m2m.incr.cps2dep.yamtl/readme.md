# Benchmark CPS2DEP variant YAMTL (incremental variant run in incremental mode)

This project provides a solution of the **incremental** component of the [VIATRA CPS benchmark](https://github.com/viatra/viatra-cps-benchmark) using the [YAMTL engine](https://yamtl.github.io).

This transformation can also be run in batch mode as shown in [this project](https://github.com/yamtl/viatra-cps-batch-benchmark/tree/master/m2m.incr.cps2dep.yamtl.batch).

The most relevant files are the following:

* [Transformation definition](./src/main/java/cps2dep/yamtl/Cps2DepYAMTL.xtend)
* [Runners for the various scenarios](./src/main/java/experiments/yamtl/)
    * `Cps2DepRunner_SCENARIO_YAMTL`: runs one single experiment for models of different sizes of `SCENARIO`
    * `Cps2DepRunner_SCENARIO_YAMTL_full`: runs several experiments for models of different sizes of `SCENARIO`
* [Test cases](./src/test/java/): more information on these test cases can be found in the following section.
* Configuration of the project with AspectJ:
    * [Aspect](./src/main/java/cps2dep/yamtl/FeatureCallAspect.xtend)
    * [Gradle build file](./build.gradle)
    * [aop.xml](./src/test/java/META-INF/aop.xml)

## Running the benchmark

To run the benchmark:
1. Select the corresponding runner in the Gradle build file, by setting `mainClassName`.
2. Run the command `./gradlew clean run` .

## Running the benchmark sanity checks

The benchmark sanity checks have been adapted as explained [here](https://github.com/yamtl/viatra-cps-batch-benchmark/tree/master/m2m.batch.cps2dep.yamtl#benchmark-sanity-checks). In addition, changes need to be recorded explicitly, which is achieved using the method `Cps2DepTestDriver_YAMTL::executeTransformation(String, () => Map<String,EObject>)`. 

To run the tests:
1. Install AJDT 2.2.4
2. Create a launch configuration `Run > Run Configurations...`
    * New `JUnit configuration` with `JUnit 4`.
    * In tab `Test`: select `Run all tests in the selected project, package or source folder`: `m2m.incr.cps2dep.yamtl`.
    * In tab `Arguments`, add the following VM argument: `-javaagent:${project_loc}/lib/aspectjweaver-1.9.1.jar`.
3. Apply and run the configuration.