require 'html_press' unless defined?(::HtmlPress)

module MultiHtml
  module Adapters
    class HtmlPress
      def self.min(text, options={}) #:nodoc:
        ::HtmlPress.press(text, options)
      end
    end
  end
end
