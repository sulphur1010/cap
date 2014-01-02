require 'spec_helper'

describe "AudioMp3s" do
  describe "GET /audio_mp3s" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get audio_mp3s_path
      response.status.should be(200)
    end
  end
end
