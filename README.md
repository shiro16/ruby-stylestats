# Ruby StyleStats

[Oriainal StyleStats](https://github.com/t32k/stylestats) is a Node.js library to collect CSS statistics!  
This gem was port in Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'style_stats'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install style_stats

## Usage

```sh
$ style_stats path/to/stylesheet.css
┌─────────────────────────────────┬────────────────────────────┐
│ Published                       │ 2015-08-29 22:56:15 +0900  │
├─────────────────────────────────┼────────────────────────────┤
│ Paths                           │ path/to/stylesheet.css     │
├─────────────────────────────────┼────────────────────────────┤
│ Style Sheets                    │ 1                          │
├─────────────────────────────────┼────────────────────────────┤
│ Style Elements                  │ 0                          │
├─────────────────────────────────┼────────────────────────────┤
│ Size                            │ 240B                       │
├─────────────────────────────────┼────────────────────────────┤
│ Data URI Size                   │ 0                          │
├─────────────────────────────────┼────────────────────────────┤
│ Ratio of Data URI Size          │ 0.0%                       │
├─────────────────────────────────┼────────────────────────────┤
│ Gzipped Size                    │ 158B                       │
├─────────────────────────────────┼────────────────────────────┤
│ Rules                           │ 7                          │
├─────────────────────────────────┼────────────────────────────┤
│ Selectors                       │ 12                         │
├─────────────────────────────────┼────────────────────────────┤
│ Simplicity                      │ 58.3%                      │
├─────────────────────────────────┼────────────────────────────┤
│ Average of Identifier           │ 1.250                      │
├─────────────────────────────────┼────────────────────────────┤
│ Most Identifier                 │ 3                          │
├─────────────────────────────────┼────────────────────────────┤
│ Most Identifier Selector        │ .foo .bar .baz             │
├─────────────────────────────────┼────────────────────────────┤
│ Average of Cohesion             │ 1.429                      │
├─────────────────────────────────┼────────────────────────────┤
│ Lowest Cohesion                 │ 2                          │
├─────────────────────────────────┼────────────────────────────┤
│ Lowest Cohesion Selector        │ .foo                       │
├─────────────────────────────────┼────────────────────────────┤
│ Total Unique Font Sizes         │ 2                          │
├─────────────────────────────────┼────────────────────────────┤
│ Unique Font Sizes               │ 12px                       │
│                                 │ 16px                       │
├─────────────────────────────────┼────────────────────────────┤
│ Total Unique Font Families      │ 0                          │
├─────────────────────────────────┼────────────────────────────┤
│ Unique Font Families            │ N/A                        │
├─────────────────────────────────┼────────────────────────────┤
│ Total Unique Colors             │ 3                          │
├─────────────────────────────────┼────────────────────────────┤
│ Unique Colors                   │ #333333                    │
│                                 │ #CCCCCC                    │
│                                 │ RED                        │
├─────────────────────────────────┼────────────────────────────┤
│ ID Selectors                    │ 1                          │
├─────────────────────────────────┼────────────────────────────┤
│ Universal Selectors             │ 1                          │
├─────────────────────────────────┼────────────────────────────┤
│ Unqualified Attribute Selectors │ 1                          │
├─────────────────────────────────┼────────────────────────────┤
│ JavaScript Specific Selectors   │ 0                          │
├─────────────────────────────────┼────────────────────────────┤
│ Important Keywords              │ 1                          │
├─────────────────────────────────┼────────────────────────────┤
│ Float Properties                │ 1                          │
├─────────────────────────────────┼────────────────────────────┤
│ Properties Count                │ color: 4                   │
│                                 │ font-size: 3               │
│                                 │ margin: 2                  │
│                                 │ float: 1                   │
├─────────────────────────────────┼────────────────────────────┤
│ Media Queries                   │ 0                          │
└─────────────────────────────────┴────────────────────────────┘
```

Specified css file will be analyzed.

```sh
# Providing multiple input is also supported.
$ style_stats foo.css bar.css baz.css
```

CSS files in specified directory will be analyzed.

```sh
$ style_stats path/to/dir
```

Glob input is supported (quotes are required).

```sh
$ style_stats 'path/**/*.css'
```

You can specify a remote CSS file.

```sh
$ style_stats http://example.com/css/wisteria.css
```

If you specify an HTML page, StyleStats will analyze stylesheets and `style` elements.

```sh
$ style_stats http://example.com/
```

`--format` option outputs JSON, HTML, Markdown.

```sh
$ style_stats foo.css -f <json|html|md>
```

## CLI Reference

Help:

```shell
$ style_stats --help
Usage: style_stats [options] <file ...>
    -h, --help                       output usage information
    -V, --version                    output the version number
    -c, --config <path>              set configurations
    -f, --format <format>            set the output format <json|html|md>
    -t, --template <path>            set the template path for output format
    -n, --number                     show only numeral metrics
    -m, --mobile [name]              set the mobile user agent
        --user-anget <string>        set the user agent</string></format></path>
```

Example:

```shell
$ style_stats path/to/stylesheet.css -c style_stats.yml
┌────────────────────────────┬────────┐
│ Style Sheets               │ 1      │
├────────────────────────────┼────────┤
│ Size                       │ 19.0KB │
├────────────────────────────┼────────┤
│ Gzipped Size               │ 3.7KB  │
├────────────────────────────┼────────┤
│ Total Unique Font Families │ 3      │
└────────────────────────────┴────────┘
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec style_stats` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

