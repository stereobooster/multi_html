require 'helper'
require 'adapter_shared_example'
require 'stringio'

describe 'MultiHtml' do
  context 'adapters' do
    before do
      MultiHtml.use nil
    end
    context 'when no other implementations are available' do

      # :HtmlCompressor, :HTMLMin
      CONSTS = [:HtmlPress, :HtmlMinifier]

      before do
        @old_map = MultiHtml::REQUIREMENT_MAP
        @old_consts = {}
        CONSTS.each do |c|
          @old_consts[c] = Object.const_get c if Object.const_defined?(c)
        end

        MultiHtml::REQUIREMENT_MAP.each_with_index do |(library, adapter), index|
          MultiHtml::REQUIREMENT_MAP[index] = ["foo/#{library}", adapter]
        end

        CONSTS.each do |c|
           Object.send :remove_const, c if @old_consts[c]
        end
      end

      after do
        @old_map.each_with_index do |(library, adapter), index|
          MultiHtml::REQUIREMENT_MAP[index] = [library, adapter]
        end

        CONSTS.each do |c|
           Object.const_set c, @old_consts[c] if @old_consts[c]
        end
      end

      it 'defaults to vendored implemention if no other implementions are available' do
        MultiHtml.default_adapter.should eq :html_press
      end
    end

    it 'defaults to the best not vendored lib if any other lib available' do
      require 'html_minifier'
      MultiHtml.adapter.name.should eq 'MultiHtml::Adapters::HtmlMinifier'
    end

    it 'is settable via a symbol' do
      MultiHtml.use :html_minifier
      MultiHtml.adapter.name.should eq 'MultiHtml::Adapters::HtmlMinifier'
    end

    it 'is settable via a class' do
      MultiHtml.use MockDecoder
      MultiHtml.adapter.name.should eq 'MockDecoder'
    end
  end

  # html_compressor html_min htmlmin htmlcompressor
  %w(html_press html_minifier).each do |adapter|
    context adapter do
      it_behaves_like "an adapter", adapter
    end
  end
end

