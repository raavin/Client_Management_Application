class WaitingListsController < ApplicationController
  before_filter :authenticate_user!
  layout "application"
  filter_resource_access
  # GET /waiting_lists
  # GET /waiting_lists.xml
  def index
    #@client = Client.find(params[:id])
    @services = Service.all
    @categories = Category.all
    @waiting_lists = WaitingList.paginate :page => params[:page],
      :per_page => 10, 
      :conditions => 
      if !params[:id].nil?
      ['service_id=?', params[:id]+ '%']
      end,
      :order => "completed_date, accepted_date, referral_date, service_id ASC" #,
      #:conditions => ['referral_date LIKE ?', Date.today.to_s + '%']

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @waiting_lists }
    end
  end

  # GET /waiting_lists/1
  # GET /waiting_lists/1.xml
  def show
    @waiting_list = WaitingList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @waiting_list }
    end
  end

  # GET /waiting_lists/new
  # GET /waiting_lists/new.xml
  def new
    @waiting_list = WaitingList.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @waiting_list }
    end
  end

  # GET /waiting_lists/1/edit
  def edit
    @waiting_list = WaitingList.find(params[:id])
  end

  # POST /waiting_lists
  # POST /waiting_lists.xml
  def create
    @waiting_list = WaitingList.new(params[:waiting_list])

    respond_to do |format|
      if @waiting_list.save
        format.html { redirect_to(@waiting_list, :notice => 'WaitingList was successfully created.') }
        format.xml  { render :xml => @waiting_list, :status => :created, :location => @waiting_list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @waiting_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /waiting_lists/1
  # PUT /waiting_lists/1.xml
  def update
    @waiting_list = WaitingList.find(params[:id])

    respond_to do |format|
      if @waiting_list.update_attributes(params[:waiting_list])
        format.html { redirect_to(@waiting_list, :notice => 'WaitingList was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @waiting_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /waiting_lists/1
  # DELETE /waiting_lists/1.xml
  def destroy
    @waiting_list = WaitingList.find(params[:id])
    @waiting_list.destroy

    respond_to do |format|
      format.html { redirect_to(waiting_lists_url) }
      format.xml  { head :ok }
    end
  end
  
    def accept
    @waiting_list = WaitingList.find(params[:id])
    if @waiting_list.update_attributes(
          :accepted_date => Time.now)
      flash[:notice] = 'Client has been accepted.'
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def complete
    @waiting_list = WaitingList.find(params[:id])
    if @waiting_list.update_attributes(
          :completed_date => Time.now)
      flash[:notice] = 'Client contact completed.'
      # redirect_to :action => 'show', :id => @waiting_list
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
  
  def get_client
     @client = Client.find(params[:client_id])
  end 
end
