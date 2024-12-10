<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="3.0">
    
    <xsl:import href="menubar.xsl"/>
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <!-- Variable to store the collection of XML data -->
    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    
    <!-- Create a key for Figures of Speech -->
    <xsl:key name="fosKey" match="fos" use="@type"/>
    
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
                
                <!-- Start main content section -->
                <main>
                    <h1>Collection of Stories</h1>
                    <ul>
                        <xsl:apply-templates select="$edgar_allen_poe//story">
                            <xsl:sort select="descendant::year" data-type="text" order="ascending"/>
                        </xsl:apply-templates>
                    </ul>
                </main>
                
                <!-- Copyright Footer -->
                <footer class="copyright">
                    <p>Edgar Allan Poe Short Stories Website © 2024 by Lillian Stoner, Abigail Dopkosky, Michael Noah, Natalie Wright, Brandon Evans is licensed under CC BY-NC 4.0</p>
                </footer>
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
            <xsl:with-param name="characters" select="descendant::characters/char"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Template to generate individual story pages -->
    <xsl:template name="generate-story-page">
        <xsl:param name="title"/>
        <xsl:param name="year"/>
        <xsl:param name="content"/>
        <xsl:param name="p"/>
        <xsl:param name="img"/>
        <xsl:param name="characters"/>
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
                    
                    <!-- Main content section -->
                    <main>
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
                        
                        <!-- Image section -->
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
                        
                        <!-- Content and Columns Section -->
                        <div class="content-columns">
                            <!-- Left column for text -->
                            <div class="left-column">
                                <xsl:for-each select="$p">
                                    <p>
                                        <xsl:apply-templates select="."/>
                                    </p>
                                </xsl:for-each>
                            </div>
                            
                            <!-- Right column for Key -->
                            <div class="right-column">
                                <h3>Key: Figures of Speech</h3>
                                <!-- Iterate through unique FoS types -->
                                <xsl:for-each select="$content//fos[generate-id() = generate-id(key('fosKey', @type)[1])]">
                                    <p>
                                        <xsl:choose>
                                            <xsl:when test="@type='alliteration'">
                                                <span class="alliteration">Alliteration</span>: Repetition of consonant sounds.
                                            </xsl:when>
                                            <xsl:when test="@type='hyperbole'">
                                                <span class="hyperbole">Hyperbole</span>: Exaggeration for emphasis or effect.
                                            </xsl:when>
                                            <xsl:when test="@type='irony'">
                                                <span class="irony">Irony</span>: A contrast between expectation and reality.
                                            </xsl:when>
                                            <xsl:when test="@type='onomatopoeia'">
                                                <span class="onomatopoeia">Onomatopoeia</span>: Words that imitate sounds.
                                            </xsl:when>
                                            <xsl:when test="@type='personification'">
                                                <span class="personification">Personification</span>: Giving human qualities to inanimate objects.
                                            </xsl:when>
                                            <xsl:when test="@type='simile'">
                                                <span class="simile">Simile</span>: A comparison using "like" or "as".
                                            </xsl:when>
                                            <xsl:when test="@type='metaphor'">
                                                <span class="metaphor">Metaphor</span>: A direct comparison without using "like" or "as".
                                            </xsl:when>
                                            <xsl:when test="@type='imagery'">
                                                <span class="imagery">Imagery</span>: Language that creates a vivid picture in the mind.
                                            </xsl:when>
                                            <xsl:when test="@type='symbolism'">
                                                <span class="symbolism">Symbolism</span>: Using symbols to represent ideas or qualities.
                                            </xsl:when>
                                            <xsl:when test="@type='foreshadowing'">
                                                <span class="foreshadowing">Foreshadowing</span>: A hint or clue about what will happen later.
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <span class="unknown">Unknown FoS</span>: No description available.
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </p>
                                </xsl:for-each>
                            </div>
                        </div>
                        
                        <!-- Back link -->
                        <a href="genstory2.html">Back to Stories</a>
                        <hr/>
                    </main>
                    
                    <!-- Copyright Footer -->
                    <footer class="copyright">
                        <p>Edgar Allan Poe Short Stories Website © 2024 by Lillian Stoner, Abigail Dopkosky, Michael Noah, Natalie Wright, Brandon Evans is licensed under CC BY-NC 4.0</p>
                    </footer>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Template to wrap each FoS in a span tag for the main content -->
    <xsl:template match="p">
        <p>
            <xsl:apply-templates select="text()"/>
            <!-- Wrap fos elements in span tags for styling -->
            <xsl:apply-templates select="fos"/>
        </p>
    </xsl:template>
    
    <!-- Template to wrap FoS elements with a span and class for styling -->
    <xsl:template match="fos">
        <xsl:choose>
            <xsl:when test="@type='alliteration'">
                <span class="alliteration">
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <xsl:when test="@type='hyperbole'">
                <span class="hyperbole">
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <xsl:when test="@type='irony'">
                <span class="irony">
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <xsl:when test="@type='onomatopoeia'">
                <span class="onomatopoeia">
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <xsl:when test="@type='personification'">
                <span class="personification">
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <xsl:when test="@type='simile'">
                <span class="simile">
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <xsl:when test="@type='metaphor'">
                <span class="metaphor">
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <xsl:when test="@type='imagery'">
                <span class="imagery">
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <xsl:when test="@type='symbolism'">
                <span class="symbolism">
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <xsl:when test="@type='foreshadowing'">
                <span class="foreshadowing">
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="unknown">
                    <xsl:value-of select="."/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
