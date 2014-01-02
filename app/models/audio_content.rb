class AudioContent < ActiveRecord::Base
  attr_accessible :content_fragment_id, :title, :audio_mp3, :audio_mp3s_attributes, :audio_mp3s
  belongs_to :content_fragment
  has_many :audio_mp3s
  accepts_nested_attributes_for :audio_mp3s, :allow_destroy => true
 end
