<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:svg="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
<!-- key because the fos were repeating which we do nont want -->
    <xsl:key name="fos-by-type" match="fos" use="@type"/>
    <!-- this makes the actually chart. I am adding comments so I don't confuse myself-->
    <xsl:template match="/">
        <html>
            <head><title>Figures of Speech</title></head>
            <body>
                <h1>Figures of Speech List</h1>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Figure of Speech</th>
                            <th>Definition</th>
                            <th>Example</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Iterate through each unique 'fos' type -->
                        <xsl:for-each select="fos[generate-id() = generate-id(key('fos-by-type', @type)[1])]">
                            <tr>
                                <td><strong><xsl:value-of select="@type"/></strong></td>
                                
                                <!--this is for definitons of the fos but some of the files don't have them all so they won't show up in the chart -->
                                <td>
                                    <xsl:choose>
                                        <xsl:when test="@type = 'simile'">A comparison between two different things using the word 'like' or 'as'.</xsl:when>
                                        <xsl:when test="@type = 'metaphor'">A direct comparison between two things without using 'like' or 'as'.</xsl:when>
                                        <xsl:when test="@type = 'hyperbole'">An exaggerated statement not meant to be taken literally, often for emphasis or effect.</xsl:when>
                                        <xsl:when test="@type = 'personification'">Giving human qualities to non-human things or abstract concepts.</xsl:when>
                                        <xsl:when test="@type = 'imagery'">Descriptive language that appeals to the senses, often used to create vivid mental images.</xsl:when>
                                        <xsl:when test="@type = 'onomatopoeia'">Words that imitate the sounds they describe (e.g., 'buzz', 'bang').</xsl:when>
                                        <xsl:otherwise>Definition not available.</xsl:otherwise>
                                    </xsl:choose>
                                </td>
                                
                                <!-- this SHOULD give example from the text but it's not doing it for some which im not sure why -->
                                <td><xsl:value-of select="substring-before(., '.')"/></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>