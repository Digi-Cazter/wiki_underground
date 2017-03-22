class WikiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @space = Space.find_by_slug!(params[:space_slug]) rescue record_not_found(:space)
    @page = Page.find_by_slug!(params[:article_slug]) rescue record_not_found(:page)
  end

  private

  def record_not_found(resource)
    case resource
    when :space
      render 'spaces/no_space'
    when :page
      render 'wiki/no_page'
    end
  end
end