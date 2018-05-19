package common.fop;

import java.io.File;
import java.io.OutputStream;
import java.io.StringReader;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.avalon.framework.configuration.Configuration;
import org.apache.avalon.framework.configuration.DefaultConfigurationBuilder;
import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.FopFactoryBuilder;
import org.apache.fop.apps.MimeConstants;

public class FOP_Test_Advanced {

	/**
	* @param args
	*/
	public static void main(String[] args) {
	}
	
	
	public static void build(String xmlLocation, File xsltFile, File newPDFFile) throws Exception {
        try {
	        // Setup input for XSLT transformation
			Source xmlSource = new StreamSource(xmlLocation);
	
			build(xmlSource, xsltFile, newPDFFile);
	    } catch (Exception e) {
	        System.out.println(e);
	        e.printStackTrace(System.out);
	        throw e;
	    }		
	}
	public static void build(StringBuffer xmlData, File xsltFile, File newPDFFile) throws Exception {
        try {
	        // Setup input for XSLT transformation
			Source xmlSource = new StreamSource( new StringReader(xmlData.toString()) );
	
			build(xmlSource, xsltFile, newPDFFile);
	    } catch (Exception e) {
	        System.out.println(e);
	        e.printStackTrace(System.out);
	        throw e;
	    }		
	}
	public static void build(File xmlData, File xsltFile, File newPDFFile) throws Exception {
        try {
	        // Setup input for XSLT transformation
			Source xmlSource = new StreamSource( xmlData );
	
			build(xmlSource, xsltFile, newPDFFile);
        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace(System.out);
            throw e;
        }		
	}
	
	
	public static void build(Source xmlSource, File xsltFile, File newPDFFile) throws Exception {
		build(xmlSource, xsltFile, newPDFFile, null);
	}
	
	public static void build(Source xmlSource, File xsltFile, File newPDFFile, Hashtable<String, String> parameters) throws Exception {
        try {
        	
            DefaultConfigurationBuilder cfgBuilder = new DefaultConfigurationBuilder();
            Configuration cfg = cfgBuilder.buildFromFile(new File("C:/geovault/fop-config.xml"));
            
	        // Configure fopFactory...
            FopFactoryBuilder fopBuilder = new FopFactoryBuilder(new File(".").toURI()).setConfiguration(cfg);            
//        	FopFactoryBuilder fopBuilder = new FopFactoryBuilder(new File("C:/geovault/fop-config.xml").toURI());
        	fopBuilder.setStrictFOValidation(false);
        	
	        FopFactory fopFactory = fopBuilder.build();
	        
	        // Configure foUserAgent...
	        FOUserAgent foUserAgent = fopFactory.newFOUserAgent();
	
	        // Setup output
	        OutputStream out = new java.io.FileOutputStream(newPDFFile);
	        out = new java.io.BufferedOutputStream(out);
	
	        try {
	            // Construct fop with desired output format
	            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);
	
	            // Setup XSLT
	            TransformerFactory factory = TransformerFactory.newInstance();
	            Transformer transformer = factory.newTransformer(new StreamSource(xsltFile));
	
	            // -- Set the values of parameters, for the stylesheet
	            if (parameters != null) {
	    			Enumeration<String> keys = parameters.keys();
	    			while (keys.hasMoreElements()) {
	    				String param = (String)keys.nextElement();
	    				String paramValue = ((String)parameters.get(param) );
			            transformer.setParameter(param, paramValue);
	            	}
	            }
	
	
	            // Resulting SAX events (the generated FO) must be piped through to FOP
	            Result res = new SAXResult(fop.getDefaultHandler());
	
	            // Start XSLT transformation and FOP processing
	            transformer.transform(xmlSource, res);
	        } catch (Exception e) {
	            System.out.println(e);
	            e.printStackTrace(System.out);
	            throw e;
	        } finally {
	            out.close();
	        }		
        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace(System.out);
            throw e;
        }		
	}
	
	
}
