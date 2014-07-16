class PreferencesController < ApplicationController
  
  def index
    @preference = Preference.all
  end

  def show
    @preference = Preference.find(params[:id])
  end

  def new
    @preference = Preference.new
  end

  def create
    @preference = Preference.new(preference_params)

    if @preference.save
      redirect_to preferences_path
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