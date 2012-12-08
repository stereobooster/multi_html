require 'html_min' unless defined?(::HTMLMin)

module MultiHtml
  module Adapters
    class HtmlMin
      def self.min(text, options={}) #:nodoc:
        ::HTMLMin.new.minimize(text)
      end
    end
  end
end
