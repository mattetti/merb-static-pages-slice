class MerbStaticPagesSlice::Pages < MerbStaticPagesSlice::Application

  def show
    page = MerbStaticPagesSlice::Page.new(params[:page_name])
    render page.to_html
  end
  
end
