# MerbStaticPagesSlice

Write static content using the markdown format and serve easily in your app.
This slice was extracted/inspired by the work I did on the [Merb Book](http://github/com/mattetti/merb-book)


To be able to use this slice, you need to do ``2 things``:

1. mount the slice in your router

2. indicate to the slice where to find your static files


----

To mount the slice in your router, open your router.rb and add:

    Merb::Router.prepare do
      slice(:merb_static_pages_slice, :path => "static")
    end

To set the path to your static files, add the following line in your init.rb (inside the before\_app\_loads block)

    Merb::BootLoader.before_app_loads do
      ::MerbStaticPagesSlice.push_path(:pages, Merb.root / 'app' / 'pages', "**/*.markdown")
    end
    
That's it, now put your static file in your path and enjoy :)

To learn more about the syntax, read the [Maruku documentation](http://maruku.rubyforge.org/maruku.html)

- Matt Aimonetti