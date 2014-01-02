require 'spec_helper'

describe "audio_mp3s/show" do
  before(:each) do
    @audio_mp3 = assign(:audio_mp3, stub_model(AudioMp3,
      :audio_mp3_file_name => "Audio Mp3 File Name",
      :audio_mp3_content_type => "Audio Mp3 Content Type",
      :audio_Mp3_file_size => 1,
      :audio_content_id => 2,
      :audio_title => "Audio Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Audio Mp3 File Name/)
    rendered.should match(/Audio Mp3 Content Type/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Audio Title/)
  end
end
