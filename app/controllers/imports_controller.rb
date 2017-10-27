class ImportsController < ApplicationController
  def index
    @products = Product.sort_by_name.paginate(page: params[:page], per_page: Settings.paginate.user_perpage)
  end

  def create
    if params[:file].present? && Product.import(params[:file]) != Settings.unknown_file
      flash[:success] = t "imported"
    else
      flash[:danger] = t "import_errors"
    end
    redirect_to imports_path
  end
end
