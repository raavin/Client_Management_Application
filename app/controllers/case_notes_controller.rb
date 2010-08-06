class CaseNotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_client
  layout "application"
  cattr_reader :per_page
  @@per_page = 50
  filter_resource_access
  # GET /case_notes
  # GET /case_notes.xml
  def index
    @services   = Service.all
    @case_notes = @client.case_notes.paginate :page => params[:page], :per_page => 10, :order => "created_at DESC"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @case_notes }
    end
  end

  # GET /case_notes/1
  # GET /case_notes/1.xml
  def show
    @services = Service.all

    @case_note = @client.case_notes.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @case_note }
    end
  end

  # GET /case_notes/new
  # GET /case_notes/new.xml
  def new
    @services = Service.all

    @case_note = @client.case_notes.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @case_note }
    end
  end

  # GET /case_notes/1/edit
  def edit
    @services = Service.all

    @case_note = @client.case_notes.find(params[:id])
  end

  # POST /case_notes
  # POST /case_notes.xml
  def create
    @services = Service.find(:all)
    @case_note = @client.case_notes.build(params[:case_note])
    @case_note.user_id = current_user.id
    
    respond_to do |format|
      if @case_note.save
        format.html { redirect_to(client_case_notes_path, :notice => 'CaseNote was successfully created.') }
        format.xml  { render :xml => @case_note, :status => :created, :location => @case_note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @case_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /case_notes/1
  # PUT /case_notes/1.xml
  def update
  
    @case_note = CaseNote.find(params[:id])
    @case_note.user_id = current_user.id
    
    respond_to do |format|
      if @case_note.update_attributes(params[:case_note])
        format.html { redirect_to(client_case_notes_path, :notice => 'CaseNote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @case_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /case_notes/1
  # DELETE /case_notes/1.xml
  def destroy
      
    @case_note = CaseNote.find(params[:id])
    @case_note.destroy

    respond_to do |format|
      format.html { redirect_to(client_case_notes_url) }
      format.xml  { head :ok }
    end
  end
  
private
  
  def get_client
     @client = Client.find(params[:client_id])
  end 
end
