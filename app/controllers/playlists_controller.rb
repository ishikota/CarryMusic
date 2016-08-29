class PlaylistsController < ApplicationController
  include PlaylistsHelper

  def show
    result = fetch_playlist_info(params[:playlist_id])
    if result[:success]
      render json: result.update( { :info => format_playlist_info(result[:info]) } )
    else
      render json: gen_error_response(500, result[:reason]), status: 500
    end
  end

  private

    def format_playlist_info(json)
      json["entries"].map { |entry|
        entry.slice("id", "title")
      }
    end

end
