require 'htmlcompressor' unless defined?(::HtmlCompressor)

module MultiHtml
  module Adapters
    class Htmlcompressor
      def self.min(text, options={}) #:nodoc:
        ::HtmlCompressor.Compressor.new(options).compile(text)
      end
    end
  end
end
