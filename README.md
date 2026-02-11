# mir-navigation-plugin

This MIR plugin provides navigation functionality for newspapers and series.

It provides a panel for the frontend that displays the series navigation, including banner and search.
The navigation is based on a derivate that contains a `navigation.xml` file, where the navigation structure and banner
can be configured.

It leverages enhanced Solr handling for parent documents (root field) and includes extended Solr processing for series.

> ⚠️ Note: The plugin will overwrite `response-mir.xsl`; any custom frontend changes may be lost.

---

## Features

The plugin offers the following features:

- Frontend Navigation Panel: Displays a series of pages or objects with banner and search.
- Banner Support: Root item can include a banner image.
- Flexible Navigation: Defined via navigation.xml with relative/absolute links and multilingual labels.
- Enhanced Solr Handling: Supports parent documents (root field) and requires schema extensions.
- Optional RSS Feed: RSS link can be displayed or disabled.

---

## Requirements

### Navigation category in `derivate_types` classification

The plugin is based on a derivate which must be classified via `derivate_types:navigation`.
Therefore, the `derivate_types` classification must include a category `navigation`.
The category can be defined as follows:

```xml
<category ID="navigation">
  <label xml:lang="de" text="Navigation" />
  <label xml:lang="en" text="Navigation" />
</category>
```

---

## Installation & Configuration

### Build and provide plugin

Build the JAR file with `mvn clean install` and copy it to `~/.mycore/(dev-)mir/lib/`.

### Configure `mycore.properties`

To use the plugin, configuration in `~/.mycore/(dev-)mir/mycore.properties` is required.
The RSS feed requires a `mycoreobject-rss` stylesheet, which is not included by default.
For historical reasons, the link to the RSS feed is always displayed, but it can be disabled if needed.
All in all, configure as follows:

```text
# Add 'series-banner' and 'series-layout'.
MIR.Layout.End=mir-edit,series-banner,series-layout,mir-citation,mir-thumbnail,mir-epusta,mir-access-rights,mir-export,mir-admindata,mir-historydata

# Optional: disable RSS feed.
MIR.Metadata.Navigation.SeriesPanel.RSS.Enabled=false
```

### Reload and rebuild Solr

The plugin leverages enhanced Solr handling for parent documents.
For this purpose, the plugin brings its own schema extensions.
It is necessary to reload the Solr schema (for further information have a look on Solr
[documentation](https://www.mycore.de/documentation/search/search_solr_use/)).
In the case of a standard Solr core installation (where the main core is named `main`), run the following CLI commands:

```text
# Synchronize the solr main core with the solr schema from this plugin.
reload solr configuration main in core main
# Reindex solr with the rules.
rebuild solr metadata and content index in core main
```

As a result, Solr entries will now support the extended handling for parent documents (root field).

---

## Usage

A panel on an object page, including a banner, navigation, and search, can be integrated via a `navigation.xml` file
contained in a derivative whose _derivate type_ is set to _navigation_.
The following format is expected for the `navigation.xml` file:

```xml
<item banner="path/to/banner.png">
  <item ref="path/to/page1.xml">
    <label xml:lang="de">German label for page 1</label>
    <label xml:lang="en">English label for page 1</label>
  </item>
  <item ref="path/to/page2.xml">
    <label xml:lang="de">German label for page 2</label>
    <label xml:lang="en">English label for page 2</label>
  </item>
</item>
```

A root item is expected first. The optional `banner` attribute can be used to specify a link to an image that will be 
displayed above the navigation.

Within the root item, the actual navigation points can be defined. The `ref` attribute specifies the target of a 
navigation point and can contain either a relative or an absolute link.  
Additionally, labels can be defined for the relevant languages.

> 💡 Tip: Using the [mir-alias-plugin](https://github.com/MyCoRe-Org/mir-alias-plugin), you can simplify the links
> for objects in the navigation.
