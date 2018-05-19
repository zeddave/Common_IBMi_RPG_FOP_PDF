<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:template name="banner">
		<fo:block-container absolute-position="fixed" left="5mm" right="15mm" top="40mm" height="200px" background-color="blue">
			<fo:block margin-top="5mm"> 
				<fo:external-graphic height="160px" content-width="scale-down-to-fit" scaling="uniform" content-height="scale-down-to-fit">
					<xsl:attribute name="src">JW Quote.jpg</xsl:attribute>
				</fo:external-graphic>	
			</fo:block>
		</fo:block-container>
 	</xsl:template>

</xsl:stylesheet>