class ParametersController < ApplicationController
  before_action :load_parameter, only: %i(show edit update)
  before_action :logged_in_user, except: %i(show new create)
  before_action :admin_user, only: %i(index destroy)

  def new
    @parameter = Parameter.new
  end

  def show; end

  def create
    @parameter = Parameter.new parameter_params
    if @parameter.save
      flash[:success] = t ".add_success"
      redirect_to products_manager_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @parameter.update_attributes(parameter_params)
      flash[:success] = t "updated"
      redirect_to products_manager_path
    else
      render :edit
    end
  end

  private

  def load_parameter
    @parameter = Parameter.find_by id: params[:id]
  end

  def parameter_params
    params.require(:parameter).permit :screen, :os, :camera_front,
      :camera_back, :ram, :memory_storage, :processor, :product_id
  end
end
