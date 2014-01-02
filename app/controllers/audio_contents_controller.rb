class AudioContentsController < ApplicationController
  # GET /audio_contents
  # GET /audio_contents.json
  def index
    @audio_contents = AudioContent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audio_contents }
    end
  end

  # GET /audio_contents/1
  # GET /audio_contents/1.json
  def show
    @audio_content = AudioContent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @audio_content }
    end
  end

  def display
    @audio_contents = AudioContent.all
    @page = Page.where(:url => "/display").first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audio_contents }
    end
  end
end
