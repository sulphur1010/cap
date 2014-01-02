class CreateAudioMp3s < ActiveRecord::Migration
  def change
    create_table :audio_mp3s do |t|
      t.string :audio_mp3_file_name
      t.string :audio_mp3_content_type
      t.integer :audio_Mp3_file_size
      t.datetime :audio_mp3_updated_at
      t.integer :audio_content_id
      t.string :audio_title

      t.timestamps
    end
  end
end
