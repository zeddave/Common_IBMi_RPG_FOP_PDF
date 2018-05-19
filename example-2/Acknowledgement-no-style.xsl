<?xml version="1.0"?>
<xsl:stylesheet  version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

            <fo:layout-master-set>
                <fo:simple-page-master master-name="main-page" page-height="8.5in" page-width="11in" margin-left="5mm" margin-right="5mm" margin-top="0" margin-bottom="0">
					<fo:region-body  region-name="region-body" margin-top="5mm" margin-bottom="5mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

			<xsl:for-each select="//page">
				<fo:page-sequence master-reference="main-page"  font-family="Helvetica">
			
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
												
													<fo:block  white-space-collapse="false" white-space-treatment="preserve" padding="0"> 
														<xsl:value-of select="."/>
													</fo:block>
													 
												</fo:table-cell>
											</fo:table-row>
										</fo:table-body>
									</fo:table>
								</fo:block>
							</xsl:for-each>
						</fo:block-container>

					</fo:flow>
				</fo:page-sequence>
			</xsl:for-each>
			
			
		</fo:root>
	</xsl:template>
</xsl:stylesheet>
