require 'spec_helper'

describe "audio_mp3s/new" do
  before(:each) do
    assign(:audio_mp3, stub_model(AudioMp3,
      :audio_mp3_file_name => "MyString",
      :audio_mp3_content_type => "MyString",
      :audio_Mp3_file_size => 1,
      :audio_content_id => 1,
      :audio_title => "MyString"
    ).as_new_record)
  end

  it "renders new audio_mp3 form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", audio_mp3s_path, "post" do
      assert_select "input#audio_mp3_audio_mp3_file_name[name=?]", "audio_mp3[audio_mp3_file_name]"
      assert_select "input#audio_mp3_audio_mp3_content_type[name=?]", "audio_mp3[audio_mp3_content_type]"
      assert_select "input#audio_mp3_audio_Mp3_file_size[name=?]", "audio_mp3[audio_Mp3_file_size]"
      assert_select "input#audio_mp3_audio_content_id[name=?]", "audio_mp3[audio_content_id]"
      assert_select "input#audio_mp3_audio_title[name=?]", "audio_mp3[audio_title]"
    end
  end
end
