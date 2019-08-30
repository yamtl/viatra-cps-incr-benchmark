#!/usr/bin/env bash
#
#
# echo "####################################################################"
# echo "####################################################################"
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: yamtl_clientServer_incr_optimized_ (up to 32K)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl-all-experiments.yamtl.Cps2DepRunner_ClientServer_YAMTL_optimized_modification_full-0.0.5-SNAPSHOT.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: yamtl_publishSubscribe_incr_optimized_ (up to 32K)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl-all-experiments.yamtl.Cps2DepRunner_PublishSubscribe_YAMTL_optimized_modification_full-0.0.5-SNAPSHOT.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: yamtl_lowSynch_incr_optimized_ (up to 256)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl-all-experiments.yamtl.Cps2DepRunner_LowSynch_YAMTL_optimized_modification_full-0.0.5-SNAPSHOT.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: yamtl_simpleScaling_incr_optimized_ (up to 8196)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl-all-experiments.yamtl.Cps2DepRunner_SimpleScaling_YAMTL_optimized_modification_full-0.0.5-SNAPSHOT.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: yamtl_statistics_incr_optimized_ (up to 64)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl-all-experiments.yamtl.Cps2DepRunner_Statistics_YAMTL_optimized_modification_full-0.0.5-SNAPSHOT.jar
# #
# echo "####################################################################"
# echo "####################################################################"
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: yamtl_clientServer_incr (up to 32K)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl-all-experiments.yamtl.Cps2DepRunner_ClientServer_YAMTL_modification_full-0.0.5-SNAPSHOT.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: yamtl_publishSubscribe_incr (up to 32K)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl-all-experiments.yamtl.Cps2DepRunner_PublishSubscribe_YAMTL_modification_full-0.0.5-SNAPSHOT.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: yamtl_lowSynch_incr (up to 256)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl-all-experiments.yamtl.Cps2DepRunner_LowSynch_YAMTL_modification_full-0.0.5-SNAPSHOT.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: yamtl_simpleScaling_incr (up to 8196)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl-all-experiments.yamtl.Cps2DepRunner_SimpleScaling_YAMTL_modification_full-0.0.5-SNAPSHOT.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: yamtl_statistics_incr (up to 64)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl-all-experiments.yamtl.Cps2DepRunner_Statistics_YAMTL_modification_full-0.0.5-SNAPSHOT.jar
#
#
echo "####################################################################"
echo "####################################################################"
echo "####################################################################"
echo "RUNNING FROM SCRIPT: yamtl_clientServer_batch (up to 32K)"
java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl.batch-all-experiments.yamtl.Cps2DepRunner_ClientServer_YAMTL_batch_full-0.0.5-SNAPSHOT.jar
echo "####################################################################"
echo "RUNNING FROM SCRIPT: yamtl_publishSubscribe_batch (up to 32K)"
java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl.batch-all-experiments.yamtl.Cps2DepRunner_PublishSubscribe_YAMTL_batch_full-0.0.5-SNAPSHOT.jar
echo "####################################################################"
echo "RUNNING FROM SCRIPT: yamtl_lowSynch_batch (up to 256)"
java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl.batch-all-experiments.yamtl.Cps2DepRunner_LowSynch_YAMTL_batch_full-0.0.5-SNAPSHOT.jar
echo "####################################################################"
echo "RUNNING FROM SCRIPT: yamtl_simpleScaling_batch (up to 8196)"
java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl.batch-all-experiments.yamtl.Cps2DepRunner_SimpleScaling_YAMTL_batch_full-0.0.5-SNAPSHOT.jar
echo "####################################################################"
echo "RUNNING FROM SCRIPT: yamtl_statistics_batch (up to 64)"
java -jar -Xmx12G -XX:+UseG1GC ./runners/m2m.incr.cps2dep.yamtl.batch-all-experiments.yamtl.Cps2DepRunner_Statistics_YAMTL_batch_full-0.0.5-SNAPSHOT.jar
#
# echo "####################################################################"
# echo "####################################################################"
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: aof_clientServer_incr (up to 32K)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/AOF_clientServer_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: aof_publishSubscribe_incr (up to 32K)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/AOF_publishSubscribe_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: aof_lowSynch_incr (up to 256)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/AOF_lowSynch_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: aof_simpleScaling_incr (up to 8196)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/AOF_simpleScaling_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: aof_statistics_incr (up to 64)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/AOF_statistics_full.jar
#
#
# echo "####################################################################"
# echo "####################################################################"
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: atol_clientServer_incr (up to 32K)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/ATOL_clientServer_full.jar
#echo "####################################################################"
#echo "RUNNING FROM SCRIPT: atol_publishSubscribe_incr (up to 32K)"
#java -jar -Xmx12G -XX:+UseG1GC ./runners/ATOL_publishSubscribe_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: atol_lowSynch_incr (up to 256)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/ATOL_lowSynch_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: atol_simpleScaling_incr (up to 8196)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/ATOL_simpleScaling_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: atol_statistics_incr (up to 64)"
# java -jar -Xmx12G -XX:+UseG1GC ./runners/ATOL_statistics_full.jar
#
#
# echo "####################################################################"
# echo "####################################################################"
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: viatra_expl_clientServer_incr.jar (up to 8K)"
# java -Xmx12G -XX:+UseG1GC -Djava.awt.headless=true -jar ./runners/ViatraExpl_clientServer_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: viatra_expl_publishSubscribe_incr (up to 32K)"
# java -Xmx12G -XX:+UseG1GC -Djava.awt.headless=true -jar ./runners/ViatraExpl_publishSubscribe_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: viatra_expl_lowSynch_incr (up to 256)"
# java -Xmx12G -XX:+UseG1GC -Djava.awt.headless=true -jar ./runners/ViatraExpl_lowSynch_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: viatra_expl_simpleScaling_incr (up to 8196)"
# java -Xmx12G -XX:+UseG1GC -Djava.awt.headless=true -jar ./runners/ViatraExpl_simpleScaling_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: viatra_expl_statisticBased_incr"
# java -Xmx12G -XX:+UseG1GC -Djava.awt.headless=true -jar ./runners/ViatraExpl_statistics_full.jar
#
#
# echo "####################################################################"
# echo "####################################################################"
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: viatra_qrt_clientServer_incr (up to 4K)"
# java -Xmx12G -XX:+UseG1GC -Djava.awt.headless=true -jar ./runners/ViatraQrt_clientServer_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: viatra_qrt_publishSubscribe_incr (up to 4K)"
# java -Xmx12G -XX:+UseG1GC -Djava.awt.headless=true -jar ./runners/ViatraQrt_publishSubscribe_full.jar
# echo "####################################################################"
# echo "RUNNING FROM SCRIPT: viatra_qrt_lowSynch_incr (up to 256)"
# java -Xmx12G -XX:+UseG1GC -Djava.awt.headless=true -jar ./runners/ViatraQrt_lowSynch_full.jar
echo "####################################################################"
echo "RUNNING FROM SCRIPT: viatra_qrt_simpleScaling_incr (up to 8196)"
java -Xmx12G -XX:+UseG1GC -Djava.awt.headless=true -jar ./runners/ViatraQrt_simpleScaling_full.jar
echo "####################################################################"
echo "RUNNING FROM SCRIPT: viatra_qrt_statisticBased_incr"
java -Xmx12G -XX:+UseG1GC -Djava.awt.headless=true -jar ./runners/ViatraQrt_statistics_full.jar