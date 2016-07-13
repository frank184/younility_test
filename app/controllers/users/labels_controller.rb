class Users::LabelsController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized
  before_action :admins_only!
  before_action :set_user

  def edit
    @labels = Label.all.order(created_at: :desc)
  end

  def update
    if params[:user]
      @user.update(permitted_user_label_params)
    else
      @user.update(label_ids: nil)
    end
  end

  def destroy
    @user.labels.delete(@label)
  end

  private
    def set_label
      @label = Label.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def permitted_user_label_params
      params.require(:user).permit(:label_ids => [])
    end
end
