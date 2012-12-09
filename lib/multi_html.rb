require "multi_html/version"
require "multi_html/filter"

module MultiHtml
  class ParseError < StandardError
    def initialize(message="", backtrace=[])
      super(message)
      self.set_backtrace(backtrace)
    end
  end

  @adapter = nil
  
  REQUIREMENT_MAP = [
    ["html_minifier", :html_minifier],
    # ["html_compressor", :html_compressor],
    # ["html_min", :html_min],
    # ["htmlmin", :htmlmin],
    # ["htmlcompressor", :htmlcompressor],
    ["html_press", :html_press]
  ]

  class << self

    # The default adapter based on what you currently
    # have loaded and installed. First checks to see
    # if any adapters are already loaded, then checks
    # to see which are installed if none are loaded.
    def default_adapter
      return :html_minifier if defined?(::HtmlMinifier)
      # return :html_compressor if defined?(::HtmlCompressor)
      # return :html_min if defined?(::HTMLMin)
      # return :htmlmin if defined?(::HTMLMin)
      # return :htmlcompressor if defined?(::HtmlCompressor)
      return :html_press if defined?(::HtmlPress)

      REQUIREMENT_MAP.each do |(library, adapter)|
        begin
          require library
          return adapter
        rescue LoadError
          next
        end
      end

      :html_press
    end
    # :nodoc:
    alias :default_engine :default_adapter

    # Get the current adapter class.
    def adapter
      return @adapter if @adapter
      self.use self.default_adapter
      @adapter
    end
    # :nodoc:
    alias :engine :adapter

    # Set the adapter utilizing a symbol, string, or class.
    # Supported by default are:
    #
    # * <tt>:html_press</tt>
    # * <tt>:cssminify</tt>
    # * <tt>:yuicssmin</tt>
    # * <tt>:yui_compressor</tt>
    # * <tt>:rainpress</tt>
    def use(new_adapter)
      @adapter = load_adapter(new_adapter)
    end
    alias :adapter= :use
    # :nodoc:
    alias :engine= :use

    def load_adapter(new_adapter)
      case new_adapter
      when String, Symbol
        require "multi_html/adapters/#{new_adapter}"
        self::Adapters.const_get(:"#{new_adapter.to_s.split('_').map{|s| s.capitalize}.join('')}")
      when NilClass, FalseClass
        default_adapter = self.default_adapter
        require "multi_html/adapters/#{default_adapter}"
        self::Adapters.const_get(:"#{default_adapter.to_s.split('_').map{|s| s.capitalize}.join('')}")
      when Class
        new_adapter
      else
        raise "Did not recognize your adapter specification. Please specify either a symbol or a class."
      end
    end

    def current_adapter(options)
      if new_adapter = (options || {}).delete(:adapter)
        load_adapter(new_adapter)
      else
        adapter
      end
    end

    # Minify HTML
    def min(string, options={})
      string = string.read if string.respond_to?(:read)

      adapter = current_adapter(options)
      if defined?(adapter::ParseError)
        begin
          adapter.min(string, options)
        rescue adapter::ParseError => exception
          raise ::MultiHtml::ParseError.new(exception.message, exception.backtrace)
        end
      else
        adapter.min(string, options)
      end
    end

  end
end
