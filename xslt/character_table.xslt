<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema-datatypes">
    
    <!-- Define a key for unique character names, normalizing case and removing special characters -->
    <xsl:key name="uniqueCharacters" match="char" use="translate(translate(., '’‘', ''), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')" />
    
    <!-- Match the root element (story collection) -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Character Story Links</title>
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
                        <!-- Load all the XML files from the 'edgar_allen_poe' collection -->
                        <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
                        
                        <!-- Iterate through all the XML files in the collection -->
                        <xsl:for-each select="$edgar_allen_poe/story">
                            <xsl:variable name="storyTitle" select="info/title/text()" />
                            
                            <!-- Iterate through each character in the story -->
                            <xsl:for-each select="content/p/char">
                                <!-- Normalize the character's name (remove apostrophes, spaces, and make lowercase) -->
                                <xsl:variable name="normalizedCharacter" select="translate(translate(., '’‘', ''), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')" />
                                
                                <!-- Remove punctuation at the end of the name (e.g., apostrophes) -->
                                <xsl:variable name="cleanedCharacter" select="translate($normalizedCharacter, '.,;?!:’‘', '')" />
                                
                                <!-- Capitalize the first letter of each word in the character's name -->
                                <xsl:variable name="finalCharacter">
                                    <xsl:call-template name="capitalizeWords">
                                        <xsl:with-param name="inputString" select="$cleanedCharacter"/>
                                    </xsl:call-template>
                                </xsl:variable>
                                
                                <!-- Use key to retrieve all occurrences of the normalized character -->
                                <xsl:variable name="characterNode" select="key('uniqueCharacters', $normalizedCharacter)" />
                                
                                <!-- Only display this character if it's the first occurrence (unique) -->
                                <xsl:if test="generate-id(.) = generate-id($characterNode[1])">
                                    <tr>
                                        <td>
                                            <!-- Display the final character's name -->
                                            <xsl:value-of select="$finalCharacter" />
                                        </td>
                                        <td>
                                            <!-- Create a link to the story -->
                                            <a href="{concat($storyTitle, '.html')}">
                                                <xsl:value-of select="$storyTitle" />
                                            </a>
                                        </td>
                                    </tr>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template to capitalize the first letter of each word -->
    <xsl:template name="capitalizeWords">
        <xsl:param name="inputString"/>
        <xsl:variable name="words" select="tokenize($inputString, '\s+')" />
        <xsl:for-each select="$words">
            <xsl:value-of select="concat(upper-case(substring(., 1, 1)), substring(., 2))" />
            <xsl:if test="position() != last()">
                <xsl:text> </xsl:text> <!-- Add a space between words -->
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
