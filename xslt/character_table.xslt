<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
        
        <!-- Define the key at the top level to avoid duplicates -->
        <xsl:key name="charKey" match="char" use="."/>
        
        <!-- Match the root element and start the transformation -->
        <xsl:template match="/stories">
            <html>
                <head>
                    <title>Character Table</title>
                    <style>
                        table {
                        width: 100%;
                        border-collapse: collapse;
                        }
                        th, td {
                        padding: 8px;
                        text-align: left;
                        border: 1px solid #ddd;
                        }
                    </style>
                </head>
                <body>
                    <h1>Character Table</h1>
                    <table>
                        <thead>
                            <tr>
                                <th>Character</th>
                                <th>Story</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Process each story -->
                            <xsl:apply-templates select="story"/>
                        </tbody>
                    </table>
                </body>
            </html>
        </xsl:template>
        
        <!-- Match each story and process characters -->
        <xsl:template match="story">
            <!-- Extract the title of the story -->
            <xsl:variable name="storyTitle" select="info/title"/>
            
            <!-- Process all distinct <char> elements within the story using the key -->
            <xsl:for-each select="descendant::char[count(. | key('charKey', .)[1]) = 1]">
                <tr>
                    <!-- Output the character name (text inside the <char> element) -->
                    <td><xsl:value-of select="."/></td>
                    <!-- Output the title of the story -->
                    <td><xsl:value-of select="$storyTitle"/></td>
                </tr>
            </xsl:for-each>
        </xsl:template>
        
    </xsl:stylesheet>