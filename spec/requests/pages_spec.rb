require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe  "/static/" do
  
  before(:all) do
    mount_slice
    ::MerbStaticPagesSlice.push_path(:pages, File.dirname(__FILE__) / '..' / 'fixtures', "**/*.markdown")
  end
  
  describe "/static/about-this-slice" do
    before(:each) do
      @response = request("/static/about-this-slice")
    end
  
    it "should have changed the page path" do
      ::MerbStaticPagesSlice.dir_for(:pages).should == File.dirname(__FILE__) / '..' / 'fixtures'
    end
  
    it "should be successful" do
      @response.status.should be_successful
    end
    
    it "should have rendered the markdown page" do
      @response.should have_tag(:h1, :content => "About this slice")
    end
    
    it "should have rendered a quote" do
      @response.should have_tag(:blockquote)
    end
    
    it "should have rendered a h2 with an id set to 'example'" do
      @response.should have_selector("h2#example")
    end
    
    it "should have rendered a link going to http://merbist.com" do
      @response.should have_tag(:a, :href => "http://merbist.com", :content => "blog")
    end
    
    it "should have rendered a paragraph with the author as CSS selector set to id" do
      @response.should have_xpath("//p[@id='author']")
    end
  
  end
  
  describe "/static/missing-page" do
    before(:each) do
      @response = request("/static/missing-page")
    end
  
    it "should raise a 404" do
      @response.status.should == 404
    end
    
  end
  
end