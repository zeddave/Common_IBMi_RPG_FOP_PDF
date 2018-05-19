**FREE
  // *****************************************************************
  ctl-opt
     dftactgrp(*no)
     actgrp(*CALLER)
     bnddir('QSYS/QC2LE')
     fixnbr(*zoned: *inputpacked)
     option(*nodebugio:*srcstmt);


  // -- Fields...
  dcl-s errorMessage   varchar(2000);
  dcl-s host           varchar(500);
  dcl-s message        varchar(2000);
  dcl-s messageType    varchar(500);
  dcl-s subject        varchar(500);
  dcl-s oFOPEngine     object(*JAVA: FOP_Java_Engine);

  dcl-c FOP_Java_Engine    'common.fop.FOP_Java_Engine';

  // -- External Procedures/Wrappers
  // ---- FOP_Java_Engine.build(File, File, File)
  dcl-pr @FOP_Java_Engine$build   extproc(*JAVA: FOP_Java_Engine: 'build') static;
    dcl-parm inXMLFile            object(*JAVA: File) const;
    dcl-parm inXSLTFile           object(*JAVA: File) const;
    dcl-parm inNewPDFfile         object(*JAVA: File) const;
  end-pr;
  // -- Java Constants and Class/Method definitions
  /copy qcommonsrc,FOP_COPY

  // _______________________________________________________________

  @FOP_Java_Engine$build(
   @File(@String('/home/dancik/lib/dmlib12/common/example-2/Acknowledgement.xml')):
   @File(@String('/home/dancik/lib/dmlib12/common/example-2/Acknowledgement.xsl')):
   @File(@String('/home/dancik/lib/dmlib12/common/example-2/Acknowledgement-java.pdf'))
  );

  *inlr = *on;
  // *****************************************************************
