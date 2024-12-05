<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- Key to uniquely identify characters based on their ref attribute -->
    <xsl:key name="uniqueCharacters" match="char" use="normalize-space(translate(@ref, '.,;?!:', ''))" />
    
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
    
    <!-- Root template match -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Character and Story Links</title>
                <link type="text/css" href="style.css" rel="stylesheet"/>
                <style>
                    table {
                    width: 100%;
                    border-collapse: collapse;
                    }
                    table, th, td {
                    border: 1px solid black;
                    }
                    th, td {
                    padding: 10px;
                    text-align: left;
                    }
                    th {
                    background-color: #f2f2f2;
                    }
                </style>
            </head>
            <body>
                <!-- Include the menu bar only on the main page -->
                <xsl:call-template name="menu-bar"/>
                <h1>Character and Story Links</h1>
                <table>
                    <thead>
                        <tr>
                            <th>Character</th>
                            <th>Story</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Loop through all story documents -->
                        <xsl:for-each select="collection('../xml/?select=*.xml')/story">
                            <xsl:variable name="storyTitle" select="info/title/text()" />
                            
                            <!-- Loop through all characters in the current story, ensuring uniqueness by their 'ref' attribute -->
                            <xsl:for-each select="content/p/char[generate-id() = generate-id(key('uniqueCharacters', normalize-space(translate(@ref, '.,;?!:', '')))[1])]">
                                <xsl:variable name="finalCharacter" select="normalize-space(@ref)" />
                                
                                <!-- Output each unique character and story, capitalize only the first letter -->
                                <tr>
                                    <!-- Capitalize only the first letter of the character name -->
                                    <td>
                                        <xsl:value-of select="concat(upper-case(substring($finalCharacter, 1, 1)), substring($finalCharacter, 2))" />
                                    </td>
                                    <td>
                                        <!-- Generate story link with hyphenated format -->
                                        <a href="{concat(translate($storyTitle, ' ', '-'), '.html')}">
                                            <xsl:value-of select="$storyTitle" />
                                        </a>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>
