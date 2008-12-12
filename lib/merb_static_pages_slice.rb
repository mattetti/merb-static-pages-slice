if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  dependency 'merb-slices', :immediate => true
  dependency 'maruku', ">= 0.5.9"
  Merb::Plugins.add_rakefiles "merb_static_pages_slice/merbtasks", "merb_static_pages_slice/slicetasks", "merb_static_pages_slice/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :merb_static_pages_slice
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:merb_static_pages_slice][:layout] ||= :merb_static_pages_slice
  
  # All Slice code is expected to be namespaced inside a module
  module MerbStaticPagesSlice
    
    # Slice metadata
    self.description = "MerbStaticPagesSlice let you easily serve static pages"
    self.version = "0.0.1"
    self.author = "Matt Aimonetti"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(MerbStaticPagesSlice)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :merb_static_pages_slice_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      # example of a named route
      scope.match('/:page_name(.:format)').to(:controller => 'pages', :action => 'show').name(:page)
      # the slice is mounted at /merb_static_pages_slice - note that it comes before default_routes
      # scope.match('/').to(:controller => 'pages', :action => 'show').name(:pages)
      # enable slice-level default routes by default
      # scope.default_routes
    end
    
  end
  
  # Setup the slice layout for MerbStaticPagesSlice
  #
  # Use MerbStaticPagesSlice.push_path and MerbStaticPagesSlice.push_app_path
  # to set paths to merb_static_pages_slice-level and app-level paths. Example:
  #
  # MerbStaticPagesSlice.push_path(:application, MerbStaticPagesSlice.root)
  # MerbStaticPagesSlice.push_app_path(:application, Merb.root / 'slices' / 'merb_static_pages_slice')
  # ...
  #
  # Any component path that hasn't been set will default to MerbStaticPagesSlice.root
  
  # Add a path to find the pages
  MerbStaticPagesSlice.push_path(:pages, MerbStaticPagesSlice.root / 'app' / 'pages', "**/*.markdown") unless MerbStaticPagesSlice.dir_for(:pages)
  
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  MerbStaticPagesSlice.setup_default_structure!
  
  # Add dependencies for other MerbStaticPagesSlice classes below. Example:
  # dependency "merb_static_pages_slice/other"
  
end