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
                <main class="background-container">
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
    
    <xsl:template match="//story">
        <li>
            <!-- Title and Year in the same line with a space and colon between them -->
            <strong>
                <a href="{translate(descendant::title, ' ', '-')}.html">
                    <xsl:value-of select="descendant::title"/>
                </a>
            </strong>
            <span> </span> <!-- Add colon and space between title and year -->
            
            <xsl:choose>
                <xsl:when test="descendant::year">
                    <xsl:value-of select="descendant::year"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>(Not Recorded)</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            
            <!-- Add a space and a colon between year and theme -->
            <xsl:choose>
                <xsl:when test="@theme">
                    <span>- Theme: </span> <!-- Colon and space between year and theme -->
                    <xsl:value-of select="concat(upper-case(substring(@theme, 1, 1)), translate(substring(@theme, 2), '_', ' '))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text> (Theme: Not Recorded)</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
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
        <xsl:param name="theme"/>
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
                        
                        <!-- Display the theme with space between label and value -->
                        <p>
                            <xsl:choose>
                                <xsl:when test="$theme">
                                    <strong>Theme: </strong> 
                                    <!-- Capitalize the first letter and replace underscores with spaces -->
                                    <xsl:value-of select="concat(upper-case(substring($theme, 1, 1)), lower-case(substring($theme, 2)))"/>
                                    <xsl:value-of select="translate(substring($theme, 2), '_', ' ')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>(No theme recorded)</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </p>
                        
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
                                    </p> <!-- Ensuring closing of the <p> tag -->
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
                                    </p> <!-- Ensuring closing of <p> here as well -->
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
                    <xsl:if test="not(contains(., '. '))">
                        <span class="alliteration"> </span> <!-- Add space if no space after period -->
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:when test="@type='hyperbole'">
                <span class="hyperbole">
                    <xsl:value-of select="."/>
                    <xsl:if test="not(contains(., '. '))">
                        <span class="hyperbole"> </span>
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:when test="@type='irony'">
                <span class="irony">
                    <xsl:value-of select="."/>
                    <xsl:if test="not(contains(., '. '))">
                        <span class="irony"> </span>
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:when test="@type='onomatopoeia'">
                <span class="onomatopoeia">
                    <xsl:value-of select="."/>
                    <xsl:if test="not(contains(., '. '))">
                        <span class="onomatopoeia"> </span>
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:when test="@type='personification'">
                <span class="personification">
                    <xsl:value-of select="."/>
                    <xsl:if test="not(contains(., '. '))">
                        <span class="personification"> </span>
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:when test="@type='simile'">
                <span class="simile">
                    <xsl:value-of select="."/>
                    <xsl:if test="not(contains(., '. '))">
                        <span class="simile"> </span>
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:when test="@type='metaphor'">
                <span class="metaphor">
                    <xsl:value-of select="."/>
                    <xsl:if test="not(contains(., '. '))">
                        <span class="metaphor"> </span>
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:when test="@type='imagery'">
                <span class="imagery">
                    <xsl:value-of select="."/>
                    <xsl:if test="not(contains(., '. '))">
                        <span class="imagery"> </span>
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:when test="@type='symbolism'">
                <span class="symbolism">
                    <xsl:value-of select="."/>
                    <xsl:if test="not(contains(., '. '))">
                        <span class="symbolism"> </span>
                    </xsl:if>
                </span>
            </xsl:when>
            <xsl:when test="@type='foreshadowing'">
                <span class="foreshadowing">
                    <xsl:value-of select="."/>
                    <xsl:if test="not(contains(., '. '))">
                        <span class="foreshadowing"> </span>
                    </xsl:if>
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
