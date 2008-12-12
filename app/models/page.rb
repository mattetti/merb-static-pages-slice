class MerbStaticPagesSlice::Page
  
  attr_accessor :file
  
  def initialize(slug, *options)
    @file = find_file(slug)
  end
  
  def to_html
    raise ::Exceptions::NotFound unless file
    Maruku::new(File.open(file).read).to_html
  end
  
  private
  
    def find_file(slug)
      Dir["#{::MerbStaticPagesSlice.dir_for(:pages)}/#{slug}.markdown"].entries.first
    end
  
end
