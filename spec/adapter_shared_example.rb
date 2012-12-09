shared_examples_for "an adapter" do |adapter|

  before do
    begin
      MultiHtml.use adapter
    rescue LoadError
      pending "Adapter #{adapter} couldn't be loaded (not installed?)"
    end
  end

  describe '.min' do
    it 'minify' do
      MultiHtml.min(" <p>some text</p>").should eq '<p>some text</p>'
    end

    it 'support options'
    
  end
end
