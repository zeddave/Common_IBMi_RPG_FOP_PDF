<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:template match="/">  
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

            <fo:layout-master-set>
                <fo:simple-page-master master-name="main-page" page-width="8.5in" page-height="11in" margin-left="5mm" margin-right="0" margin-top="0" margin-bottom="0">
                   	<fo:region-body  region-name="main-page-body" margin-top="5mm" margin-bottom="5mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>


			<fo:page-sequence master-reference="main-page">
			
				<!-- Body Section -->
				<fo:flow flow-name="main-page-body">
					<fo:block-container>
						<fo:block>     
					  		<xsl:value-of select="data/line"/>
						</fo:block>
					</fo:block-container>
 				</fo:flow>
 				
			</fo:page-sequence>				
			
        </fo:root>
	</xsl:template>  

</xsl:stylesheet>