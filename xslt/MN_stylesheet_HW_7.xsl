<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    
    <!-- Collection of stories -->
    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Figures of Speech Table</title>
                <style>
                    body { font-family: Arial, sans-serif; }
                    .green-square { width: 50px; height: 50px; background-color: green; margin-bottom: 20px; }
                    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                    th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
                    th { background-color: #f2f2f2; }
                </style>
            </head>
            <body>
                <!-- Green square -->
                <div class="green-square"></div>
                
                <!-- Title -->
                <h1>Figures of Speech in Edgar Allan Poe's Stories</h1>
                
                <!-- Table -->
                <table>
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Example</th>
                            <th>Story</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Apply templates to <fos> elements -->
                        <xsl:apply-templates select="$edgar_allen_poe//fos">
                            <xsl:sort select="@type" order="ascending"/>
                        </xsl:apply-templates>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template to process each <fos> -->
    <xsl:template match="fos">
        <tr>
            <!-- Type of figure of speech -->
            <td><xsl:value-of select="@type"/></td>
            
            <!-- Example text -->
            <td><xsl:value-of select="."/></td>
            
            <!-- Story name -->
            <td>
                <xsl:if test="" select="parent::story/title"/>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
