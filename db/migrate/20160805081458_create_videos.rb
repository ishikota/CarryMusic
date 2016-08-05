class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :video_id
      t.string :title
      t.integer :duration
      t.date :upload_date
      t.integer :file_size
      t.string :thumbnail_url

      t.timestamps null: false
    end
  end
end
