require 'spec_helper'

describe "audio_contents/show" do
  before(:each) do
    @audio_content = assign(:audio_content, stub_model(AudioContent,
      :title => "Title",
      :url => "Url",
      :content_fragment_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Url/)
    rendered.should match(/1/)
  end
end
