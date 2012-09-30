class ClientsController < ApplicationController
  before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource 
  
  # GET /clients
  # GET /clients.json
  def index
    @title = t('view.clients.index_title')
    @searchable = true
    @clients = Client.filtered_list(params[:q]).order('name DESC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @title = t('view.clients.show_title')
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @title = t('view.clients.new_title')
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @title = t('view.clients.edit_title')
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @title = t('view.clients.new_title')
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: t('view.clients.correctly_created') }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: 'new' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @title = t('view.clients.edit_title')
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: t('view.clients.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_client_url(@client), alert: t('view.clients.stale_object_error')
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url, notice: t('view.clients.correctly_deleted') }
      format.json { head :ok }
    end
  end

  def autocomplete_for_workplace_name
    workplaces = Workplace.filtered_list(params[:q]).order('address DESC').limit 10

    respond_to do |format|
      format.json { render json: workplaces } 
    end
  end
end
