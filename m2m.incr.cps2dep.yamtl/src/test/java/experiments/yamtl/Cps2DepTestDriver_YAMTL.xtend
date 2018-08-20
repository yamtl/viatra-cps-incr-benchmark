package experiments.yamtl

import cps2dep.yamtl.Cps2DepYAMTL
import java.sql.Timestamp
import java.util.Map
import org.apache.log4j.Logger
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.change.ChangeDescription
import org.eclipse.emf.ecore.change.util.ChangeRecorder
import org.eclipse.viatra.examples.cps.deployment.Deployment
import org.eclipse.viatra.examples.cps.traceability.CPSToDeployment
import org.eclipse.xtend.lib.annotations.Accessors
import yamtl.core.YAMTLModule.ExecutionMode
import yamtl.core.YAMTLModule.ExtentTypeModifier

class Cps2DepTestDriver_YAMTL {
	protected extension Logger logger = Logger.getLogger("Cps2DepTestDriver_YAMTL")
	
	@Accessors
	val static public ROOT_PATH = '/Users/ab373/Documents/ArturData/WORK/ECLIPSE/RESEARCH/2018_research_photon_yamtl/yamtl.examples.mapping.incr.cps2dep/src/main/resources/cps2dep/output'
	
	@Accessors
	var Cps2DepYAMTL xform 
	
	def initializeTransformation(CPSToDeployment cps2dep) {
		if ((cps2dep.cps === null) || (cps2dep.deployment === null)) 
			throw new IllegalArgumentException()
		
		xform = new Cps2DepYAMTL
		xform.debug=true
		xform.fromRoots = false
		xform.extentTypeModifier = ExtentTypeModifier.LIST
		xform.executionMode = ExecutionMode.INCREMENTAL
		
		xform.mapping = cps2dep
		val cpsRes = xform.mapping.cps.eResource
		xform.loadInputResources(#{'cps' -> cpsRes})
	}
	
	def CPSToDeployment executeTransformation() {
		// reset
		if (xform.mapping.traces === null)
			println ( 'no traces' )
		else 
			xform.mapping.traces.clear()
		xform.transitionToBTransitionList.clear()
		xform.stateToBStateList.clear()
		xform.smToBehList.clear()
//		xform.reachableWaitForTransitionsMap.clear()
		xform.depAppToAppInstance.clear()
		xform.reset()
		
		xform.execute()

		// extract DEP model		
		val depRes = xform.getOutputModel('dep')
		xform.mapping.deployment = depRes.contents.findFirst[Deployment.isInstance(it)] as Deployment
		// extract TRACE model
		xform.getTraceModel()
		
		xform.mapping
	}
	
//	def executeTransformation(String deltaName, () => Map<String,EObject> delta) {
////		xform.saveInputModels(#{'cps' -> '''src/main/resources/cps2dep/output/«deltaName».cps.before.xmi'''})
////		xform.saveOutputModels(#{'dep' -> '''src/main/resources/cps2dep/output/«deltaName».deployment.before.xmi'''})
//		
//		var Map<String,EObject> result = newHashMap
//		// record changes
//		var ChangeRecorder recorder 
//		var ChangeDescription des
//		val cpsRes = xform.getModelResource('cps')
//		recorder = new ChangeRecorder(cpsRes)
//		
//		// change
//		result = delta.apply()
//		
//		// end recording
//		des = recorder.endRecording()
//		
////				xform.putDelta('cps', testId, des)
////		xform.saveDelta('cps', testId, '''src/main/resources/cps2dep/output/cpsDelta.ApplicationMapping.«testId».backward.xmi''')
////		
////		// reverse
////		// get original model
////		val registry = new EmfMetamodelRegistry()
////		val cpsResOriginal = registry.loadModel('''src/main/resources/cps2dep/output/«testId».cps.before.xmi''',true)
////		
////		var ChangeDescriptionReverserUtil reverser = new ChangeDescriptionReverserUtil(xform.engine)
////		// the change is undone as a result as well
////		val docDes = reverser.reverse(des, cpsResOriginal)
////		
////		xform.putDelta('cps', testId, docDes)
////		xform.saveDelta('cps', deltaName, '''src/main/resources/cps2dep/output/cpsDelta.ApplicationMapping.«deltaName».forward.xmi''')
////		xform.loadDelta('cps', deltaName, '''src/main/resources/cps2dep/output/cpsDelta.ApplicationMapping.«deltaName».forward.xmi''', new Timestamp(System.currentTimeMillis))
//		
//		des.applyAndReverse()
//		xform.putDelta('cps', deltaName, des)
////		xform.saveDelta('cps', deltaName, '''src/main/resources/cps2dep/output/cpsDelta.ApplicationMapping.«deltaName».forward.xmi''')
//		
//		// DELTA PROPAGATION
//		// reverse the change
//		xform.propagateDelta('cps', deltaName)
//		val res = xform.getOutputModel('dep')
//		xform.getTraceModel()
//
////		xform.saveInputModels(#{'cps' -> '''src/main/resources/cps2dep/output/«deltaName».cps.after.xmi'''})
////		xform.saveOutputModels(#{'dep' -> '''src/main/resources/cps2dep/output/«deltaName».deployment.after.xmi'''})
//		
////		xform.saveModel('''src/main/resources/cps2dep/output/«deltaName».traces.after.xmi''', newArrayList(xform.mapping))
//				
//		result
//	}
	def executeTransformation(String deltaName, () => Map<String,EObject> delta) {
//		xform.saveInputModels(#{'cps' -> '''src/main/resources/cps2dep/output/«deltaName».cps.before.xmi'''})
//		xform.saveOutputModels(#{'dep' -> '''src/main/resources/cps2dep/output/«deltaName».deployment.before.xmi'''})
		
		val result = xform.propagateDelta('cps', deltaName, delta)
		val res = xform.getOutputModel('dep')
		xform.getTraceModel()

//		xform.saveInputModels(#{'cps' -> '''src/main/resources/cps2dep/output/«deltaName».cps.after.xmi'''})
//		xform.saveOutputModels(#{'dep' -> '''src/main/resources/cps2dep/output/«deltaName».deployment.after.xmi'''})
//		xform.saveModel('''src/main/resources/cps2dep/output/«deltaName».traces.after.xmi''', newArrayList(xform.mapping))
				
		result
	}
	def startTest(String testId){
    	info('''START TEST: type: YAMTL ID: «testId»''')
    }
    
    def endTest(String testId){
    	info('''END TEST: type: YAMTL ID: «testId»''')
    }
	

}