class Admin::CompaniesController < Admin::AdminsController
  before_action :load_company, only: %i(edit update)

  def index
    @company = current_user.company
  end

  def edit; end

  def update
    if @company.update_attributes company_params
      flash[:success] = t "admin.company.update_success"
      redirect_to admin_companies_url
    else
      flash[:danger] = t "admin.company.update_fail"
      redirect_to edit_admin_company_path
    end
  end

  private

  def company_params
    params.require(:company).permit Company::COMPANY_PARAMS
  end

  def load_company
    @company = Company.find_by id: params[:id]
    return if @company

    flash[:danger] = t "admin.company.not_found"
    redirect_to admin_companies_url
  end
end
