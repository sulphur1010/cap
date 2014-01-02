class Admin::AudioMp3sController < ApplicationController
  
  before_filter :require_admin!

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

  # GET /audio_mp3s/new
  # GET /audio_mp3s/new.json
  def new
    @audio_mp3 = AudioMp3.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @audio_mp3 }
    end
  end

  # GET /audio_mp3s/1/edit
  def edit
    @audio_mp3 = AudioMp3.find(params[:id])
  end

  # POST /audio_mp3s
  # POST /audio_mp3s.json
  def create
    @audio_mp3 = AudioMp3.new(params[:audio_mp3])

    respond_to do |format|
      if @audio_mp3.save
        format.html { redirect_to @audio_mp3, notice: 'Audio mp3 was successfully created.' }
        format.json { render json: @audio_mp3, status: :created, location: @audio_mp3 }
      else
        format.html { render action: "new" }
        format.json { render json: @audio_mp3.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /audio_mp3s/1
  # PUT /audio_mp3s/1.json
  def update
    @audio_mp3 = AudioMp3.find(params[:id])

    respond_to do |format|
      if @audio_mp3.update_attributes(params[:audio_mp3])
        format.html { redirect_to audio_mp3_path(@audio_mp3), notice: 'Audio mp3 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @audio_mp3.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audio_mp3s/1
  # DELETE /audio_mp3s/1.json
  def destroy
    @audio_mp3 = AudioMp3.find(params[:id])
    @audio_mp3.destroy

    respond_to do |format|
      format.html { redirect_to admin_audio_contents_url }
      format.json { head :no_content }
    end
  end
end
