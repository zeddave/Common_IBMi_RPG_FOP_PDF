<?xml version="1.0"?>
<xsl:stylesheet  version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
 
 	<!-- Styles -->
	<xsl:attribute-set name="header-style">
		<xsl:attribute name="background-color">#ED017F</xsl:attribute>
		<xsl:attribute name="color">#FFFFFF</xsl:attribute>
		<xsl:attribute name="border">.5px solid #4D4D4F</xsl:attribute>
		<xsl:attribute name="font-weight">700</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>
		<xsl:attribute name="padding-left">1mm</xsl:attribute>
	</xsl:attribute-set>			
	<xsl:attribute-set name="body-grid-style-odd">
		<xsl:attribute name="border">.5px solid #4D4D4F</xsl:attribute>
		<xsl:attribute name="background-color">#EFEFEF</xsl:attribute>
	</xsl:attribute-set>			
	<xsl:attribute-set name="body-grid-style-even">
		<xsl:attribute name="border">.5px solid #4D4D4F</xsl:attribute>
	</xsl:attribute-set>			
	
<!--	
	  <xsl:include href="extras/Acknowledgement-styles.xsl" />   
-->

 
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

            <fo:layout-master-set>
                <fo:simple-page-master master-name="main-page" page-height="8.5in" page-width="11in" margin-left="5mm" margin-right="5mm" margin-top="0" margin-bottom="0">
					<fo:region-body  region-name="region-body" margin-top="5mm" margin-bottom="5mm"/>
					<fo:region-before region-name="header"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

			<xsl:for-each select="//page">
				<fo:page-sequence master-reference="main-page"  font-family="Helvetica">
			
					<!-- Header Section -->
					<fo:static-content flow-name="header">
					
						<!-- Watermark -->	
						<fo:block-container absolute-position="fixed" left="172mm" top="96mm">
							<fo:block>
								<fo:external-graphic src="/home/dancik/lib/dmlib12/common/example-2/extras/Bacon-in-Light-Pink.png" width="300px" content-width="scale-to-fit" scaling="uniform" content-height="scale-to-fit"/>
							</fo:block>
						</fo:block-container>	
					
						<!-- Surround Top headers. -->	
						<fo:block-container absolute-position="fixed" left="0" top="35mm" right="5mm">
							<fo:block>     
								<fo:table table-layout="fixed" width="100%">
									<fo:table-column column-width="13mm"/>									
									<fo:table-column column-width="86mm"/>									
									<fo:table-column column-width="2mm"/>									
									<fo:table-column column-width="86mm"/>									
									<fo:table-column column-width="2mm"/>									
									<fo:table-column column-width="86mm"/>									
									<fo:table-body>
										<fo:table-row height="6mm">
											<fo:table-cell> <fo:block> </fo:block> </fo:table-cell>
											<fo:table-cell border=".5px solid" border-color="#4D4D4F" background-color="#ED017F" color="#FFFFFF" font-weight="700"  display-align="center" padding-left="1mm">
												<fo:block> BILL TO:</fo:block> 
											</fo:table-cell>
											<fo:table-cell> <fo:block> </fo:block> </fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> SHIP TO:</fo:block> 
											</fo:table-cell>
											<fo:table-cell> <fo:block> </fo:block> </fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> REMIT TO:</fo:block> 
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="23mm">
											<fo:table-cell> <fo:block> </fo:block> </fo:table-cell>
											<fo:table-cell border=".5px solid" border-color="#4D4D4F">
												<fo:block> </fo:block> 
											</fo:table-cell>
											<fo:table-cell> <fo:block> </fo:block> </fo:table-cell>
											<fo:table-cell border=".5px solid" border-color="#4D4D4F">
												<fo:block> </fo:block> 
											</fo:table-cell>
											<fo:table-cell> <fo:block> </fo:block> </fo:table-cell>
											<fo:table-cell border=".5px solid" border-color="#4D4D4F">
												<fo:block> </fo:block> 
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</fo:block-container>	
						
						
						<!-- Surround mid-set of headers. -->	
						<fo:block-container absolute-position="fixed" left="0" right="1mm" top="67mm">
							<fo:block>     
								<fo:table table-layout="fixed" width="100%">
									<fo:table-column column-width="2mm"/>									
									<fo:table-column column-width="25mm"/>									
									<fo:table-column column-width="25mm"/>									
									<fo:table-column column-width="25mm"/>									
									<fo:table-column column-width="47mm"/>									
									<fo:table-column column-width="20mm"/>									
									<fo:table-column column-width="45mm"/>									
									<fo:table-column column-width="20mm"/>									
									<fo:table-column column-width="proportional-column-width(1)"/>									
									<fo:table-body>
										<fo:table-row height="6mm">
											<fo:table-cell> <fo:block> </fo:block> </fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> ORD DATE</fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> DATE REQ </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> SHIP VIA </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> F.O.B. </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> ACCT# </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> P.O.#/JOB</fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> TERMS </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> ORDER REFERENCES </fo:block> 
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row height="9mm">
											<fo:table-cell> <fo:block> </fo:block> </fo:table-cell>
											<fo:table-cell border=".5px solid" border-color="#4D4D4F" number-columns-spanned="8">
												<fo:block> </fo:block> 
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</fo:block-container>	

						<!-- Surround Details section and headers. -->	
						<fo:block-container absolute-position="fixed" left="0" right="1mm" top="84mm">
							<fo:block>     
								<fo:table table-layout="fixed" width="100%">
									<fo:table-column column-width="2mm"/>									
									<fo:table-column column-width="13mm"/>									
									<fo:table-column column-width="53mm"/>									
									<fo:table-column column-width="79mm"/>									
									<fo:table-column column-width="25mm"/>									
									<fo:table-column column-width="25mm"/>									
									<fo:table-column column-width="17mm"/>									
									<fo:table-column column-width="32mm"/>									
									<fo:table-column column-width="proportional-column-width(1)"/>									
									<fo:table-body>
										<fo:table-row height="6mm">
											<fo:table-cell> <fo:block> </fo:block> </fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> LINE </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> ITEM </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> DESCRIPTION </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> SHIP DATE </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> QTY ORD</fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> UOM </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> UNIT PRICE </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="header-style">
												<fo:block> PRICE </fo:block> 
											</fo:table-cell>
										</fo:table-row>
										
										<fo:table-row height="84.5mm">
										
											<fo:table-cell> <fo:block> </fo:block> </fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="body-grid-style-odd">
												<fo:block> </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="body-grid-style-even">
												<fo:block> </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="body-grid-style-odd">
												<fo:block> </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="body-grid-style-even">
												<fo:block> </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="body-grid-style-odd">
												<fo:block> </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="body-grid-style-even">
												<fo:block> </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="body-grid-style-odd">
												<fo:block> </fo:block> 
											</fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="body-grid-style-even">
												<fo:block> </fo:block> 
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</fo:block-container>	
					</fo:static-content>

				
					<!-- Body Section -->
					<fo:flow flow-name="region-body">
						<fo:block-container absolute-position="fixed" bottom="0" left="2.5mm" right="0" top="2mm">
							<xsl:for-each select="line">
								<fo:block font-family="Courier New, Courier, monospace" font-size="12pt">     
									<fo:table table-layout="fixed" width="100%">
										<fo:table-column column-width="proportional-column-width(1)"/>									
										<fo:table-body>
											<fo:table-row height="1mm">
												<fo:table-cell height="5px" padding-top="-1.20px" padding-bottom="-1.20px"> 
													<xsl:choose>	
														<xsl:when test="contains(., 'BILL TO:')">
															<xsl:attribute name="font-weight">700</xsl:attribute>	
															<xsl:attribute name="color">#ffffff</xsl:attribute>	
														</xsl:when>
														<xsl:when test="contains(., 'LINE#----')">
															<xsl:attribute name="font-weight">700</xsl:attribute>	
															<xsl:attribute name="color">#ffffff</xsl:attribute>	
															<xsl:attribute name="padding-top">-1px</xsl:attribute>	
															<xsl:attribute name="padding-bottom">-1px</xsl:attribute>	
														</xsl:when>
															<xsl:otherwise>	
															<xsl:attribute name="padding-top">-1.20px</xsl:attribute>	
															<xsl:attribute name="padding-bottom">-1.20px</xsl:attribute>	
															</xsl:otherwise>	
													</xsl:choose>	
												
													<fo:block  white-space-collapse="false" white-space-treatment="preserve" padding="0"> 
														
														<xsl:choose>	
															<xsl:when test="contains(., 'BILL TO:')">
																<xsl:text> </xsl:text>
															</xsl:when>
															<xsl:when test="contains(., 'ORDER DT')">
																<xsl:text> </xsl:text>
															</xsl:when>
															<xsl:when test="contains(., 'LINE#----')">
																<xsl:text> </xsl:text>
															</xsl:when>
															<xsl:otherwise>	
																<xsl:value-of select="."/>
															</xsl:otherwise>	
														</xsl:choose>	
														
													</fo:block> 
												</fo:table-cell>
											</fo:table-row>
										</fo:table-body>
									</fo:table>
								</fo:block>
							</xsl:for-each>
						</fo:block-container>

						<!-- LOGO -->
						<fo:block-container absolute-position="fixed" left="2.5mm" top="2mm" width="575px" height="90px" background-color="#ffffff">
							<fo:block>
								<fo:external-graphic content-width="scale-down-to-fit" scaling="uniform" content-height="scale-down-to-fit">
									<xsl:attribute name="src">/home/dancik/lib/dmlib12/common/example-2/extras/powerup18.jpg</xsl:attribute>
									<xsl:attribute name="height">90px</xsl:attribute>
								</fo:external-graphic>	
							</fo:block>
						</fo:block-container>	


					</fo:flow>
				</fo:page-sequence>
			</xsl:for-each>
			
			
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
