require 'spec_helper'

describe "audio_contents/index" do
  before(:each) do
    assign(:audio_contents, [
      stub_model(AudioContent,
        :title => "Title",
        :url => "Url",
        :content_fragment_id => 1
      ),
      stub_model(AudioContent,
        :title => "Title",
        :url => "Url",
        :content_fragment_id => 1
      )
    ])
  end

  it "renders a list of audio_contents" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
