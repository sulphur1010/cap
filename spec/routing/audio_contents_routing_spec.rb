require "spec_helper"

describe AudioContentsController do
  describe "routing" do

    it "routes to #index" do
      get("/audio_contents").should route_to("audio_contents#index")
    end

    it "routes to #new" do
      get("/audio_contents/new").should route_to("audio_contents#new")
    end

    it "routes to #show" do
      get("/audio_contents/1").should route_to("audio_contents#show", :id => "1")
    end

    it "routes to #edit" do
      get("/audio_contents/1/edit").should route_to("audio_contents#edit", :id => "1")
    end

    it "routes to #create" do
      post("/audio_contents").should route_to("audio_contents#create")
    end

    it "routes to #update" do
      put("/audio_contents/1").should route_to("audio_contents#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/audio_contents/1").should route_to("audio_contents#destroy", :id => "1")
    end

  end
end
