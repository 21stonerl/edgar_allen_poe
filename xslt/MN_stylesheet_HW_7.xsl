<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
  
    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    <!--<xsl:key name="fos-by-type" match="fos" use="@type"/> -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Figures of Speech Table</title>
                <style>
                    table { width: 100%; border-collapse: collapse; }
                    th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
                    th { background-color: #f2f2f2; }
                </style>
            </head>
            <body>
                <h1>Figures of Speech</h1>
                <table>
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Example</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Apply templates to all <figSpeech> elements in the collection -->
                        <xsl:apply-templates select="$edgar_allen_poe//fos"/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template to process each <figSpeech> element and output as a table row -->
    <xsl:template match="fos">
        <tr>
            <td><xsl:value-of select="@type"/></td>
            <td><xsl:apply-templates/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
