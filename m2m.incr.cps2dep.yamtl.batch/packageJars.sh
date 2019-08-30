#!/usr/bin/env bash

# REMEMBER to comment the declaration of mainClass in build.gradle
# or all of the jars will refer to that mainClass (the program argument will be ignored)

# BATCH

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_ClientServer_YAMTL_batch_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_PublishSubscribe_YAMTL_batch_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_LowSynch_YAMTL_batch_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_SimpleScaling_YAMTL_batch_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

./gradlew -PmainClass=experiments.yamtl.Cps2DepRunner_Statistics_YAMTL_batch_full clean fatJar
mv build/libs/* /Users/ab373/Documents/ArturData/WORK/git/viatra-cps-incr-benchmark/m2m.incr.data/runners/

