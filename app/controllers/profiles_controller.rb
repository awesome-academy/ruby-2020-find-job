class ProfilesController < ApplicationController
  before_action :logged_in_user, except: %i(index show)
  before_action :correct_user, only: %i(destroy edit update)

  def new
    @profile = current_user.profiles.build.tap do |p|
      p.qualifications.build
      p.experiences.build
      p.profile_skills.build
    end
  end

  def edit; end

  def create
    @profile = current_user.profiles.build profile_params
    @profile.image.attach profile_params[:avatar]
    if @profile.save
      flash[:success] = t "notification.create_success"
      redirect_to root_url
    else
      flash[:danger] = t "notification.creat_fail"
      render :new
    end
  end

  def update
    @profile.image.attach profile_params[:avatar]
    if @profile.update profile_params
      flash[:success] = t "notification.update_success"
      redirect_to user_path
    else
      flash.now[:danger] = t "notification.update_fail"
      render :edit
    end
  end

  def destroy
    if @profile.destroy
      flash[:success] = t "notification.profile_delete"
      redirect_to request.referrer || root_url
    else 
      flash[:danger] = t "notification.delete_fail"
      redirect_to root_url
    end 
  end

  def change_status
    @profile = current_user.profiles.find_by id: params[:profile_id]
    @profile.public_cv? ? @profile.private_cv! : @profile.public_cv!
    redirect_to user_path
  end

  private
  
  def profile_params
    params.require(:profile).permit Profile::PROFILE_PERMIT
  end

  def correct_user
    @profile = current_user.profiles.find_by id: params[:id]
    redirect_to root_url unless @profile
  end
end
