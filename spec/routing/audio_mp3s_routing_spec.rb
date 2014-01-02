require "spec_helper"

describe AudioMp3sController do
  describe "routing" do

    it "routes to #index" do
      get("/audio_mp3s").should route_to("audio_mp3s#index")
    end

    it "routes to #new" do
      get("/audio_mp3s/new").should route_to("audio_mp3s#new")
    end

    it "routes to #show" do
      get("/audio_mp3s/1").should route_to("audio_mp3s#show", :id => "1")
    end

    it "routes to #edit" do
      get("/audio_mp3s/1/edit").should route_to("audio_mp3s#edit", :id => "1")
    end

    it "routes to #create" do
      post("/audio_mp3s").should route_to("audio_mp3s#create")
    end

    it "routes to #update" do
      put("/audio_mp3s/1").should route_to("audio_mp3s#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/audio_mp3s/1").should route_to("audio_mp3s#destroy", :id => "1")
    end

  end
end
