class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all.order(role: :desc).includes(:labels)
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    authorize @user
    if @user.update_attributes(secure_params)
      flash.now[:success] = "The user was successfully updated!"
      # redirect_to users_path, :notice => "User updated."
    else
      flash.now[:error] = @user.errors.full_messages.join(",\n")
      # redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    authorize @user
    @user.destroy
    flash.now[:success] = "The user was successfully removed!"
    # redirect_to users_path, :notice => "User deleted."
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def secure_params
      params.require(:user).permit(:role)
    end

end
