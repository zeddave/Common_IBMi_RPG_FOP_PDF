package common.fop;

import java.io.File;
import java.io.OutputStream;
import java.io.StringReader;
import java.util.Hashtable;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.FopFactoryBuilder;
import org.apache.fop.apps.MimeConstants;

public class FOP_Java_Engine {
	
	/**
	 * Uses passed in XML and XSL file locations, in String form,  to construct a PDF file, using Apache FOP.
	 * 
	 * @param xmlLocation  	Location of the XML/Data file
	 * @param xsltFile			Location of the XSLT/Stylesheet file
	 * @param newPDFFile		Destination location of the PDF, to be created.
	 * @return						void
	*/
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
	/**
	 * Uses passed in XML data and XSL file location to construct a PDF file, using Apache FOP.
	 * 
	 * @param xmlData			XML data string
	 * @param xsltFile			Location of the XSLT/Stylesheet file
	 * @param newPDFFile		Destination location of the PDF, to be created.
	 * @return						void
	*/
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
	/**
	 * Uses passed in XML data and XSL file location to construct a PDF file, using Apache FOP.
	 * 
	 * @param xmlData			XML data string
	 * @param xsltFile			Location of the XSLT/Stylesheet file
	 * @param newPDFFile		Destination location of the PDF, to be created.
	 * @return						void
	*/
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
        	
	        // Configure fopFactory...
            FopFactoryBuilder fopBuilder = new FopFactoryBuilder(new File(".").toURI());  // -- Defines base URI, instead of hard-coding it.            
        	fopBuilder.setStrictFOValidation(false);  // -- Eases on minor things like addition/not-valid attributes added to tags...  <table-cell xxx/>
        	
	        FopFactory fopFactory = fopBuilder.build();
	        
	        // Configure foUserAgent...
	        FOUserAgent foUserAgent = fopFactory.newFOUserAgent();	// -- Used for setting metadata and other settings
	
	        // Setup output
	        OutputStream out = new java.io.FileOutputStream(newPDFFile);
	        out = new java.io.BufferedOutputStream(out);
	
	        try {
	            // -- Construct FOP object with desired output format (PDF)...
	            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);
	
	            // Setup XSLT
	            TransformerFactory factory = TransformerFactory.newInstance();
	            Transformer transformer = factory.newTransformer(new StreamSource(xsltFile));
	
	
	            // -- Resulting SAX events (the generated FO) must be piped through to FOP
	            Result res = new SAXResult(fop.getDefaultHandler());
	
	            // -- Start XSLT transformation and FOP processing
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
