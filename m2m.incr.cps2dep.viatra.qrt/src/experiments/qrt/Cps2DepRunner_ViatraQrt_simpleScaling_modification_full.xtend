package experiments.qrt

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
import org.eclipse.viatra.examples.cps.xform.m2m.incr.qrt.CPS2DeploymentTransformationQrt
import org.eclipse.viatra.query.runtime.api.AdvancedViatraQueryEngine
import org.eclipse.viatra.query.runtime.emf.EMFScope

class Cps2DepRunner_ViatraQrt_simpleScaling_modification_full extends FullBenchmarkRunner {
	val trafo = 'simpleScaling'
	val ROOT_PATH = '/Users/ab373/Documents/ArturData/WORK/git/viatra-cps-batch-benchmark'
	
	CPS2DeploymentTransformationQrt xform 
	AdvancedViatraQueryEngine engine
    var CPSToDeployment cps2dep
    extension CPSModelBuilderUtil builderUtil = new CPSModelBuilderUtil
    
	override getIdentifier() {
		'''cps2dep_«trafo»_viatraQrt'''
	}
	
	override getIterations() {
		#[1, 1, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096]
//		#[1, 1, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768]
//		#[1]
	}

	def static void main(String[] args) {
		val runner = new Cps2DepRunner_ViatraQrt_simpleScaling_modification_full
		runner.runBenchmark(10)
	} 
	
	override doLoad(String iteration) {
		doStandaloneEMFSetup()
		
		var String inputModelPath = '''«ROOT_PATH»/m2m.batch.data/cps2dep/«trafo»/cps/'''
		var String outputModelPath = '''«ROOT_PATH»/m2m.batch.data/cps2dep/«trafo»/deployment/viatraQrt'''

		cps2dep = preparePersistedCPSModel(
			URI.createFileURI(new File(inputModelPath).absolutePath),
			'''«trafo»_«iteration»''',
			URI.createFileURI(new File(outputModelPath).absolutePath)
		)
	}
	
	
	var ApplicationType appType
	var HostInstance hostInstance
	    
	override doInitialization() {
		engine = AdvancedViatraQueryEngine.createUnmanagedEngine(new EMFScope(cps2dep.eResource.resourceSet));
		xform = new CPS2DeploymentTransformationQrt
		xform.initialize(cps2dep, engine)
		xform.execute()
		appType = cps2dep.cps.appTypes.findFirst[it.identifier.contains("AC")]
		hostInstance = cps2dep.cps.hostTypes.findFirst[it.identifier.contains("HC")].instances.head
	}
	
	override doTransformation() {
		val appID = "new.app.instance" + "_NEW" // nextModificationIndex 
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
		engine = null
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
		val depRes = rs.createResource(targetModelNameURI.appendFileExtension("deployment.xmi"))
		val trcRes = rs.createResource(targetModelNameURI.appendFileExtension("traceability.xmi"))
		
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
 