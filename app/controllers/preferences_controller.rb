class PreferencesController < ApplicationController

  before_filter :authorize, only: [:edit, :update]

  def index
    @preference = Preference.all.page(params[:page]).per(5)
  end

  def show
    @preference = Preference.find(params[:id])
  end

  def new
    @preference = Preference.new
    @first_date = FirstDate.all
    @lifestyle = Lifestyle.all
  end

  def create
    @preference = current_user.build_preference(preference_params)
    @preference.user_id = current_user.id

    current_user.first_dates = FirstDate.where(id: params[:user][:first_dates])
    current_user.lifestyles = Lifestyle.where(id: params[:user][:lifestyles])

    if @preference.save
      redirect_to new_deet_path, notice: "Preference created successfully!"
    else
      render :new
    end
  end

  def edit
    # if current_user.preference.nil?
    #   render :new
    # else
      @preference = current_user.preference
      @first_date = FirstDate.all
      @lifestyle = Lifestyle.all
    # @first_date = FirstDate.where(id: params[:user][:first_dates])
    # @lifestyle = Lifestyle.where(id: params[:user][:lifestyles])
    # end
  end

  def update
    @preference = current_user.preference
    current_user.first_dates = FirstDate.where(id: params[:user][:first_dates])

    current_user.lifestyles = Lifestyle.where(id: params[:user][:lifestyles])

    # @first_date = current_user.first_dates
    # @lifestyle = current_user.lifestyles
    # @first_date = FirstDate.where(id: params[:user][:first_dates])
    # @lifestyle = Lifestyle.where(id: params[:user][:lifestyles])

    if @preference.update_attributes(preference_params)
      # search
      redirect_to users_path, notice: 'Done!'
    else
      render :edit
    end
  end

  protected

  def preference_params
    params.require(:preference).permit(
      :gender_pref, :min_age, :max_age, :date_type_pref, :lifestyle_pref, :address, first_date_attributes: [:first_date_id], lifestyle_attributes: [:lifestyle_id])
  end

end
