class SpacesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @space = Space.find_by_slug!(params[:space_slug])
  end

  private

  def record_not_found
    render 'no_space'
  end
end