class PreferencesController < ApplicationController

  def index
    @preference = Preference.all.page(params[:page]).per(5)
  end

  def show
    @preference = Preference.find(params[:id])
  end

  def new
    @preference = Preference.new
    @first_date = FirstDate.all
  end

  def create
    @preference = current_user.build_preference(preference_params)
    @preference.user_id = current_user.id

    if @preference.save
      redirect_to new_deet_path, notice: "Preference created successfully!"
    else
      render :new
    end
  end

  def edit
    @preference = Preference.find(current_user.id)
  end

   def update
    @preference = Preference.find(current_user.id)

    if @preference.update_attributes(preference_params)
      redirect_to deet_path(@preference), notice: 'Done!'
    else
      render :edit
    end
  end

  protected

  def preference_params
    params.require(:preference).permit(
      :gender_pref, :min_age, :max_age, :date_type_pref, :lifestyle_pref)
  end

end
