<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    
    
    <xsl:template match="/">
        <html>
            <head><title>Theme</title></head>
            <body>
                <h1>Theme</h1> 
               <ul> <xsl:apply-templates select="$edgar_allen_poe//story/@theme" mode="theme">
                   <xsl:sort select='//story/@theme'/> 
                    
                </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="//story/@theme" mode="theme">
        <li><xsl:apply-templates select="distinct-values(//story/@theme)">
    </xsl:apply-templates> 
    </li>
   
    </xsl:template>
    
</xsl:stylesheet>