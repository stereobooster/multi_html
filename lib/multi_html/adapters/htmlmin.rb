require 'htmlmin' unless defined?(::HTMLMin)

module MultiHtml
  module Adapters
    class Htmlmin
      def self.min(text, options={}) #:nodoc:
        ::HTMLMin.minify(text, options)
      end
    end
  end
end
