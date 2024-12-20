# mir-navigation-plugin

Includes an extended navigation for newspapers and series. It based on a widen solr handling for 
parent documents (root field).

The plugin provides the extended solr handling for series (solr-navigation.xsl). In frontend
context there is a series layout with a panel that shows the navigation. 

## Installation instructions for mir lts 2023.06 (As mir-enduser)

1. Download the project from this repository and place it on your computer

2. Unzip the downloaded file to create a development project folder location 

3. Customize general mycore.properties(http://www.mycore.de/documentation/getting_started/mcr_properties.html) for this plugin (/mir-navigation-plugin/src/main/resources/config/mir-navigation-plugin/mycore.properties)

4. Create jar file with maven => mvn clean && mvn install

5. Copy the created jar file from target (/mir-navigation-plugin/target) to mycore home lib 

(Windows Systems C:\Users\User\AppData\Local\MyCoRe\mirapplication\lib) <br />
(Linux Systems /home/user/.mycore/mirapplication/lib)

6. The navigation plugin uses a widen solr handling for parent documents. For this purpose, the plugin brings its own schema extensions. It is necessary to reload the solr schema (for further information have a look on solr mycore documentation http://www.mycore.de/documentation/search/using_solr.html).
In case of a standard solr core installation (the main core is named „main“) open the mir web cli:

-	run command „reload solr configuration main in core main“
	* This command synchronizes the solr main core with the solr schema from this plugin
-	Reload the mir core with solr webadmin (Core Admin - reload)
	* You can do a quick check in the solr webadmin via mir schema menu item (root field should be there now)
-	Reindex solr with the rules from the navigation plugin with command „rebuild solr metadata and content index in core main“
	* solr entries should provide the extended handling for parent documents now (root field)

## Requirements for mods document metadata
The standard implementation identifies derivates as series-navigation relatable if they have set categid="navigation" in derobject classification:

      <derobject inherited="0" xlink:type="locator" xlink:href="mir_derivate_00000001">
        <order>1</order>
        <maindoc>index.xml</maindoc>
        <classification classid="derivate_types" categid="navigation" />
      </derobject>


## Migrate series navigation in mir
For adding the series navigation panel in the right corner you have to adapt the MIR.Layout.End property (add series-banner,series-layout):

`MIR.Layout.End=mir-edit,series-banner,series-layout,mir-citation,mir-thumbnail,mir-epusta,mir-access-rights,mir-export,mir-admindata,mir-historydata`