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
    @space = Space.new(space_params)
    @space.owner = current_user
    if @space.save!
      redirect_to "/wiki/#{@space.slug}"
    else
    end
  end

  private

  def record_not_found
    render 'no_space'
  end

  def space_params
    params.require(:space).permit(:name, :slug, :owner, :owner_id)
  end
end