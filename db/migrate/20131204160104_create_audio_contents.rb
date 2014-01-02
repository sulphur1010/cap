class CreateAudioContents < ActiveRecord::Migration
  def change
    create_table :audio_contents do |t|
      t.string :title
      t.string :url
      t.integer :content_fragment_id
      t.string :audioMp3_file_name
      t.string :audioMp3_content_type
      t.integer :audioMp3_file_size
      t.datetime :audioMp3_updated_at
      t.timestamps
    end
  end
end
