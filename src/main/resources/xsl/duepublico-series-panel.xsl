<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:mcr="xalan://org.mycore.common.xml.MCRXMLFunctions"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:mods="http://www.loc.gov/mods/v3"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="i18n mcr mods xlink"
>
  
  <xsl:param name="WebApplicationBaseURL" />
  <xsl:param name="CurrentLang" />
  
  <xsl:template match="mycoreobject" mode="seriesLayout">
    <xsl:apply-templates select="structure/derobjects/derobject[1]/@xlink:href" mode="seriesLayout">
      <xsl:with-param name="rootID" select="@ID" />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="derobject/@xlink:href" mode="seriesLayout">
    <xsl:param name="rootID" />
    <xsl:apply-templates select="document(concat('notnull:mcrfile:',.,'/navigation.xml'))/item" mode="seriesLayout">
      <xsl:with-param name="rootID" select="$rootID" />
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="/item" mode="seriesLayout">
    <xsl:param name="rootID" />

    <xsl:apply-templates select="@banner" mode="seriesLayout">
      <xsl:with-param name="rootID" select="$rootID" />
    </xsl:apply-templates>

    <div class="panel panel-default" id="duepublico-series-layout" style="margin-right:1px; width:100%">
      <div class="panel-heading">
        <h3 class="panel-title">
          <xsl:value-of select="label[lang($CurrentLang)]" />
        </h3>
      </div>
      <div class="panel-body">

        <ul>
          <xsl:apply-templates select="item" mode="seriesLayout" />
          <xsl:call-template name="rssLink">
            <xsl:with-param name="rootID" select="$rootID" />
          </xsl:call-template>
        </ul>

        <xsl:call-template name="searchForm">
          <xsl:with-param name="rootID" select="$rootID" />
        </xsl:call-template>

      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="item/item" mode="seriesLayout">
    <li>
      <a href="{$WebApplicationBaseURL}{@ref}">
        <xsl:value-of select="label[lang($CurrentLang)]" />
      </a>
    </li>
  </xsl:template>

  <xsl:template match="item/@banner" mode="seriesLayout">
    <xsl:param name="rootID" />

    <div id="duepublico-series-banner">
      <a href="{$WebApplicationBaseURL}receive/{$rootID}">
        <img style="width:340px;" src="{$WebApplicationBaseURL}{.}" alt="Logo {../label[lang($CurrentLang)]}" />
      </a>
    </div>   
  </xsl:template>

  <xsl:template name="searchForm">
    <xsl:param name="rootID" />

    <form role="search" action="{$ServletsBaseURL}solr/select" method="post" class="form-inline">
      <input type="hidden" name="q" value="root:{$rootID}" />
      <label class="sr-only" for="qSeries">
        <xsl:text>Suche in </xsl:text>
        <xsl:value-of select="label[lang($CurrentLang)]" />
      </label>
      <input id="qSeries" type="text" name="fq" class="form-control" style="width:257px" placeholder="Suche in {label[lang($CurrentLang)]}"/>
      <button class="btn btn-primary" type="submit">
        <i class="fa fa-search" />
      </button>
    </form>
  </xsl:template>
  
  <xsl:template name="rssLink">
    <xsl:param name="rootID" />

    <li>
      <a href="{$WebApplicationBaseURL}receive/{$rootID}?XSL.Style=rss">
        <i class="fa fa-rss" />
        <xsl:text> RSS 2.0 Feed</xsl:text>
      </a>
    </li>
  </xsl:template>
  
</xsl:stylesheet>
