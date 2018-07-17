#!/usr/bin/env bash
echo "####################################################################"
echo "RUNNING FROM SCRIPT: yamtl_statisticBased_batch"
java -Xmx12288m -XX:+UseConcMarkSweepGC -Djava.awt.headless=true -jar ../runners/yamtl_batch_statisticBased.jar
echo "####################################################################"
echo "RUNNING FROM SCRIPT: yamtl_clientServer_incr (up to 32K)"
cd ../m2m.incr.cps2dep.yamtl
./gradlew clean run
cd ../m2m.incr.data
echo "Remember to copy the generated results CSV files into the corresponding folder" 
echo "####################################################################"
echo "RUNNING FROM SCRIPT: viatra_expl.jar (up to 8K)"
java -Xmx12288m -XX:+UseConcMarkSweepGC -Djava.awt.headless=true -jar ../runners/viatra_expl_clientServer.jar
echo "####################################################################"
echo "RUNNING FROM SCRIPT: viatra_qrt.jar (up to 4K)"
java -Xmx12288m -XX:+UseConcMarkSweepGC -Djava.awt.headless=true -jar ../runners/viatra_qrt_clientServer.jar
echo "####################################################################"
echo "####################################################################"
echo "####################################################################"
echo "RUNNING FROM SCRIPT: yamtl_statisticBased_batch"
java -Xmx12288m -XX:+UseConcMarkSweepGC -Djava.awt.headless=true -jar ../runners/yamtl_batch_statisticBased.jar
echo "####################################################################"
echo "RUNNING FROM SCRIPT: yamtl_statisticBased_incr"
cd ../m2m.incr.cps2dep.yamtl 
mv ./build.gradle ./build.gradle_clientServer
mv ./build.gradle_statisticBased ./build.gradle
./gradlew clean run
mv ./build.gradle ./build.gradle_statisticBased
mv ./build.gradle_clientServer ./build.gradle
echo "remember to copy .csv file from m2m.incr.cps2dep.yamtl to m2m.incr.data"
cd ../m2m.incr.data
echo "####################################################################"
echo "RUNNING FROM SCRIPT: expl_statisticBased_incr"
java -Xmx12288m -XX:+UseConcMarkSweepGC -Djava.awt.headless=true -jar ../runners/viatra_expl_statisticBased.jar
echo "####################################################################"
echo "RUNNING FROM SCRIPT: qrt_statisticBased_incr"
java -Xmx12288m -XX:+UseConcMarkSweepGC -Djava.awt.headless=true -jar ../runners/viatra_qrt_statisticBased.jar