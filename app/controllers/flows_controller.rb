class FlowsController < ApplicationController
  before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource 
  
  # GET /flows
  # GET /flows.json
  def index
    @title = t('view.flows.index_title')
    @flows = Flow.filtered_list(params[:q]).order(
      'charged_at DESC'
    ).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @flows }
    end
  end

  # GET /flows/1
  # GET /flows/1.json
  def show
    @title = t('view.flows.show_title')
    @flow = Flow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flow }
    end
  end

  # GET /flows/new
  # GET /flows/new.json
  def new
    @title = t('view.flows.new_title')
    @flow = Flow.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @flow }
    end
  end

  # GET /flows/1/edit
  def edit
    @title = t('view.flows.edit_title')
    @flow = Flow.find(params[:id])
  end

  # POST /flows
  # POST /flows.json
  def create
    @title = t('view.flows.new_title')
    @flow = Flow.new(params[:flow])

    respond_to do |format|
      if @flow.save
        format.html { redirect_to @flow, notice: t('view.flows.correctly_created') }
        format.json { render json: @flow, status: :created, location: @flow }
      else
        format.html { render action: 'new' }
        format.json { render json: @flow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /flows/1
  # PUT /flows/1.json
  def update
    @title = t('view.flows.edit_title')
    @flow = Flow.find(params[:id])

    respond_to do |format|
      if @flow.update_attributes(params[:flow])
        format.html { redirect_to @flow, notice: t('view.flows.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @flow.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_flow_url(@flow), alert: t('view.flows.stale_object_error')
  end

  # DELETE /flows/1
  # DELETE /flows/1.json
  def destroy
    @flow = Flow.find(params[:id])
    @flow.destroy

    respond_to do |format|
      format.html { redirect_to flows_url, notice: t('view.flows.correctly_deleted') }
      format.json { head :ok }
    end
  end
end
