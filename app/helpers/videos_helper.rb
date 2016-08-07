module VideosHelper

  # Download video(or autio) and info.json and create model
  def download_video(video_id)
    script_path = File.join(Rails.root, 'scripts', 'drop_video')
    info_path = File.join(Rails.root, 'tmp', 'cache', 'downloads', video_id, "#{video_id}.info.json")
    output = `python #{script_path} --id #{video_id}`
    if File.exist?(info_path)
      info = JSON.parse(File.read(info_path))
      { :success => true, :model => gen_model_from_info(info) }
    else
      { :success => false, :reason => output }
    end
  end

  private

    def gen_model_from_info(info)
      Video.create(
        video_id: info["id"],
        title: info["title"],
        duration: info["duration"],
        file_size: info["filesize"],
        upload_date: info["upload_date"],
        thumbnail_url: info["thumbnail"]
      )
    end
end
