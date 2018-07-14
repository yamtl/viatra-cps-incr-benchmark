package experiments.yamtl

import cps2dep.yamtl.Cps2DepYAMTL
import experiments.utils.BenchmarkRunner
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

class Cps2DepRunner_ClientServer_YAMTL_modification extends BenchmarkRunner {

	var Cps2DepYAMTL xform 
	var List<EObject> rootObjects 
    
//    val ROOT_PATH = '..'
    val ROOT_PATH = '/Users/ab373/Documents/ArturData/WORK/git/viatra-cps-batch-benchmark'
    
	override getIdentifier() {
		"cps2dep_clientServer_yamtl_incr_modification"
	}
	
	override getIterations() {
		#[1, 1, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768]
//		#[1, 1, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384]
//		#[1, 8]
	}
    
	def static void main(String[] args) {
		
		val runner = new Cps2DepRunner_ClientServer_YAMTL_modification
		runner.runBenchmark
	
	} 

	// in our case
	// TODO: initialization should be performed before loading models	
	override doLoad(String iteration) {
		doStandaloneEMFSetup()
		
		var String inputModelPath = '''«ROOT_PATH»/m2m.batch.data/cps2dep/clientServer/cps/clientServer_«iteration».cyberphysicalsystem.xmi'''

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
		
		var String forwardDeltaPath = '''«ROOT_PATH»/m2m.batch.data/cps2dep/clientServer/cps/clientServer_«iteration».cyberphysicalsystem.delta.xmi'''
		xform.loadDelta('cps', 'update', forwardDeltaPath, new Timestamp(System.nanoTime()))
	}
	
	override doInitialization(String iteration) {
		xform.execute()
		xform.traceModel
	}
	
	override doTransformation(String iteration) {
		xform.propagateDelta('cps', 'update')
	}
	
	override doSave(String iteration) {
//		var String outputModelPath = '''«ROOT_PATH»/m2m.batch.data/cps2dep/clientServer/deployment/yamtl/modification/clientServer_«iteration».deployment.modification.xmi'''
//		xform.saveOutputModels(#{'dep' -> outputModelPath})
//		
//		var String outputTraceModelPath = '''«ROOT_PATH»/m2m.batch.data/cps2dep/clientServer/deployment/yamtl/modification/clientServer_«iteration».traceability.modification.xmi'''
////		println("save traceability: " + outputTraceModelPath)
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