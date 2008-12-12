namespace :slices do
  namespace :merb_static_pages_slice do
  
    desc "Install MerbStaticPagesSlice"
    task :install => [:preflight, :setup_directories, :copy_assets, :migrate]
    
    desc "Test for any dependencies"
    task :preflight do # see slicetasks.rb
    end
  
    desc "Setup directories"
    task :setup_directories do
      puts "Creating directories for host application"
      MerbStaticPagesSlice.mirrored_components.each do |type|
        if File.directory?(MerbStaticPagesSlice.dir_for(type))
          if !File.directory?(dst_path = MerbStaticPagesSlice.app_dir_for(type))
            relative_path = dst_path.relative_path_from(Merb.root)
            puts "- creating directory :#{type} #{File.basename(Merb.root) / relative_path}"
            mkdir_p(dst_path)
          end
        end
      end
    end
    
    desc "Copy stub files to host application"
    task :stubs do
      puts "Copying stubs for MerbStaticPagesSlice - resolves any collisions"
      copied, preserved = MerbStaticPagesSlice.mirror_stubs!
      puts "- no files to copy" if copied.empty? && preserved.empty?
      copied.each { |f| puts "- copied #{f}" }
      preserved.each { |f| puts "! preserved override as #{f}" }
    end
    
    desc "Copy stub files and views to host application"
    task :patch => [ "stubs", "freeze:views" ]
  
    desc "Copy public assets to host application"
    task :copy_assets do
      puts "Copying assets for MerbStaticPagesSlice - resolves any collisions"
      copied, preserved = MerbStaticPagesSlice.mirror_public!
      puts "- no files to copy" if copied.empty? && preserved.empty?
      copied.each { |f| puts "- copied #{f}" }
      preserved.each { |f| puts "! preserved override as #{f}" }
    end
    
    desc "Migrate the database"
    task :migrate do # see slicetasks.rb
    end
    
    desc "Freeze MerbStaticPagesSlice into your app (only merb_static_pages_slice/app)" 
    task :freeze => [ "freeze:app" ]

    namespace :freeze do
      
      desc "Freezes MerbStaticPagesSlice by installing the gem into application/gems"
      task :gem do
        ENV["GEM"] ||= "merb_static_pages_slice"
        Rake::Task['slices:install_as_gem'].invoke
      end
      
      desc "Freezes MerbStaticPagesSlice by copying all files from merb_static_pages_slice/app to your application"
      task :app do
        puts "Copying all merb_static_pages_slice/app files to your application - resolves any collisions"
        copied, preserved = MerbStaticPagesSlice.mirror_app!
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
      desc "Freeze all views into your application for easy modification" 
      task :views do
        puts "Copying all view templates to your application - resolves any collisions"
        copied, preserved = MerbStaticPagesSlice.mirror_files_for :view
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
      desc "Freeze all models into your application for easy modification" 
      task :models do
        puts "Copying all models to your application - resolves any collisions"
        copied, preserved = MerbStaticPagesSlice.mirror_files_for :model
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
      desc "Freezes MerbStaticPagesSlice as a gem and copies over merb_static_pages_slice/app"
      task :app_with_gem => [:gem, :app]
      
      desc "Freezes MerbStaticPagesSlice by unpacking all files into your application"
      task :unpack do
        puts "Unpacking MerbStaticPagesSlice files to your application - resolves any collisions"
        copied, preserved = MerbStaticPagesSlice.unpack_slice!
        puts "- no files to copy" if copied.empty? && preserved.empty?
        copied.each { |f| puts "- copied #{f}" }
        preserved.each { |f| puts "! preserved override as #{f}" }
      end
      
    end
    
  end
end