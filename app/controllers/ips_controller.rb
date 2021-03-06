class IpsController < ApplicationController
  # GET /ips
  # GET /ips.xml
  def index
    @ipv4s = Ipv4.all
    @ipv6s = Ipv6.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ips }
    end
  end

  # GET /ips/1
  # GET /ips/1.xml
  def show
    @ip = Ip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ip }
    end
  end

  # GET /ips/new
  # GET /ips/new.xml
  def new
    @ip = Ip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ip }
    end
  end
  
  # GET /ips/new
  # GET /ips/new.xml
  def new_ipv6
    @ip = Ipv6.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ip }
    end
  end
  
  # GET /ips/1/edit
  def edit
    @ip = Ip.find(params[:id])
  end

  # POST /ips
  # POST /ips.xml
  def create
    if params[:ip][:type] == 'Ipv6'
      params[:ip][:prefix] = params[:ip][:prefix_v6] if params[:ip][:prefix_v6]
      params[:ip].delete(:prefix_v4)
      params[:ip].delete(:prefix_v6)
      @ip = Ipv6.new(params[:ip])
    else
      params[:ip][:prefix] = params[:ip][:prefix_v4] if params[:ip][:prefix_v4]
      params[:ip].delete(:prefix_v4)
      params[:ip].delete(:prefix_v6)
      @ip = Ipv4.new(params[:ip])
    end

    respond_to do |format|
      if @ip.save
        format.html { redirect_to(@ip, :notice => 'Ip was successfully created.') }
        format.xml  { render :xml => @ip, :status => :created, :location => @ip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ips/1
  # PUT /ips/1.xml
  def update
    @ip = Ip.find(params[:id])

    respond_to do |format|
      if @ip.update_attributes(params[:ip])
        format.html { redirect_to(@ip, :notice => 'Ip was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ips/1
  # DELETE /ips/1.xml
  def destroy
    @ip = Ip.find(params[:id])
    @ip.destroy

    respond_to do |format|
      format.html { redirect_to(ips_url) }
      format.xml  { head :ok }
    end
  end
end
