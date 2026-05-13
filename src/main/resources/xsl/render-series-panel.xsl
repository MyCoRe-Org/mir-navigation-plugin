<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:param name="CurrentLang" />
  <xsl:param name="ServletsBaseURL" />
  <xsl:param name="WebApplicationBaseURL" />

  <xsl:param name="MIR.Metadata.Navigation.SeriesPanel.RSS.Enabled" />

  <xsl:template name="resolve-navigation-and-render-series-panel">
    <xsl:param name="root-object-id" />
    <xsl:param name="derivate-id" />
    <xsl:variable name="navigation-uri" select="concat('notnull:mcrfile:', $derivate-id, '/navigation.xml')" />
    <xsl:variable name="nav-item" select="document($navigation-uri)/item" />
    <xsl:if test="$nav-item">
      <xsl:call-template name="render-series-panel">
        <xsl:with-param name="nav" select="$nav-item" />
        <xsl:with-param name="root-object-id" select="$root-object-id" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="render-series-panel">
    <xsl:param name="nav" />
    <xsl:param name="root-object-id" />

    <div id="series-layout">
      <xsl:if test="normalize-space($nav/@banner) != ''">
        <a class="banner-link" href="{$WebApplicationBaseURL}receive/{$root-object-id}">
          <img
            src="{$WebApplicationBaseURL}{$nav/@banner}"
            class="card-img-top"
            alt="Logo { $nav/label[lang($CurrentLang)] }" />
        </a>
      </xsl:if>
      <div class="card series-card">
        <div class="card-header">
          <h3 class="card-title">
            <xsl:value-of select="$nav/label[lang($CurrentLang)]" />
          </h3>
        </div>
        <div class="card-body">
          <ul>
            <xsl:for-each select="$nav/item">
              <xsl:call-template name="render-nav-item">
                <xsl:with-param name="itemNode" select="." />
              </xsl:call-template>
            </xsl:for-each>
            <xsl:if test="$MIR.Metadata.Navigation.SeriesPanel.RSS.Enabled='true'">
              <xsl:call-template name="render-rss-item">
                <xsl:with-param name="object-id" select="$root-object-id" />
              </xsl:call-template>
            </xsl:if>
          </ul>
        </div>
        <div class="card-footer">
          <xsl:call-template name="render-search-form">
            <xsl:with-param name="root-object-id" select="$root-object-id" />
          </xsl:call-template>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="render-nav-item">
    <xsl:param name="itemNode" />
    <li>
      <xsl:choose>
        <xsl:when test="starts-with($itemNode/@ref, 'http')">
          <a href="{$itemNode/@ref}">
            <xsl:value-of select="$itemNode/label[lang($CurrentLang)]" />
          </a>
        </xsl:when>
        <xsl:otherwise>
          <a href="{concat($WebApplicationBaseURL, $itemNode/@ref)}">
            <xsl:value-of select="$itemNode/label[lang($CurrentLang)]" />
          </a>
        </xsl:otherwise>
      </xsl:choose>
    </li>
  </xsl:template>

  <xsl:template name="render-search-form">
    <xsl:param name="root-object-id" />
    <form role="search" action="{$ServletsBaseURL}solr/select" method="post" class="rssfeed-search form-inline">
      <input type="hidden" name="q" value="root:{$root-object-id}" />
      <div class="input-group" style="width:100%;">
        <label class="sr-only input-group-prepend" for="qSeries">
          <xsl:text>Suche in </xsl:text>
          <xsl:value-of select="label[lang($CurrentLang)]" />
        </label>
        <input
          id="qSeries"
          type="text"
          name="fq"
          class="form-control"
          placeholder="Suche in {label[lang($CurrentLang)]}" />
        <div class="input-group-append">
          <button class="btn btn-primary" type="submit">
            <i class="fas fa-search" />
          </button>
        </div>
      </div>
    </form>
  </xsl:template>

  <xsl:template name="render-rss-item">
    <xsl:param name="object-id" />
    <li>
      <a href="{$WebApplicationBaseURL}receive/{$object-id}?XSL.Style=rss">
        <i class="fas fa-rss" />
        <xsl:text>RSS 2.0 Feed</xsl:text>
      </a>
    </li>
  </xsl:template>
</xsl:stylesheet>
