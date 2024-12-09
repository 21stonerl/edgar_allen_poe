<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    <!-- layout.xsl -->
    <xsl:template name="menu-bar">
        
        <!-- -LS This is the menu bar!-->
        <nav>
            <div class="dropDown">
                <a href="index.html">Home</a>
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
                <!--LS Drop down menu options!-->
                <div class="menu">
                    
                </div>
            </div>
            <div class="dropDown">
                <a href="about.html">About</a>
                <div class="menu">
                    <a href="team.html">Team</a>
                    <div class="section-divider"></div>
                </div>
            </div>
        </nav>
        <!-- -LS This is the menu bar!-->
    </xsl:template>
    
    <!-- Global layout template -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Website Title</title>
                <link type="text/css" href="style.css" rel="stylesheet"/>
            </head>
            <body>
                <!-- Include the menu bar -->
                <xsl:call-template name="menu-bar"/>
                
                <!-- Main content will be inserted here -->
                <div class="content">
                    <xsl:apply-templates/>
                </div>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>