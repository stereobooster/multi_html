require 'html_compressor' unless defined?(::HtmlCompressor)

module MultiHtml
  module Adapters
    class HtmlCompressor
      def self.min(text, options={}) #:nodoc:
        ::HtmlCompressor.new(options).compress(text)
      end
    end
  end
end
