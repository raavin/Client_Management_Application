class ExpendituresController < ApplicationController
  in_place_edit_for :expenditure, :amount
  before_filter :authenticate_user!
  #before_filter :get_client 
  layout "expenditure"
  cattr_reader :per_page
  @@per_page = 50
  filter_access_to :all
  
  # GET /expenditures
  # GET /expenditures.xml
  def index
    @client = Client.find(params[:client_id])
    @services   = Service.all
    @expenditures = @client.expenditures.paginate :page => params[:page], :per_page => 10, :order => "created_at DESC"
    @client_total = Expenditure.calculate(:sum, :amount, :conditions => ['client_id = ?', params[:client_id]])
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenditures }
    end
  end
  
    def all
    @clients = Client.all
    @services   = Service.all
    @expenditures = Expenditure.paginate :page => params[:page], :per_page => 30, :order => "created_at DESC"
    @client_total = Expenditure.calculate(:sum, :amount, :conditions => ['client_id = ?', params[:client_id]])
    @total = Expenditure.calculate(:sum, :amount)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenditures }
    end
  end

  # GET /expenditures/1
  # GET /expenditures/1.xml
  def show
    @client = Client.find(params[:client_id])
    @services = Service.all

    @expenditure = @client.expenditures.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expenditure }
    end
  end

  # GET /expenditures/new
  # GET /expenditures/new.xml
  def new
    @client = Client.find(params[:client_id])
    @services = Service.all

    @expenditure = @client.expenditures.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expenditure }
    end
  end

  # GET /expenditures/1/edit
  def edit
    @client = Client.find(params[:client_id])
    @services = Service.all
    @expenditure = @client.expenditures.find(params[:id])
  end

  # POST /expenditures
  # POST /expenditures.xml
  def create
    @client = Client.find(params[:client_id])
    @services = Service.find(:all)
    @expenditure = @client.expenditures.build(params[:expenditure])
    @expenditure.user_id = current_user.id
    @expenditure.service_id = params[:category][:service_id]
    
    respond_to do |format|
      if @expenditure.save
        format.html { redirect_to(client_expenditure_path(@client, @expenditure), :notice => 'Expenditure was successfully created.') }
        format.xml  { render :xml => @expenditure, :status => :created, :location => @expenditure }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expenditure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expenditures/1
  # PUT /expenditures/1.xml
  def update
    @client = Client.find(params[:client_id])
  
    @expenditure = Expenditure.find(params[:id])
    @expenditure.user_id = current_user.id
    @expenditure.service_id = params[:category][:service_id]
    
    respond_to do |format|
      if @expenditure.update_attributes(params[:expenditure])
        format.html { redirect_to(client_expenditures_path, :notice => 'Expenditure was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expenditure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expenditures/1
  # DELETE /expenditures/1.xml
  def destroy
    @client = Client.find(params[:client_id])
      
    @expenditure = Expenditure.find(params[:id])
    @expenditure.destroy

    respond_to do |format|
      format.html { redirect_to(client_expenditures_url) }
      format.xml  { head :ok }
    end
  end
  
private
  
  def get_client
     @client = Client.find(params[:client_id])
  end 
end
