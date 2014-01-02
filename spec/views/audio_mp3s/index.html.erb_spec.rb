require 'spec_helper'

describe "audio_mp3s/index" do
  before(:each) do
    assign(:audio_mp3s, [
      stub_model(AudioMp3,
        :audio_mp3_file_name => "Audio Mp3 File Name",
        :audio_mp3_content_type => "Audio Mp3 Content Type",
        :audio_Mp3_file_size => 1,
        :audio_content_id => 2,
        :audio_title => "Audio Title"
      ),
      stub_model(AudioMp3,
        :audio_mp3_file_name => "Audio Mp3 File Name",
        :audio_mp3_content_type => "Audio Mp3 Content Type",
        :audio_Mp3_file_size => 1,
        :audio_content_id => 2,
        :audio_title => "Audio Title"
      )
    ])
  end

  it "renders a list of audio_mp3s" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Audio Mp3 File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Audio Mp3 Content Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Audio Title".to_s, :count => 2
  end
end
