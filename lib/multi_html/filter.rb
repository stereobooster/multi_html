begin
  require 'html/pipeline'

  module MultiHtml
    class Filter < ::HTML::Pipeline::TextFilter 
      def call
        MultiHtml.min(@text, context[:multi_html])
      end
    end
  end
rescue LoadError
end
