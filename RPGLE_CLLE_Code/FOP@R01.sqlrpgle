**FREE
 // *****************************************************************
 ctl-opt
    dftactgrp(*no)
    actgrp(*CALLER)
    bnddir('QCOMMONBND')
    fixnbr(*zoned: *inputpacked)
    option(*nodebugio:*srcstmt);
 // _______________________________________________________________


 // -------------------------------------------------------------
 // External Procedures.
 // -------------------------------------------------------------
 // -- Procedure : @FOP_Engine_Initialize
 dcl-pr  @FOP_Engine_Initialize   ind   end-pr;
 // -- Procedure : @FOP_Engine
 dcl-pr  @FOP_Engine      ind;
  dcl-parm inXML          pointer options(*string) value;
  dcl-parm inXSL          pointer options(*string) value;
  dcl-parm inPDF          pointer options(*string) value;
 end-pr;
 // _______________________________________________________________*


 @FOP_Engine_Initialize();
 @FOP_Engine(
  '/home/dancik/lib/dmlib12/common/example-1/HelloWorld.xml':
  '/home/dancik/lib/dmlib12/common/example-1/HelloWorld.xsl':
  '/home/dancik/lib/dmlib12/common/example-1/HelloWorld.pdf'
 );

 *inlr = *on;
