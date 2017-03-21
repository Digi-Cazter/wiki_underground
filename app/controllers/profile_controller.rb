class ProfileController < ApplicationController
  before_action :authenticate_user!, except: [:lookup]

  def show
    @user = current_user
  end

  def lookup
    @user = User.find_by_email(params[:email])
    if @user
      render json: {name: @user.name, avatar: @user.avatar.url}
    else
      render json: {}
    end
  end
end