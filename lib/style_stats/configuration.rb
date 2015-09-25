class StyleStats
  class Configuration
    def options
      @options ||= {
        stylesheets:                   true,
        size:                          true,
        dataUriSize:                   true,
        ratioOfDataUriSize:            true,
        gzippedSize:                   true,
        simplicity:                    true,
        rules:                         true,
        selectors:                     true,
        mostIdentifier:                true,
        mostIdentifierSelector:        true,
        lowestCohesion:                true,
        lowestCohesionSelector:        true,
        totalUniqueFontSizes:          true,
        uniqueFontSizes:               true,
        totalUniqueColors:             true,
        uniqueFontFamilies:            true,
        uniqueColors:                  true,
        idSelectors:                   true,
        universalSelectors:            true,
        unqualifiedAttributeSelectors: true,
        javascriptSpecificSelectors:   true,
        userSpecifiedSelectors:        '#foo',
        importantKeywords:             true,
        floatProperties:               true,
        mediaQueries:                  true,
        propertiesCount:               true
      }
    end
  end
end
