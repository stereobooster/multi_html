# MultiHtml [![Build Status](https://secure.travis-ci.org/stereobooster/multi_html.png?branch=master)](https://secure.travis-ci.org/#!/stereobooster/multi_html) [![Dependency Status](https://gemnasium.com/stereobooster/multi_html.png?travis)](https://gemnasium.com/stereobooster/multi_html) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/stereobooster/multi_html)

There are lot of Ruby libraries to minify HTML.
Instead of choosing a single implementation and forcing users of your library to be
stuck with it, you can use MultiHtml instead, which will simply choose the
best available HTML minifier. Here's how to use it:

```ruby
require 'multi_html'

MultiHtml.min('<div>  <p>test</p>  </div>') #=> '<div><p>test</p></div>'
```

The `use` method, which sets the MultiHtml adapter, takes either a symbol or a
class (to allow for custom HTML minifier) that responds to `.min` at the class level.

MultiHtml tries to have intelligent defaulting. That is, if you have any of the
supported engines already loaded, it will utilize them before attempting to
load any. 
It will load libraries in following order:

 - [html_minifier](https://github.com/stereobooster/html_minifier)
 - [html_compressor](https://github.com/completelynovel/html_compressor)
 - [html_min](http://rubygems.org/gems/html_min)
 - [htmlmin](https://github.com/aishek/htmlmin)
 - [htmlcompressor](https://github.com/paolochiodi/htmlcompressor)

If no other library is available, MultiHtml falls back to [html_press](https://github.com/stereobooster/html_press).

## TODO

 - benchmark against most popular css frameworks (speed, size)
 - generate benchmark report (html or md)
 - write test suite
 - generate comparison table (html or md) with the help of test suite

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
