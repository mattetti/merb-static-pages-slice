require File.dirname(__FILE__) + '/../spec_helper'

describe "MerbStaticPagesSlice::Main (controller)" do
  
  # Feel free to remove the specs below
  
  before :all do
    Merb::Router.prepare { add_slice(:MerbStaticPagesSlice) } if standalone?
  end
  
  after :all do
    Merb::Router.reset! if standalone?
  end
  
  # it "should have access to the slice module" do
  #   controller = dispatch_to(MerbStaticPagesSlice::Main, :index)
  #   controller.slice.should == MerbStaticPagesSlice
  #   controller.slice.should == MerbStaticPagesSlice::Main.slice
  # end
  # 
  # it "should have an index action" do
  #   controller = dispatch_to(MerbStaticPagesSlice::Main, :index)
  #   controller.status.should == 200
  #   controller.body.should contain('MerbStaticPagesSlice')
  # end
  # 
  # it "should work with the default route" do
  #   controller = get("/merb_static_pages_slice/main/index")
  #   controller.should be_kind_of(MerbStaticPagesSlice::Main)
  #   controller.action_name.should == 'index'
  # end
  # 
  # it "should work with the example named route" do
  #   controller = get("/merb_static_pages_slice/index.html")
  #   controller.should be_kind_of(MerbStaticPagesSlice::Main)
  #   controller.action_name.should == 'index'
  # end
  #   
  # it "should have a slice_url helper method for slice-specific routes" do
  #   controller = dispatch_to(MerbStaticPagesSlice::Main, 'index')
  #   
  #   url = controller.url(:merb_static_pages_slice_default, :controller => 'main', :action => 'show', :format => 'html')
  #   url.should == "/merb_static_pages_slice/main/show.html"
  #   controller.slice_url(:controller => 'main', :action => 'show', :format => 'html').should == url
  #   
  #   url = controller.url(:merb_static_pages_slice_index, :format => 'html')
  #   url.should == "/merb_static_pages_slice/index.html"
  #   controller.slice_url(:index, :format => 'html').should == url
  #   
  #   url = controller.url(:merb_static_pages_slice_home)
  #   url.should == "/merb_static_pages_slice/"
  #   controller.slice_url(:home).should == url
  # end
  # 
  # it "should have helper methods for dealing with public paths" do
  #   controller = dispatch_to(MerbStaticPagesSlice::Main, :index)
  #   controller.public_path_for(:image).should == "/slices/merb_static_pages_slice/images"
  #   controller.public_path_for(:javascript).should == "/slices/merb_static_pages_slice/javascripts"
  #   controller.public_path_for(:stylesheet).should == "/slices/merb_static_pages_slice/stylesheets"
  #   
  #   controller.image_path.should == "/slices/merb_static_pages_slice/images"
  #   controller.javascript_path.should == "/slices/merb_static_pages_slice/javascripts"
  #   controller.stylesheet_path.should == "/slices/merb_static_pages_slice/stylesheets"
  # end
  # 
  # it "should have a slice-specific _template_root" do
  #   MerbStaticPagesSlice::Main._template_root.should == MerbStaticPagesSlice.dir_for(:view)
  #   MerbStaticPagesSlice::Main._template_root.should == MerbStaticPagesSlice::Application._template_root
  # end

end