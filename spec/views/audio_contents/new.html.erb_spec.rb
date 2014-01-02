require 'spec_helper'

describe "audio_contents/new" do
  before(:each) do
    assign(:audio_content, stub_model(AudioContent,
      :title => "MyString",
      :url => "MyString",
      :content_fragment_id => 1
    ).as_new_record)
  end

  it "renders new audio_content form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", audio_contents_path, "post" do
      assert_select "input#audio_content_title[name=?]", "audio_content[title]"
      assert_select "input#audio_content_url[name=?]", "audio_content[url]"
      assert_select "input#audio_content_content_fragment_id[name=?]", "audio_content[content_fragment_id]"
    end
  end
end
