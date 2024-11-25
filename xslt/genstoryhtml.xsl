<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="3.0">
    
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
                <ul>
                    <xsl:apply-templates select="$edgar_allen_poe//story">
                        <xsl:sort select="descendant::year" data-type="text" order="ascending"/>
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template for generating TOC links for stories -->
    <xsl:template match="//story">
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
        
        <!-- Generate individual story pages -->
        <xsl:call-template name="generate-story-page">
            <xsl:with-param name="title" select="descendant::title"/>
            <xsl:with-param name="year" select="descendant::year"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Template to generate individual story pages -->
    <xsl:template name="generate-story-page">
        <xsl:param name="title"/>
        <xsl:param name="year"/>
        <xsl:result-document href="../docs/{translate($title, ' ', '-')}.html" method="html">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="$title"/>
                    </title>
                    <link type="text/css" href="style.css" rel="stylesheet"/>
                </head>
                <body>
                    <h1><xsl:value-of select="$title"/></h1>
                    <h2>
                        <xsl:choose>
                            <xsl:when test="$year">
                                <xsl:value-of select="$year"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>(Not Recorded)</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </h2>
                    <p><xsl:value-of select="../story"/></p>
                    <a href="../docs/storyoutput.html">Back to Stories</a>
                    <hr/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>
