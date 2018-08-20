package experiments.expl

import experiments.utils.FullBenchmarkRunner
import java.io.File
import java.io.IOException
import java.util.HashMap
import java.util.Map
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.impl.ResourceImpl
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
import org.eclipse.emf.ecore.xmi.XMLResource
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl
import org.eclipse.emf.ecore.xmi.impl.XMLParserPoolImpl
import org.eclipse.emf.ecore.xmi.impl.XMLResourceImpl
import org.eclipse.viatra.examples.cps.cyberPhysicalSystem.ApplicationType
import org.eclipse.viatra.examples.cps.cyberPhysicalSystem.CyberPhysicalSystem
import org.eclipse.viatra.examples.cps.cyberPhysicalSystem.CyberPhysicalSystemPackage
import org.eclipse.viatra.examples.cps.cyberPhysicalSystem.HostInstance
import org.eclipse.viatra.examples.cps.deployment.DeploymentFactory
import org.eclipse.viatra.examples.cps.deployment.DeploymentPackage
import org.eclipse.viatra.examples.cps.generator.utils.CPSModelBuilderUtil
import org.eclipse.viatra.examples.cps.traceability.CPSToDeployment
import org.eclipse.viatra.examples.cps.traceability.TraceabilityFactory
import org.eclipse.viatra.examples.cps.traceability.TraceabilityPackage
import org.eclipse.viatra.examples.cps.xform.m2m.incr.expl.CPS2DeploymentTransformation
import org.eclipse.viatra.query.runtime.api.AdvancedViatraQueryEngine
import org.eclipse.viatra.query.runtime.emf.EMFScope

class Cps2DepRunner_ViatraExpl_statisticBased_full_modification extends FullBenchmarkRunner {
	CPS2DeploymentTransformation xform 
	AdvancedViatraQueryEngine engine 
    var CPSToDeployment cps2dep
    extension CPSModelBuilderUtil builderUtil = new CPSModelBuilderUtil
    
    val ROOT_PATH = '/Users/ab373/Documents/ArturData/WORK/git/viatra-cps-batch-benchmark'
    
    
	override getIdentifier() {
		"cps2dep_statisticBased_viatraExpl_modification"
	}
	
	override getIterations() {
		#[1, 1, 2, 4, 8, 16, 32, 64]
//		#[1]
	}

	def static void main(String[] args) {
		val runner = new Cps2DepRunner_ViatraExpl_statisticBased_full_modification
		runner.runBenchmark(10)
	} 
	
	override doLoad(String iteration) {
		doStandaloneEMFSetup()
		
		var String inputModelPath = '''«ROOT_PATH»/m2m.batch.data/cps2dep/statistics/'''
		var String outputModelPath = '''«ROOT_PATH»/m2m.batch.data/cps2dep/statistics/deployment/viatraExpl'''

		cps2dep = preparePersistedCPSModel(
			URI.createFileURI(new File(inputModelPath).absolutePath),
			'''statistics_«iteration»''',
			URI.createFileURI(new File(outputModelPath).absolutePath)
		)
	}
	
	var ApplicationType appType
	var HostInstance hostInstance
	    
	override doInitialization() {
		engine = AdvancedViatraQueryEngine.createUnmanagedEngine(new EMFScope(cps2dep.eResource.resourceSet));
		xform = new CPS2DeploymentTransformation
		xform.initialize(cps2dep, engine)
		xform.execute()
		appType = cps2dep.cps.appTypes.findFirst[it.identifier.contains("AC_withStateMachine")]
		hostInstance = cps2dep.cps.hostTypes.findFirst[it.identifier.contains("HC_appContainer")].instances.head
	}
	
	override doTransformation() {
		val appID = "new.app.instance" + "_NEW" // cpsToken.nextModificationIndex 
		appType.prepareApplicationInstanceWithId(appID, hostInstance)
	}
	
	override doSave(String iteration) {
//		try {
//	      cps2dep.deployment.eResource.save(Collections.EMPTY_MAP);
//	    } catch (IOException e) {
//	      e.printStackTrace();
//	    }
//		try {
//	      cps2dep.eResource.save(Collections.EMPTY_MAP);
//	    } catch (IOException e) {
//	      e.printStackTrace();
//	    }
	}
	
		
	override doDispose() {
		if(xform !== null){
			xform.dispose
		}
		if(engine !== null){
			engine.dispose
		}
		xform = null
		engine = null
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
	
	def preparePersistedCPSModel(URI sourceUri, String modelName, URI targetUri) {
		val rs = new ResourceSetImpl()
		
		// register default factory - needed for standalone mode
		rs.getResourceFactoryRegistry().getExtensionToFactoryMap().
		put(
				Resource.Factory.Registry.DEFAULT_EXTENSION, 
				new XMIResourceFactoryImpl()
		);
		
		val modelNameURI = sourceUri.appendSegment(modelName)
		// Artur: use getResource instead of createResource for cps model
		val cpsRes = rs.createResource(modelNameURI.appendFileExtension("cyberphysicalsystem.xmi"))
		val Map<Object,Object> loadOptions = (cpsRes as XMLResourceImpl).getDefaultLoadOptions();
		loadOptions.put(XMLResource.OPTION_DEFER_ATTACHMENT, Boolean.TRUE);
		loadOptions.put(XMLResource.OPTION_DEFER_IDREF_RESOLUTION, Boolean.TRUE);
		loadOptions.put(XMLResource.OPTION_USE_DEPRECATED_METHODS, Boolean.TRUE);
		loadOptions.put(XMLResource.OPTION_USE_PARSER_POOL, new XMLParserPoolImpl());
		loadOptions.put(XMLResource.OPTION_USE_XML_NAME_TO_FEATURE_MAP, new HashMap());
		
		(cpsRes as ResourceImpl).setIntrinsicIDToEObjectMap(new HashMap());
		try {
			cpsRes.load(null);
		} catch (IOException e) {
			e.printStackTrace();
		}

		val targetModelNameURI = targetUri.appendSegment(modelName)
		val depRes = rs.createResource(targetModelNameURI.appendFileExtension("deployment.modification.xmi"))
		val trcRes = rs.createResource(targetModelNameURI.appendFileExtension("traceability.modification.xmi"))
		
		// Artur: to load the model
//		val cps = createCyberPhysicalSystem => [
//			identifier = modelName
//		]
//		cpsRes.contents += cps
		val cps = cpsRes.contents.head as CyberPhysicalSystem
		
		val dep = DeploymentFactory.eINSTANCE.createDeployment
		depRes.contents += dep
		 
		val cps2dep = TraceabilityFactory.eINSTANCE.createCPSToDeployment => [
			it.cps = cps
			it.deployment = dep
		]
		trcRes.contents += cps2dep
		cps2dep
	}

	
} 
 