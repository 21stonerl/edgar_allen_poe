<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    <xsl:key name="story_order" match="story" use="@n"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Stories by Title</title>
            </head>
            <body>
                <h2>Stories</h2>
                
                <ul>
                    <xsl:apply-templates select="$edgar_allen_poe//story" mode="toc">
                        <xsl:sort select="descendant::title" data-type="text" order="ascending"/>
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="story" mode="toc">
        <li>
            <strong>
                <xsl:apply-templates select="descendant::title"/>
            </strong>
            <xsl:text>  </xsl:text>
            <xsl:value-of select="descendant::year"/>
            <xsl:text></xsl:text>
        </li>
    </xsl:template>
    
    <xsl:template match="title">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="l">
        <xsl:value-of select="count(preceding::l) + 1"/>
        <xsl:text>: </xsl:text>
        <xsl:apply-templates/>
        <xsl:if test="following-sibling::l">
            <br/>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>