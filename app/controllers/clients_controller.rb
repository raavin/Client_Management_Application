class ClientsController < ApplicationController
    before_filter :authenticate_user!
    layout "application"
    cattr_reader :per_page
    @@per_page = 50
    filter_access_to :all
  
  # GET /clients
  # GET /clients.xml
  def index
    @countries  = params[:client]
    @categories = Category.find(:all,:order => "service_id, name") 
    if params[:searchclients]
    @clients = Client.paginate :per_page => 100, :page => params[:page], :order => 'first_name, last_name', :conditions => ['first_name LIKE ? OR last_name LIKE ?',"%#{params[:searchclients]}%","%#{params[:searchclients]}%"] 
    @case_notes  = CaseNote.find(:first, :conditions => ['client_id = ?',@client])
  else
    @clients = Client.paginate :per_page => 10, :page => params[:page], :order => 'last_name, first_name'
    # @case_notes  = CaseNote.find(:first, :conditions => ['client_id = ?',"#{4}"])
    end
    @services = Service.find(:all, :order => "service_name")
    @waiting_lists = WaitingList.find(:all)
    @messages = Message.find(:all,:order => "created_at DESC")  

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.xml
  def show
    @client = Client.find(params[:id])
    @services = Service.find(:all, :order => "service_name")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.xml
  def new
    @client = Client.new
    @services = Service.find(:all, :order => "service_name")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    @services = Service.find(:all, :order => "service_name")
  end

  # POST /clients
  # POST /clients.xml
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to(@client, :notice => 'Client was successfully created.') }
        format.xml  { render :xml => @client, :status => :created, :location => @client }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to(@client, :notice => 'Client was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to(clients_url) }
      format.xml  { head :ok }
    end
  end
  
def waiting
    @services = Service.paginate :page => params[:page]
    @waiting_lists = WaitingList.paginate :page => params[:page], :per_page => 50
    if request.post?
      
      for service in @services
        if params[service.service_name + "dd"]
          @waiting_list = WaitingList.create(
          :client_id  => params[:radio],
          :service_id => service.id,
          :category_id => params[service.service_name][:id],
          :referral_date => Time.now
          )
          
          # TODO Need to do the verification Flash notice properly
            
          flash[:notice] = 'Client was successfully added to waiting list.'
          
        else
          flash[:notice] = 'Client was not successfully added to waiting list.'
          @waiting_list = 0
        end
      end
        if @waiting_list
          redirect_to clients_path
        else
          render clients_path
        end
    end
  end
end
