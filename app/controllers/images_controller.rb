class ImagesController < ApplicationController

    def new
      @image = Image.new
      @images = Image.all
    end

    def create
      @image = current_user.images.create(image_params)
      @image.user_id = current_user.id

      if @image.save
        redirect_to users_path, notice: "Image added successfully!"
      else
        render :new
      end
    end

    def edit
      @image = Image.find(current_user.image)
    end

   def update
    @image = Image.find(current_user.image.id)

      if @image.update_attributes(image_params)
        redirect_to users_path, notice: 'Done!'
      else
        render :edit
      end
    end

  protected

    def image_params
      params.require(:image).permit(:image, :user_id)
    end

end
