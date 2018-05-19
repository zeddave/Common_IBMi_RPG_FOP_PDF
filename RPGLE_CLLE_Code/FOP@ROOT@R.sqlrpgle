**FREE
  // *****************************************************************
  ctl-opt
    dftactgrp(*no)
    actgrp(*CALLER)
    bnddir('QSYS/QC2LE')
    fixnbr(*zoned: *inputpacked)
    option(*nodebugio:*srcstmt);
  // _______________________________________________________________

  // -- Variables
  dcl-s file_PDF  varchar(1000);
  dcl-s file_XML  varchar(1000);
  dcl-s file_XSL  varchar(1000);
  dcl-c no        const(*off);
  dcl-c yes       const(*on);


  // -- Objects
  dcl-s oXSLFile             object(*JAVA: file);
  dcl-s oXMLFile             object(*JAVA: file);
  dcl-s oFOP                 object(*JAVA: fop);
  dcl-s oFOPFactory          object(*JAVA: fopFactory);
  dcl-s oFOPFactoryBuilder   object(*JAVA: fopFactoryBuilder);
  dcl-s oFOUserAgent         object(*JAVA: foUserAgent);
  dcl-s oOutputStream        object(*JAVA: outputStream);
  dcl-s oResult              object(*JAVA: result);
  dcl-s oTransformer         object(*JAVA: transformer);
  dcl-s oTransformerFactory  object(*JAVA: transformerFactory);
  dcl-s oUri                 object(*JAVA: uri);
  dcl-s oXMLSource           object(*JAVA: source);

  // -- Java Constants and Class/Method definitions
  /copy qcommonsrc,FOP_COPY
  // _____________________________________________________________________________
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

  file_PDF = '/home/dancik/lib/dmlib12/common/example-2/Acknowledgement-root.pdf';
  file_XML = '/home/dancik/lib/dmlib12/common/example-2/Acknowledgement.xml';
  file_XSL = '/home/dancik/lib/dmlib12/common/example-2/Acknowledgement.xsl';


  // -- Configure fopFactory...
  oUri = @File$toURI(@File(@String('.'))); // -- Defines base URI, instead of hard-coding it.
  oFOPFactoryBuilder = @FopFactoryBuilder(oUri);
  @FactoryBuilder#setStrictFOValidation(oFOPFactoryBuilder: no); // -- Eases on minor things like additional(not-valid) attributes added to tags.
  oFOPFactory = @FactoryBuilder#build(oFOPFactoryBuilder);

  // -- Configure foUserAgent...
  oFOUserAgent = @FopFactory#newFOUserAgent(oFOPFactory);  // -- Used for setting metadata and other settings

  // -- Setup output
  oOutputStream = @FileOutputStream(@String(file_PDF));
  oOutputStream = @BufferedOutputStream(oOutputStream);

  // -- Construct FOP object with desired output format (PDF)...
  oFOP = @FopFactory#newFOP(oFOPFactory: @String('application/pdf'): oFOUserAgent: oOutputStream);

  // -- Setup XSLT
  oXSLFile = @File(@String(file_XSL));
  oTransformerFactory = @TransformerFactory#newInstance();
  oTransformer = @TransformerFactory#newTransformer(oTransformerFactory: @StreamSource(oXSLFile) );

  // -- Resulting SAX events (the generated FO) must be piped through to FOP
  oResult = @SAXResult(@Fop#getDefaultHandler(oFOP));

  // -- Start XSLT transformation and FOP processing
  oXMLFile = @File(@String(file_XML));
  oXMLSource = @StreamSource(oXMLFile);
  @Transformer#transform(oTransformer: oXMLSource: oResult);

  @FileOutputStream#close(oOutputStream);

  *inlr = *on;
