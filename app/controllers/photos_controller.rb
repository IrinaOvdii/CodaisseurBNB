class PhotosController < ApplicationController
  def destroy
    photo = Photo.find(params[:id])
    @room = photo.room
    if @room.user.id == current_user.id
      photo.destroy

      redirect_to edit_room_path(@room), notice: "Photo successfully removed"
    else
      redirect_to @room, notice: "Cannot delete that photo"
    end
  end
end
