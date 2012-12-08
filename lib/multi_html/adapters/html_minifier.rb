require 'html_minifier' unless defined?(::HtmlMinifier)

module MultiHtml
  module Adapters
    class HtmlMinifier
      def self.min(text, options={}) #:nodoc:
        ::HtmlMinifier.minify(text, options)
      end
    end
  end
end
