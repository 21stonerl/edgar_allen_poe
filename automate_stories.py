import os
import xml.etree.ElementTree as ET

# Specify the directory where the XML files are located
input_dir = 'documents/github/edgar_allen_poe_xml'
output_dir = 'documents/github/edgar_allen_poe_docs'  # Adjust as needed
toc_file = 'toc.html'  # This will be the main TOC page

# Ensure the output directory exists
os.makedirs(output_dir, exist_ok=True)

# List to hold story titles
story_titles = []

# Loop through XML files in the input directory
for filename in os.listdir(input_dir):
    if filename.endswith('.xml'):
        # Parse the XML file
        tree = ET.parse(os.path.join(input_dir, filename))
        root = tree.getroot()
        
        # Assuming the title is stored in a <title> element under <story>
        for story in root.findall('.//story'):
            title_elem = story.find('title')
            if title_elem is not None:
                story_titles.append(title_elem.text)

# Create the TOC HTML file
with open(os.path.join(output_dir, toc_file), 'w') as toc_f:
    toc_f.write("<!DOCTYPE html>\n<html lang='en'>\n<head>\n")
    toc_f.write("    <meta charset='UTF-8'>\n")
    toc_f.write("    <meta name='viewport' content='width=device-width, initial-scale=1.0'>\n")
    toc_f.write("    <title>Table of Contents</title>\n</head>\n<body>\n")
    toc_f.write("    <h2>Stories</h2>\n    <ul>\n")

    for title in story_titles:
        # Create a filename from the title
        filename = title.lower().replace(" ", "-") + ".html"
        toc_f.write(f"        <li><a href='{filename}'>{title}</a></li>\n")

    toc_f.write("    </ul>\n</body>\n</html>")

# Create individual HTML files for each story
for title in story_titles:
    # Create a filename from the title
    filename = title.lower().replace(" ", "-") + ".html"
    filepath = os.path.join(output_dir, filename)

    # Create a basic HTML file with a TOC link
    with open(filepath, 'w') as f:
        f.write("<!DOCTYPE html>\n<html lang='en'>\n<head>\n")
        f.write("    <meta charset='UTF-8'>\n")
        f.write("    <meta name='viewport' content='width=device-width, initial-scale=1.0'>\n")
        f.write(f"    <title>{title}</title>\n")
        f.write("    <link type='text/css' href='style.css' rel='stylesheet' />\n")
        f.write("</head>\n<body>\n")

        # Add navigation menu
        f.write("""
        <nav>
            <div class="dropDown">
                <a href="toc.html">HOME</a>
            </div>
            <div class="dropDown">
                <a href="../docs/story.html">Short Stories</a>
            </div>
            <div class="dropDown">
                <a href="../docs/char.html">Characters</a>
            </div>
            <div class="dropDown">
                <a href="../docs/themes.html">Themes</a>
            </div>
            <div class="dropDown">
                <a href="../docs/fos.html">Figures of Speech</a>
                <div class="menu">
                    <a href="../docs/alliteration.html">ALLITERATION</a>
                    <div class="section-divider"></div>
                    <a href="../docs/hyperbole.html">HYPERBOLE</a>
                    <div class="section-divider"></div>
                    <a href="../docs/irony.html">IRONY</a>
                    <div class="section-divider"></div>
                    <a href="../docs/onomatopoeia.html">ONOMATOPOEIA</a>
                    <div class="section-divider"></div>
                    <a href="../docs/personification.html">PERSONIFICATION</a>
                    <div class="section-divider"></div>
                    <a href="../docs/simile.html">SIMILE</a>
                    <div class="section-divider"></div>
                    <a href="../docs/metaphor.html">METAPHOR</a>
                    <div class="section-divider"></div>
                    <a href="../docs/imagery.html">IMAGERY</a>
                    <div class="section-divider"></div>
                    <a href="../docs/symbolism.html">SYMBOLISM</a>
                    <div class="section-divider"></div>
                    <a href="../docs/foreshadowing.html">FORESHADOWING</a>
                </div>
            </div>
            <div class="dropDown">
                <a href="../docs/about.html">About</a>
            </div>
        </nav>
        """)

        f.write("    <h1>{}</h1>\n".format(title))
        f.write("    <p>Content of the story goes here.</p>\n")
        f.write(f"    <a href='{toc_file}'>Back to Table of Contents</a>\n")
        f.write("</body>\n</html>")

print("HTML files created successfully.")
