class Admin::AudioContentsController < ApplicationController
  
  before_filter :require_admin!

  # GET /audio_contents
  # GET /audio_contents.json
  def index
    @audio_contents = AudioContent.all
    @audio_mp3s = AudioMp3.all
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

  # GET /audio_contents/new
  # GET /audio_contents/new.json
  def new
    @audio_content = AudioContent.new
    3.times {@audio_content.audio_mp3s.build}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @audio_content }
    end
  end

  # GET /audio_contents/1/edit
  def edit
    @audio_content = AudioContent.find(params[:id])
    3.times {@audio_content.audio_mp3s.build}
  end

  # POST /audio_contents
  # POST /audio_contents.json
  def create
    @audio_content = AudioContent.new(params[:audio_content])
    respond_to do |format|
      if @audio_content.save
        format.html { redirect_to admin_audio_contents_url, notice: 'Audio content was successfully created.' }
        format.json { render json: @audio_content, status: :created, location: @audio_content }
      else
        format.html { render action: "new" }
        format.json { render json: @audio_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /audio_contents/1
  # PUT /audio_contents/1.json
  def update
    @audio_content = AudioContent.find(params[:id])
    respond_to do |format|
      if @audio_content.update_attributes(params[:audio_content])
        format.html { redirect_to audio_content_path(@audio_content), notice: 'Audio content was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @audio_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audio_contents/1
  # DELETE /audio_contents/1.json
  def destroy
    @audio_content = AudioContent.find(params[:id])
    @audio_mp3s = AudioMp3.find_all_by_audio_content_id([@audio_content.id])
    @audio_mp3s.each do |audio_mp3|
      audio_mp3.destroy
    end
    @audio_content.destroy

    respond_to do |format|
      format.html { redirect_to admin_audio_contents_url }
      format.json { head :no_content }
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
