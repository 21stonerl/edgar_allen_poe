<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math" version="3.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    
    <!-- Main template for the TOC page -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Collection of Stories</title>
                <link type="text/css" href="style.css" rel="stylesheet"/>
            </head>
            <body>
                <h1>Collection of Stories</h1>
                <h2>Table of Contents</h2>
                <ul>
                    <xsl:apply-templates select="$edgar_allen_poe//story">
                        <xsl:sort select="descendant::year" data-type="text" order="ascending"/>
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template for generating TOC links for stories -->
    <xsl:template match="story">
        <li>
            <strong>
                <a href="{translate(descendant::title, ' ', '-')}.html">
                    <xsl:value-of select="descendant::title"/>
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
    
    <!-- Template for generating individual story pages -->
    <xsl:template match="story" mode="storyPage">
        <xsl:result-document href="{translate(descendant::title, ' ', '-')}.html" method="html">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="descendant::title"/>
                    </title>
                    <link type="text/css" href="style.css" rel="stylesheet"/>
                </head>
                <body>
                    <h1><xsl:value-of select="descendant::title"/></h1>
                    <h2><xsl:value-of select="descendant::year"/></h2>
                    <p><xsl:value-of select="descendant::content"/></p>
                    <a href="toc.html">Back to Table of Contents</a>
                    <hr/>
                    <h3>Collection of Stories</h3>
                    <ul>
                        <xsl:for-each select="../story">
                            <li>
                                <a href="{translate(title, ' ', '-')}.html">
                                    <xsl:value-of select="title"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>
