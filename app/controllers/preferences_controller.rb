class PreferencesController < ApplicationController
  
  def index
    @preference = Preference.all.page(params[:page]).per(5)
  end

  def show
    @preference = Preference.find(params[:id])
  end

  def new
    @preference = Preference.new
  end

  def create
    @preference = current_user.build_preference(preference_params)
    @preference.user_id = current_user.id

    if @preference.save
      redirect_to preferences_path, notice: "Preference created successfully!"
    else
      render :new
    end
  end

  def edit
  end

  protected

  def preference_params
    params.require(:preference).permit(
      :gender_pref, :min_age, :max_age, :date_type_pref, :lifestyle_pref)
  end

end