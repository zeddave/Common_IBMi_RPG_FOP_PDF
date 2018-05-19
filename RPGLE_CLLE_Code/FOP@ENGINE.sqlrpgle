  // *****************************************************************************
  // -- Compile as Module/Service program
  // -- Load into binding directory, QCOMMONBND
  // *****************************************************************************
**FREE
  ctl-opt
    bnddir('QSYS/QC2LE')
    fixnbr(*zoned: *inputpacked)
    option(*nodebugio:*srcstmt)
    nomain;
  // _____________________________________________________________________________
  // -- Variables
  dcl-s error    ind inz(no);
  dcl-c no       const(*off);
  dcl-s noError  ind inz(no);
  dcl-c yes      const(*on);


  // -- Objects
  dcl-s oFile                object(*JAVA: file);
  dcl-s oXSLFile             object(*JAVA: file);
  dcl-s oXMLFile             object(*JAVA: file);
  dcl-s oFOP                 object(*JAVA: fop);
  dcl-s oFOPFactory          object(*JAVA: fopFactory);
  dcl-s oFOPFactoryBuilder   object(*JAVA: fopFactoryBuilder);
  dcl-s oFOUserAgent         object(*JAVA: foUserAgent);
  dcl-s oResult              object(*JAVA: result);
  dcl-s oTransformer         object(*JAVA: transformer);
  dcl-s oTransformerFactory  object(*JAVA: transformerFactory);
  dcl-s oOutputStream        object(*JAVA: outputStream);
  dcl-s oXMLSource           object(*JAVA: source);


  // -- External Procedures...
  dcl-pr @rmvEnvVar      int(10:0)  extproc('Qp0zDltEnv');
    dcl-parm inEnvvar    pointer options(*string) value;
  end-pr;
  dcl-pr @putEnvVar      int(10:0)  extproc('putenv');
    dcl-parm inEnvvar    pointer options(*string) value;
  end-pr;

  /copy QCOMMONSRC,FOP_COPY
  // _____________________________________________________________________________
  // *****************************************************************
  // * Procedure : @FOP_Engine_Initialize
  // *****************************************************************
  dcl-proc @FOP_Engine_Initialize      export;
   dcl-pi  @FOP_Engine_Initialize      ind;
   end-pi;
   // -- Local Variables
   dcl-s  cmd      varchar(5000);
   // ----------------------------------------------------------------
   @rmvEnvVar('CLASSPATH');
   @putEnvVar('CLASSPATH=/home/dancik/lib/dmlib12/common/fop-support/fop-2.2.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/avalon-framework-api-4.3.1.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/avalon-framework-impl-4.3.1.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/batik-all-1.9.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/commons-io-1.3.1.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/commons-logging-1.0.4.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/fontbox-2.0.4.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/serializer-2.7.2.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/servlet-2.2.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/xalan-2.7.2.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/xercesImpl-2.9.1.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/xml-apis-ext-1.3.04.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/xml-apis-1.3.04.jar:' +
                        '/home/dancik/lib/dmlib12/common/fop-support/xmlgraphics-commons-2.2.jar:' +
                        '/home/dancik/lib/dmlib12/common/Common-FOP-Factory.jar');

   // -- Override error-logging (log4j) to .txt file..
   @System$setErr(
    @PrintStream(
     @FileOutputStream(
      @String('/home/dancik/lib/dmlib12/common/FOP_ERR.txt')
     )
    )
   );
   @System$setOut(
    @PrintStream(
     @FileOutputStream(
      @String('/home/dancik/lib/dmlib12/common/FOP_OUT.txt')
     )
    )
   );
   return  noError;
  end-proc;


  // *****************************************************************
  // * Procedure : @FOP_Engine
  // *****************************************************************
  dcl-proc @FOP_Engine      export;
   dcl-pi  @FOP_Engine      ind;
    dcl-parm inXML          pointer options(*string) value;
    dcl-parm inXSL          pointer options(*string) value;
    dcl-parm inPDF          pointer options(*string) value;
   end-pi;
   // -- Local Variables
   dcl-s l_XML             varchar(1000);
   dcl-s l_XSL             varchar(1000);
   dcl-s l_PDF             varchar(1000);
   // ----------------------------------------------------------------

   l_XML = %str(inXML);
   l_XSL = %str(inXSL);
   l_PDF = %str(inPDF);

   // -- Configure fopFactory...
   oFile = @File(@String('.'));
   oFOPFactoryBuilder = @FopFactoryBuilder(@File$toURI(oFile));
   @FactoryBuilder#setStrictFOValidation(oFOPFactoryBuilder: no); // -- Eases on minor things like additional(not-valid) attributes added to tags.
   oFOPFactory = @FactoryBuilder#build(oFOPFactoryBuilder);

   // -- Configure foUserAgent...
   oFOUserAgent = @FopFactory#newFOUserAgent(oFOPFactory);

   // -- Setup output
   oOutputStream = @FileOutputStream(@String(l_PDF));
   oOutputStream = @BufferedOutputStream(oOutputStream);

   // -- Construct FOP object with desired output format (PDF)...
   oFOP = @FopFactory#newFOP(oFOPFactory: @String('application/pdf'): oFOUserAgent: oOutputStream);

   // -- Setup XSLT
   oXSLFile = @File(@String(l_XSL));
   oTransformerFactory = @TransformerFactory#newInstance();
   oTransformer = @TransformerFactory#newTransformer(oTransformerFactory: @StreamSource(oXSLFile) );

   // -- Resulting SAX events (the generated FO) must be piped through to FOP
   oResult = @SAXResult(@Fop#getDefaultHandler(oFOP));

   // -- Start XSLT transformation and FOP processing
   oXMLFile = @File(@String(l_XML));
   oXMLSource = @StreamSource(oXMLFile);
   @Transformer#transform(oTransformer: oXMLSource: oResult);

   @FileOutputStream#close(oOutputStream);

   return  noError;
  end-proc;
  // *****************************************************************
