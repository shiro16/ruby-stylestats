class StyleStats
  class Css
    def analyze
      @result = {}
      @selector = sort_selector_by_declarations_count.first
      @most_indentifier_selector = selectors.first || StyleStats::Css::Selector.new("")
      analyze_published
      analyze_paths
      analyze_stylesheets
      analyze_style_elements
      analyze_size
      analyze_data_uri_size
      analyze_ratio_of_data_uri_size
      analyze_gzipped_size
      analyze_rules
      analyze_selectors
      analyze_declarations
      analyze_simplicity
      analyze_average_of_identifier
      analyze_most_identifier
      analyze_most_identifier_selector
      analyze_average_of_cohesion
      analyze_lowest_cohesion
      analyze_lowest_cohesion_selector
      analyze_total_unique_font_sizes
      analyze_unique_font_sizes
      analyze_total_unique_font_families
      analyze_unique_font_families
      analyze_total_unique_colors
      analyze_unique_colors
      analyze_id_selectors
      analyze_universal_selectors
      analyze_unqualified_attribute_selectors
      analyze_javascript_specific_selectors
      analyze_user_specific_selectors
      analyze_important_keywords
      analyze_fload_properties
      analyze_properties_count
      analyze_media_queries
      @result
    end

    private
    def analyze_published
      @result["Published"] = Time.now if StyleStats.configuration.options[:published]
    end

    def analyze_paths
      @result["Paths"] = paths if StyleStats.configuration.options[:paths]
    end

    def analyze_stylesheets
      @result["Style Sheets"] = stylesheets.count if StyleStats.configuration.options[:stylesheets]
    end

    def analyze_style_elements
      @result["Style Elements"] = elements.count if StyleStats.configuration.options[:styleElements]
    end

    def analyze_size
      @result["Size"] = size if StyleStats.configuration.options[:size]
    end

    def analyze_data_uri_size
      @result["Data URI Size"] = data_uri_size if StyleStats.configuration.options[:dataUriSize]
    end

    def analyze_ratio_of_data_uri_size
      @result["Ratio of Data URI Size"] = "#{data_uri_size.fdiv(size).round(1) * 100}%" if StyleStats.configuration.options[:ratioOfDataUriSize]
    end

    def analyze_gzipped_size
      @result["Gzipped Size"] = gzipped_size if StyleStats.configuration.options[:gzippedSize]
    end

    def analyze_rules
      @result["Rules"] = rules.count if StyleStats.configuration.options[:rules]
    end

    def analyze_selectors
      @result["Selectors"] = selectors.count if StyleStats.configuration.options[:selectors]
    end

    def analyze_declarations
      @result["Declarations"] = declarations.count if StyleStats.configuration.options[:declarations]
    end

    def analyze_simplicity
      @result["Simplicity"] = "#{rules.count.fdiv(selectors.count).round(1) * 100}%" if StyleStats.configuration.options[:simplicity]
    end

    def analyze_average_of_identifier
      @result["Average of Identifier"] = selectors.map(&:identifier_count).inject(0, :+).fdiv(selectors.count).round(3) if StyleStats.configuration.options[:averageOfIdentifier]
    end

    def analyze_most_identifier
      @result["Most Identifier"] = @most_indentifier_selector.identifier_count if StyleStats.configuration.options[:mostIdentifier]
    end

    def analyze_most_identifier_selector
      @result["Most Identifier Selector"] = @most_indentifier_selector.name if StyleStats.configuration.options[:mostIdentifierSelector]
    end

    def analyze_average_of_cohesion
      @result["Average of Cohesion"] = declarations.count.fdiv(rules.count).round(3) if StyleStats.configuration.options[:averageOfCohesion]
    end

    def analyze_lowest_cohesion
      @result["Lowest Cohesion"] = @selector.declarations.count if StyleStats.configuration.options[:lowestCohesion]
    end

    def analyze_lowest_cohesion_selector
      @result["Lowest Cohesion Selector"] = @selector.name if StyleStats.configuration.options[:lowestCohesionSelector]
    end

    def analyze_total_unique_font_sizes
      @result["Total Unique Font Sizes"] = self["font-size"][:values].count if StyleStats.configuration.options[:totalUniqueFontSizes]
    end

    def analyze_unique_font_sizes
      @result["Unique Font Sizes"] = self["font-size"][:values] if StyleStats.configuration.options[:uniqueFontSizes]
    end

    def analyze_total_unique_font_families
      @result["Total Unique Font Families"] = self["font-family"][:values].count if StyleStats.configuration.options[:totalUniqueFontFamilies]
    end

    def analyze_unique_font_families
      @result["Unique Font Families"] = self["font-family"][:values] if StyleStats.configuration.options[:uniqueFontFamilies]
    end

    def analyze_total_unique_colors
      @result["Total Unique Colors"] = self["color"][:values].count if StyleStats.configuration.options[:totalUniqueColors]
    end

    def analyze_unique_colors
      @result["Unique Colors"] = self["color"][:values] if StyleStats.configuration.options[:uniqueColors]
    end

    def analyze_id_selectors
      @result["ID Selectors"] = selectors_count(:id) if StyleStats.configuration.options[:idSelectors]
    end

    def analyze_universal_selectors
      @result["Universal Selectors"] = selectors_count(:universal) if StyleStats.configuration.options[:universalSelectors]
    end

    def analyze_unqualified_attribute_selectors
      @result["Unqualified Attribute Selectors"] = selectors_count(:unqualified) if StyleStats.configuration.options[:unqualifiedAttributeSelectors]
    end

    def analyze_javascript_specific_selectors
      @result["JavaScript Specific Selectors"] = selectors_count(:js) if StyleStats.configuration.options[:javascriptSpecificSelectors]
    end

    def analyze_user_specific_selectors
      @result["User Specific Selectors"] = selectors_count(:user) if StyleStats.configuration.options[:userSpecificSelectors]
    end

    def analyze_important_keywords
      @result["Important Keywords"] = declarations_count(:important) if StyleStats.configuration.options[:importantKeywords]
    end

    def analyze_fload_properties
      @result["Float Properties"] = declarations_count(:float) if StyleStats.configuration.options[:floatProperties]
    end

    def analyze_properties_count
      @result["Properties Count"] = aggregate_declaration.declarations.sort { |(_, v1), (_, v2)| v2[:count] <=> v1[:count] }.take(10).map{ |property, declaration| "#{property}: #{declaration[:count]}" } if StyleStats.configuration.options[:propertiesCount]
    end

    def analyze_media_queries
      @result["Media Queries"] = media_types.count if StyleStats.configuration.options[:mediaQueries]
    end
  end
end
