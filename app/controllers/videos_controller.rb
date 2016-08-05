class VideosController < ApplicationController
  def show
    @video = Video.find_by_video_id(params[:video_id])
    if @video.present?
      render json: @video.to_json
    else
      render text: "404 Not found", status: 404
    end
  end
end
