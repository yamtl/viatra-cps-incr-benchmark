package experiments.yamtl

import cps2dep.yamtl.Cps2DepYAMTL
import java.util.Map
import org.apache.log4j.Logger
import org.eclipse.emf.ecore.EObject
import org.eclipse.viatra.examples.cps.deployment.Deployment
import org.eclipse.viatra.examples.cps.traceability.CPSToDeployment
import org.eclipse.xtend.lib.annotations.Accessors
import yamtl.core.YAMTLModule.ExecutionMode
import yamtl.core.YAMTLModule.ExtentTypeModifier

class Cps2DepTestDriver_YAMTL_batch {
	protected extension Logger logger = Logger.getLogger("Cps2DepTestDriver_YAMTL")
	
	@Accessors
	val static public ROOT_PATH = '/Users/ab373/Documents/ArturData/WORK/ECLIPSE/RESEARCH/2018_research_photon_yamtl/yamtl.examples.mapping.incr.cps2dep/src/main/resources/cps2dep/output'
	
	@Accessors
	var Cps2DepYAMTL xform 
	
	def initializeTransformation(CPSToDeployment cps2dep) {
		if ((cps2dep.cps === null) || (cps2dep.deployment === null)) 
			throw new IllegalArgumentException()
		
		xform = new Cps2DepYAMTL
//		xform.debug=true
		xform.fromRoots = false
		xform.extentTypeModifier = ExtentTypeModifier.LIST
		xform.executionMode = ExecutionMode.NORMAL
		
		xform.mapping = cps2dep
		val cpsRes = xform.mapping.cps.eResource
		xform.loadInputResources(#{'cps' -> cpsRes})
	}
	
	def CPSToDeployment executeTransformation() {
		// reset
		if (xform.mapping.traces === null)
			if (xform.debug) println ( 'no traces' )
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
	
	def executeTransformation(String deltaName, () => Map<String,EObject> delta) {
//		xform.saveInputModels(#{'cps' -> '''src/main/resources/cps2dep/output/«deltaName».cps.before.xmi'''})
//		xform.saveOutputModels(#{'dep' -> '''src/main/resources/cps2dep/output/«deltaName».deployment.before.xmi'''})
		
		val result = delta.apply()
		
		xform.mapping.traces.clear
		xform.transitionToBTransitionList.clear
		xform.stateToBStateList.clear
		xform.smToBehList.clear
		xform.depAppToAppInstance.clear
		xform.reset()
		
		xform.execute()

		// extract DEP model		
		val depRes = xform.getOutputModel('dep')
		xform.mapping.deployment = depRes.contents.findFirst[Deployment.isInstance(it)] as Deployment
		// extract TRACE model
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