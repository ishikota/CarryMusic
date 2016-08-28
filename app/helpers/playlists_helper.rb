module PlaylistsHelper

  def fetch_playlist_info(playlist_id)
    script_path = File.join(Rails.root, 'scripts', 'fetch_playlist_info.py')
    output = `python #{script_path} --id #{playlist_id}`
    json = JSON.parse(output)
    unless json["error"]
      { :success => true, :info => json }
    else
      { :success => false, :reason => "Failed to get information of playlist ##{playlist_id}" }
    end
  end

end
