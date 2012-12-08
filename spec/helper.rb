def macruby?
  defined?(RUBY_ENGINE) && RUBY_ENGINE == 'macruby'
end

unless ENV['CI'] || macruby?
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
  end
end

require 'multi_html'
require 'rspec'

class MockDecoder
  def self.min(string, options={})
    ''
  end
end
