<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="3.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    
    <!-- Template for the menu bar -->
    <xsl:template name="menu-bar">
        <nav>
            <div class="dropDown">
                <a href="index.html">HOME</a>
            </div>
            <div class="dropDown">
                <a href="genstory2.html">Short Stories</a>
            </div>
            <div class="dropDown">
                <a href="testchar.html">Characters</a>
            </div>
            <div class="dropDown">
                <a href="themes.html">Themes</a>
            </div>
            <div class="dropDown">
                <a href="fos.html">Figures of Speech</a>
                <div class="menu"></div>
            </div>
            <div class="dropDown">
                <a href="about.html">About</a>
                <div class="menu">
                    <a href="team.html">Team</a>
                    <div class="section-divider"></div>
                </div>
            </div>
        </nav>
    </xsl:template>
    
    <!-- Main template for the Collection of Stories page -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Collection of Stories</title>
                <link type="text/css" href="style.css" rel="stylesheet"/>
            </head>
            <body>
                <!-- Include the menu bar only on the main page -->
                <xsl:call-template name="menu-bar"/>
                
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
            <xsl:with-param name="content" select="descendant::content"/>
            <xsl:with-param name="p" select="descendant::content/p"/>
            <xsl:with-param name="img" select="descendant::info/img"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Template to generate individual story pages -->
    <xsl:template name="generate-story-page">
        <xsl:param name="title"/>
        <xsl:param name="year"/>
        <xsl:param name="content"/>
        <xsl:param name="p"/>
        <xsl:param name="img"/>
        <xsl:result-document href="../docs/{translate($title, ' ', '-')}.html" method="html">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="$title"/>
                    </title>
                    <link type="text/css" href="style.css" rel="stylesheet"/>
                </head>
                <body>
                    <!-- Include the menu bar on each story page -->
                    <xsl:call-template name="menu-bar"/>
                    
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
                    
                    <!-- Display the images first (before the paragraphs/content) -->
                    <xsl:for-each select="$img">
                        <img>
                            <xsl:attribute name="src">
                                <xsl:value-of select="@src"/>
                            </xsl:attribute>
                            <xsl:attribute name="alt">
                                <xsl:value-of select="@alt"/>
                            </xsl:attribute>
                        </img>
                    </xsl:for-each>
                    
                    <!-- Display the narrative content of the story -->
                    <div>
                        <xsl:for-each select="$p">
                            <p>
                                <xsl:value-of select="."/>
                            </p>
                        </xsl:for-each>
                    </div>
                    <!-- Process and display the narrative content with FoS color coding -->
                    <div>
                        <xsl:for-each select="$p">
                            <p>
                                <!-- Apply templates for FoS elements within paragraphs -->
                                <xsl:apply-templates select="node()"/>
                            </p>
                        </xsl:for-each>
                    </div>
                    <a href="genstory2.html">Back to Stories</a>
                    <hr/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <!-- Template to process FoS elements within the story -->
    <xsl:template match="fos">
        <span>
            <!-- Apply color coding based on the FoS type -->
            <xsl:choose>
                <xsl:when test="@type='alliteration'">
                    <xsl:attribute name="style">color: blue;</xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="@type='hyperbole'">
                    <xsl:attribute name="style">color: red;</xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="@type='irony'">
                    <xsl:attribute name="style">color: green;</xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="@type='onomatopoeia'">
                    <xsl:attribute name="style">color: purple;</xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="@type='personification'">
                    <xsl:attribute name="style">color: orange;</xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="@type='simile'">
                    <xsl:attribute name="style">color: pink;</xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="@type='metaphor'">
                    <xsl:attribute name="style">color: brown;</xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="@type='imagery'">
                    <xsl:attribute name="style">color: teal;</xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="@type='symbolism'">
                    <xsl:attribute name="style">color: gray;</xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:when test="@type='foreshadowing'">
                    <xsl:attribute name="style">color: yellow;</xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <!-- Template for text nodes to be rendered as normal -->
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
</xsl:stylesheet>
