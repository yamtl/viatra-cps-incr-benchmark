package experiments.yamtl

import cps2dep.yamtl.Cps2DepYAMTL
import experiments.utils.FullBenchmarkRunner
import java.sql.Timestamp
import java.util.List
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl
import org.eclipse.viatra.examples.cps.cyberPhysicalSystem.CyberPhysicalSystem
import org.eclipse.viatra.examples.cps.cyberPhysicalSystem.CyberPhysicalSystemPackage
import org.eclipse.viatra.examples.cps.deployment.DeploymentPackage
import org.eclipse.viatra.examples.cps.traceability.TraceabilityFactory
import org.eclipse.viatra.examples.cps.traceability.TraceabilityPackage
import yamtl.core.YAMTLModule.ExecutionMode
import yamtl.core.YAMTLModule.ExtentTypeModifier

class Cps2DepRunner_StatisticBased_YAMTL_modification_full extends FullBenchmarkRunner {

	var Cps2DepYAMTL xform 
	var List<EObject> rootObjects 
	var String iteration
    
    val ROOT_PATH = '/Users/ab373/Documents/ArturData/WORK/git/viatra-cps-batch-benchmark'
    
	override getIdentifier() {
		"cps2dep_statisticBased_yamtl_incr_modification"
	}
	
	override getIterations() {
		#[1, 1, 2, 4, 8, 16, 32, 64]
//		#[1]
	}
    
	def static void main(String[] args) {
		val runner = new Cps2DepRunner_StatisticBased_YAMTL_modification_full
//		runner.debug = true
		runner.runBenchmark(10)
	
	} 

	// in our case
	// TODO: initialization should be performed before loading models	
	override doLoad(String iteration) {
		this.iteration = iteration
		
		doStandaloneEMFSetup()
		
		var String inputModelPath = '''«ROOT_PATH»/m2m.batch.data/cps2dep/statistics/statistics_«iteration».cyberphysicalsystem.xmi'''
		
		xform = new Cps2DepYAMTL
		xform.fromRoots = false
		xform.extentTypeModifier = ExtentTypeModifier.LIST
		xform.executionMode = ExecutionMode.INCREMENTAL
		
		// prepare models
		// this will normally be outside the trafo declaration
		xform.loadInputModels(#{'cps' -> inputModelPath})
		
		val cpsRes = xform.getModelResource('cps')
		xform.mapping = TraceabilityFactory.eINSTANCE.createCPSToDeployment => [
			it.cps = cpsRes.contents.head as CyberPhysicalSystem
		]
		
		var String forwardDeltaPath = '''«ROOT_PATH»/m2m.batch.data/cps2dep/statistics/statistics_«iteration».cyberphysicalsystem.delta.xmi'''
		xform.loadDelta('cps', 'update', forwardDeltaPath, new Timestamp(System.nanoTime()))
	}
	
	override doInitialization() {
		xform.execute()
		xform.getTraceModel()
	}
	
	override doTransformation() {
		xform.propagateDelta('cps', 'update')
	}
	
	override doSave(String iteration) {
//		var String outputModelPath = '''../m2m.batch.data/cps2dep/clientServer/deployment/yamtl/clientServer_«iteration».deployment.xmi'''
//		xform.saveOutputModels(#{'dep' -> outputModelPath})
//		
//		var String outputTraceModelPath = '''../m2m.batch.data/cps2dep/clientServer/deployment/yamtl/clientServer_«iteration».traceability.xmi'''
//		println("save traceability: " + outputTraceModelPath)
//		xform.saveTraceModel(outputTraceModelPath)
	}
	
	override doDispose() {
		xform = null
		rootObjects = null
	}

	///////////////////////////////////////////////////////////////////////////////////////////
	// SOLUTION SPECIFIC
	///////////////////////////////////////////////////////////////////////////////////////////
	def doStandaloneEMFSetup() {
		Resource.Factory.Registry.INSTANCE.getExtensionToFactoryMap().put("*", new XMIResourceFactoryImpl());
		
		CyberPhysicalSystemPackage.eINSTANCE.eClass()
		DeploymentPackage.eINSTANCE.eClass()
		TraceabilityPackage.eINSTANCE.eClass()
	}	
}