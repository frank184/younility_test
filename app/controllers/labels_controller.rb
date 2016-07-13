class LabelsController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized
  before_action :admins_only!
  before_action :set_label, only: [:edit, :update, :destroy]

  def index
    @labels = Label.all.order(created_at: :desc)
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(permitted_label_params)
    if @label.save
      flash.now[:success] = "The label was successfully created!"
    else
      flash.now[:error] = @label.errors.full_messages.join(",\n")
    end
  end

  def edit
  end

  def update
    if @label.update(permitted_label_params)
      flash.now[:success] = "The label was successfully updated!"
    else
      flash.now[:error] = @label.errors.full_messages.join(",\n")
    end
  end

  def destroy
    authorize(current_user)
    @label.destroy
    flash.now[:success] = "The label #{@label.name} was successfully removed!"
  end

  private
    def set_label
      @label = Label.find(params[:id])
    end

    def permitted_label_params
      params.require(:label).permit(:name, :colour)
    end
end
