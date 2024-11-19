<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    <xsl:key name="story_order" match="story" use="@n"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Stories by Title</title>
                <link type="text/css" href="style.css" rel="stylesheet"/>
            </head>
            <body>
                <h2>Stories</h2>
                <ul>
                    <xsl:apply-templates select="$edgar_allen_poe//story" mode="toc">
                        <xsl:sort select="descendant::year" data-type="text" order="ascending"/>
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="story" mode="toc">
        <li>
            <strong>
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat(., '.html')"/> <!-- Assumes title name matches file name -->
                    </xsl:attribute>
                    <xsl:apply-templates select="descendant::title"/>
                </a>
            </strong>
            <ul>
                <li>
                    <xsl:choose>
                        <xsl:when test="descendant::year">
                            <xsl:value-of select="descendant::year"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>(Not Recorded)</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </li>
            </ul>
        </li>
    </xsl:template>
    
    <xsl:template match="title">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="year">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>
