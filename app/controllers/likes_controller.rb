class LikesController < ApplicationController

  before_filter :authorize

  def show
  end

  def new
    @like = Like.new
  end

  def create
    @like = current_user.likes.create({:target_id => params[:target_id]})
    @like.user_id = current_user.id

    if @like.save
      redirect_to users_path, notice: "Liked!"
    else
      render :new
    end
  end

  def update

  end

  def destroy
    # @like = current_user.likes.delete({:target_id => params[:target_id]})
    # # # @like = Like.find(params[:id])
    # # @like.destroy
    # redirect_to users_path, notice: "Unliked!"
  end

  # def likes_params
  #   params.require(:like).permit(:user_id, :target_id)
  # end
end
