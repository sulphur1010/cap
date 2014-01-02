class AudioMp3 < ActiveRecord::Base
  belongs_to :audio_content
  attr_accessible :audio_mp3_content_type, :audio_mp3_file_size, :audio_mp3_updated_at, :audio_mp3_file_name, :audio_content_id, :audio_title, :audio_mp3
  has_attached_file :audio_mp3, :url => "/:class/:id/:filename", :path => ":rails_root/public/:class/:id/:filename"
  validates_format_of :audio_mp3_file_name, :with => %r{\.(mp3)$}i, :message => 'should be a mp3 file'
end

