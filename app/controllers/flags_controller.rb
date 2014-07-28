class FlagsController < ApplicationController
  before_filter :authorize

  def new
    @flag = Flag.new
  end

  def create
    @flag = current_user.flags.create({:target_id => params[:target_id]})
    @flag.user_id = current_user.id

    if @flag.save
      redirect_to users_path, notice: "Flagged!"
    else
      render :new
    end
  end


end