# mir-navigation-plugin

Includes an extended navigation for newspapers and series. It based on a widen solr handling for 
parent documents (root field).

The plugin provides the extended solr handling for series (solr-navigation.xsl). In frontend
context there is a series layout with a panel that shows the navigation. 

## Installation instructions (As mir-enduser)

1. Download the project from this repository and place it on your computer

2. Unzip the downloaded file to create a development project folder location 

3. Customize general mycore.properties(http://www.mycore.de/documentation/getting_started/mcr_properties.html) for this plugin (/mir-navigation-plugin/src/main/resources/config/mir-navigation-plugin/mycore.properties)

4. Create jar file with maven => mvn clean && mvn install

5. Copy the created jar file from target (/mir-navigation-plugin/target) to mycore home lib 

(Windows Systems C:\Users\User\AppData\Local\MyCoRe\mirapplication\lib) <br />
(Linux Systems /home/user/.mycore/mirapplication/lib)

6. Readjust solr schema with new root parameter (http://www.mycore.de/documentation/getting_started/solr_7.html)

Add the following lines to schema.xml 

		<field name="root" type="string" /> <!-- up all the ancestors -->

Reload the core via solr admin web interface 
 -> you can do a quickcheck via schema menu item (root field should be there now)
 
7. Reindex solr via mir web cli (SOLR Commands -> rebuild solr metadata and content index)
-> solr entries should provide the extended handling for parent documents now (root field) 

8. Have fun 
-> Add a navigation.xml via file upload to the (series/newspaper) root document 
-> Add the files via file upload you have referenced via navigation.xml

Example:

		<item ref="go/exampleSeries/index.xml" banner="go/exampleSeries/banner_sgo.png"
		  root="true">
		  <label xml:lang="de">Example on navigaton Series</label>
		  <label xml:lang="en">Navigationsbeispiel für Series</label>
		  <item id="exampleSeries/index.xml" ref="go/exampleSeries/index.xml">
		    <label xml:lang="de">Über uns</label>
		    <label xml:lang="en">About us</label>
		  </item>
		  <item id="exampleSeries/2018/01" ref="go/exampleSeries/2018/01">
		    <label xml:lang="de">Aktuelles Heft</label>
		    <label xml:lang="en">Current Issue</label>
		  </item>
		  <item id="exampleSeries" ref="go/exampleSeries">
		    <label xml:lang="de">Archiv</label>
		    <label xml:lang="en">Archive</label>
		  </item>
		  <item id="exampleSeries/impressum.xml" ref="go/exampleSeries/impressum.xml">
		    <label xml:lang="de">Impressum</label>
		    <label xml:lang="en">Imprint</label>
		  </item>
		</item>


