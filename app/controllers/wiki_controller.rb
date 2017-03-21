class WikiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @page = Page.find_by_slug(params[:slug])
    record_not_found unless @page
  end

  private

  def record_not_found
    render 'no_page'
  end
end