class AudioMp3sController < ApplicationController
  # GET /audio_mp3s
  # GET /audio_mp3s.json
  def index
    @audio_mp3s = AudioMp3.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audio_mp3s }
    end
  end

  # GET /audio_mp3s/1
  # GET /audio_mp3s/1.json
  def show
    @audio_mp3 = AudioMp3.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @audio_mp3 }
    end
  end
end
