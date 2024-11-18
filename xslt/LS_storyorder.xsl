<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>

    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    <!-- This declares a variable named edgar_allen_poe- select=collection is how we reference the stories -->
    <xsl:key name="story_order" match="story" use="@n"/>
    <!-- <xsl:key name="story_order" This part is declaring a key named story_order. Keys in XSLT allow you to create an index !-->
    <!--  match="story"The match attribute specifies which nodes this key applies to. In this case, it matches any <story> element in your XML documents -->
    <!-- use="@n"/> The use attribute defines the value that will be used to create the key index. Here, @n indicates that the value of the n attribute of each <story> element will be used as the key's value. !-->
    <xsl:template match="/">
        <html>
            <head>
                <title>stories by title</title>
            </head>
            <body>
                <h2>Stories</h2>

                <ul>
                    <xsl:apply-templates select="$edgar_allen_poe//story" mode="toc">
                        <!-- This line applies templates to all <story> elements found in the collection of XML documents stored in the variable $edgar_allen_poe.
The mode="toc" specifies that this application of templates will use the template that matches the <story> elements specifically in the "table of contents" mode. This allows for different processing of the same elements based on the mode. -->
                        <xsl:sort select="@n" data-type="number" order="ascending"/>
                        <!-- This line sorts the selected <story> elements based on their @n attribute.
The data-type="number" attribute indicates that the sorting should treat the @n values as numbers rather than strings, which is important for numerical sorting.
order="ascending" specifies that the sort should be in ascending order (from smallest to largest). -->
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="story" mode="toc">
        <li>
            <strong>
                <xsl:apply-templates select="descendant::title"/>
                <!-- This part applies templates to the <title> element that is a descendant of the current <story> element. The strong tag is used to emphasize the title in bold.
The descendant::title expression looks for any <title> element within the <story>, allowing for flexibility in how titles are structured. -->
            </strong>
            <xsl:text> (n: </xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>)</xsl:text>
        </li>
    </xsl:template>
    <!-- This line sorts the selected <story> elements based on their @n attribute.
The data-type="number" attribute indicates that the sorting should treat the @n values as numbers rather than strings, which is important for numerical sorting.
order="ascending" specifies that the sort should be in ascending order (from smallest to largest).!-->
    <xsl:template match="title">
        <!-- This line declares a template that specifically matches <title> elements in the XML document. Whenever the XSLT processor encounters a <title>, it will use this template to process it. -->
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="l">
        <!-- This line declares a template that specifically matches <l> elements in the XML document. When the XSLT processor encounters an <l> element, it will use this template to process it. -->
        <xsl:value-of select="count(preceding::l) + 1"/>
        <!-- This line counts how many <l> elements precede the current one.
The count(preceding::l) function returns the number of <l> siblings that come before the current <l>. Adding 1 gives the current line number in the sequence.
This is useful for numbering the items dynamically. -->
        <xsl:text>: </xsl:text>
        <!-- adds a colon  -->
        <xsl:apply-templates/>
        <xsl:if test="following-sibling::l">
            <br/>
            <!-- This conditional checks if there are any <l> siblings that follow the current <l> element.
If such siblings exist, it outputs a line break (<br/>). This is useful for formatting, ensuring that each item appears on a new line only if there are more items following it. -->
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
