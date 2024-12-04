<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- Key to uniquely identify characters based on their ref attribute -->
    <xsl:key name="uniqueCharacters" match="char" use="normalize-space(translate(@ref, '.,;?!:', ''))" />
    
    <!-- Root template match -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Character and Story Links</title>
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
                <h1>Character and Story Links</h1>
                <table>
                    <thead>
                        <tr>
                            <th>Character</th>
                            <th>Story</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Loop through all stories -->
                        <xsl:for-each select="collection('../xml/?select=*.xml')/story">
                            <xsl:variable name="storyTitle" select="info/title/text()" />
                            
                            <!-- Loop through all characters in this story, ensuring uniqueness by their 'ref' attribute -->
                            <xsl:for-each select="content/p/char[generate-id() = generate-id(key('uniqueCharacters', normalize-space(translate(@ref, '.,;?!:', '')))[1])]">
                                <xsl:variable name="finalCharacter" select="normalize-space(@ref)" />
                                
                                <!-- Output each unique character and story -->
                                <tr>
                                    <td><xsl:value-of select="$finalCharacter" /></td>
                                    <td>
                                        <a href="{concat($storyTitle, '.html')}">
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
