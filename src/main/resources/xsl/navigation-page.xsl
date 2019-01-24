<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================== -->
<!-- $Revision$ $Date$ -->
<!-- ============================================== -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation" xmlns:xalan="http://xml.apache.org/xalan"
  exclude-result-prefixes="xalan i18n">

  <xsl:param name="WebApplicationBaseURL" />
  <xsl:output method="html" doctype-system="about:legacy-compat" indent="yes" omit-xml-declaration="yes" media-type="text/html"
    version="5" />
  <xsl:strip-space elements="*" />

  <xsl:template match="/">
    <xsl:copy-of select="." />
    <script type="text/javascript" src="{$WebApplicationBaseURL}js/mir-navigation-plugin/mir-navigation.js"></script>
  </xsl:template>
</xsl:stylesheet>