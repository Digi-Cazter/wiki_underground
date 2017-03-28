class WikiController < ApplicationController
  before_action :load_space_resource, only: [:show, :edit]
  before_action :load_page_resource, only: [:show]

  def show
  end

  def edit
    render :new
  end

  def new
    redirect_to root_path unless params[:title]
    @space = Space.find(params[:space_id])
    @article = Page.new
  end

  def create
    @article = Page.new(article_params)
    if @article.save!
      redirect_to "/wiki/#{@article.space.slug}/#{@article.slug}"
    else
      # Add error response
    end
  end

  private

  def load_space_resource
    @space = Space.find_by_slug!(params[:space_slug])
  rescue ActiveRecord::RecordNotFound
    record_not_found(:space)
  end

  def load_page_resource
    @page = Page.find_by_slug!(params[:article_slug])
  rescue ActiveRecord::RecordNotFound
    record_not_found(:page)
  end

  def article_params
    params.require(:page).permit(:name, :slug, :space_id)
  end

  def record_not_found(resource)
    case resource
    when :space
      render 'spaces/no_space'
    when :page
      render 'wiki/no_page'
    end
  end
end