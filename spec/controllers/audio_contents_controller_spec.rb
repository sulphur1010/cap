require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AudioContentsController do

  # This should return the minimal set of attributes required to create a valid
  # AudioContent. As you add validations to AudioContent, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "title" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AudioContentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all audio_contents as @audio_contents" do
      audio_content = AudioContent.create! valid_attributes
      get :index, {}, valid_session
      assigns(:audio_contents).should eq([audio_content])
    end
  end

  describe "GET show" do
    it "assigns the requested audio_content as @audio_content" do
      audio_content = AudioContent.create! valid_attributes
      get :show, {:id => audio_content.to_param}, valid_session
      assigns(:audio_content).should eq(audio_content)
    end
  end

  describe "GET new" do
    it "assigns a new audio_content as @audio_content" do
      get :new, {}, valid_session
      assigns(:audio_content).should be_a_new(AudioContent)
    end
  end

  describe "GET edit" do
    it "assigns the requested audio_content as @audio_content" do
      audio_content = AudioContent.create! valid_attributes
      get :edit, {:id => audio_content.to_param}, valid_session
      assigns(:audio_content).should eq(audio_content)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new AudioContent" do
        expect {
          post :create, {:audio_content => valid_attributes}, valid_session
        }.to change(AudioContent, :count).by(1)
      end

      it "assigns a newly created audio_content as @audio_content" do
        post :create, {:audio_content => valid_attributes}, valid_session
        assigns(:audio_content).should be_a(AudioContent)
        assigns(:audio_content).should be_persisted
      end

      it "redirects to the created audio_content" do
        post :create, {:audio_content => valid_attributes}, valid_session
        response.should redirect_to(AudioContent.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved audio_content as @audio_content" do
        # Trigger the behavior that occurs when invalid params are submitted
        AudioContent.any_instance.stub(:save).and_return(false)
        post :create, {:audio_content => { "title" => "invalid value" }}, valid_session
        assigns(:audio_content).should be_a_new(AudioContent)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        AudioContent.any_instance.stub(:save).and_return(false)
        post :create, {:audio_content => { "title" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested audio_content" do
        audio_content = AudioContent.create! valid_attributes
        # Assuming there are no other audio_contents in the database, this
        # specifies that the AudioContent created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        AudioContent.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
        put :update, {:id => audio_content.to_param, :audio_content => { "title" => "MyString" }}, valid_session
      end

      it "assigns the requested audio_content as @audio_content" do
        audio_content = AudioContent.create! valid_attributes
        put :update, {:id => audio_content.to_param, :audio_content => valid_attributes}, valid_session
        assigns(:audio_content).should eq(audio_content)
      end

      it "redirects to the audio_content" do
        audio_content = AudioContent.create! valid_attributes
        put :update, {:id => audio_content.to_param, :audio_content => valid_attributes}, valid_session
        response.should redirect_to(audio_content)
      end
    end

    describe "with invalid params" do
      it "assigns the audio_content as @audio_content" do
        audio_content = AudioContent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AudioContent.any_instance.stub(:save).and_return(false)
        put :update, {:id => audio_content.to_param, :audio_content => { "title" => "invalid value" }}, valid_session
        assigns(:audio_content).should eq(audio_content)
      end

      it "re-renders the 'edit' template" do
        audio_content = AudioContent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        AudioContent.any_instance.stub(:save).and_return(false)
        put :update, {:id => audio_content.to_param, :audio_content => { "title" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested audio_content" do
      audio_content = AudioContent.create! valid_attributes
      expect {
        delete :destroy, {:id => audio_content.to_param}, valid_session
      }.to change(AudioContent, :count).by(-1)
    end

    it "redirects to the audio_contents list" do
      audio_content = AudioContent.create! valid_attributes
      delete :destroy, {:id => audio_content.to_param}, valid_session
      response.should redirect_to(audio_contents_url)
    end
  end

end