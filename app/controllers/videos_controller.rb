class VideosController < ApplicationController
  include VideosHelper

  def create
    info = download_video(params[:video_id])
    if info.present?
      render json: info
    else
      render text: "Failed to download", status: 500
    end
  end

  def show
    @video = Video.find_by_video_id(params[:video_id])
    if @video.present?
      render json: @video.to_json
    else
      render text: "404 Not found", status: 404
    end
  end

  def download
    @video = Video.find_by_video_id(params[:video_id])
    if @video.present?
      audio_path = File.join(Rails.root, 'tmp', 'cache', 'downloads', @video.video_id, "#{@video.video_id}.mp3")
      send_file audio_path, :type => 'audio/mp3'
    else
      render text: "404 Not found", status: 404
    end
  end
end
