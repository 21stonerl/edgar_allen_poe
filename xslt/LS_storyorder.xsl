<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    
    <!-- key because the fos were repeating which we do nont want -->
    <xsl:key name="story_order" match="story" use="@n"/>
    <!-- this makes the actually chart. I am adding comments so I don't confuse myself-->
    <xsl:template match="/">
        <html>
            <head><title>stories by title</title></head>
            <body>
                <h2>Stories</h2>
                
                <ul><xsl:apply-templates select="$edgar_allen_poe//story" mode="toc">
                  <xsl:sort select='story/n'/> 
                  
                </xsl:apply-templates></ul>
                
                  </body>
            
        </html>
    </xsl:template>
    
    <xsl:template match="story" mode="toc">
        <li><strong><xsl:apply-templates select="descendant::title">
        </xsl:apply-templates></strong>
            <xsl:apply-templates select="story[1]/n[1]"/>
            
        </li>
     
    </xsl:template>
    
    
   
    
    <xsl:template match="story">
        <h2 id="story{preceding::n}">
            
            <xsl:apply-templates select="descendant::title"/>
        </h2>
       
        <xsl:apply-templates select="descendant::story"/>
        
    </xsl:template>
    
    <xsl:template match="title">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    
    <xsl:template match="l">
        <xsl:value-of select="count(preceding::l) + 1"/><xsl:text>: </xsl:text><xsl:apply-templates/>
        <xsl:if test="following-sibling::l"><br/></xsl:if>
           </xsl:template>
    
</xsl:stylesheet>