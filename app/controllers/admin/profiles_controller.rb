class Admin::ProfilesController < Admin::AdminsController
  before_action :load_profile, only: %i(show)

  def index
    @q = Profile.ransack params[:q]
    post_ids = current_user.posts.ids
    skill_titles = Skill.by_ids(post_ids).pluck :title
    profile_ids = ProfileSkill.by_id skill_titles
    
    if params[:q].blank?
      @profiles = Profile.by_profiles(profile_ids).includes(:profile_skills)
                         .page(params[:page]).per(Settings.pagination.profile.per)
    else
      @profiles = @q.result.by_status.includes(:profile_skills)
                    .page(params[:page]).per(Settings.pagination.profile.per)
    end
  end

  def show
    @experiences = @profile.experiences
    @qualifications = @profile.qualifications
  end

  private

  def load_profile
    @profile = Profile.find_by id: params[:id]
    return if @profile

    flash[:danger] = t "admin.profile.profile_not_found"
    redirect_to admin_root_url
  end
end
