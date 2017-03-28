class SpacesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    is_edit = params[:edit] == 'true'

    if is_edit
      @space = Space.new({name: params[:space_slug]})
      render 'create'
    else
      @space = Space.find_by_slug!(params[:space_slug])
    end
  end

  def new
    @space = Space.new
  end

  def create
    redirect_to "/wiki/#{params[:space][:slug]}?edit=true&title=#{params[:space][:name]}"
  end

  private

  def record_not_found
    render 'no_space'
  end
end