#!/usr/bin/env bash

# REMEMBER to comment the declaration of mainClassName in build.gradle
# or all of the jars will refer to that mainClassName (the program argument will be ignored)

# INCR

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_ClientServer_YAMTL_modification_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_PublishSubscribe_YAMTL_modification_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_LowSynch_YAMTL_modification_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_SimpleScaling_YAMTL_modification_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_Statistics_YAMTL_modification_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

# INCR_UPDATE_OPTIMIZED

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_ClientServer_YAMTL_optimized_modification_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_PublishSubscribe_YAMTL_optimized_modification_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_LowSynch_YAMTL_optimized_modification_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_SimpleScaling_YAMTL_optimized_modification_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_Statistics_YAMTL_optimized_modification_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

