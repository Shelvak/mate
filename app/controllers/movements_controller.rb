class MovementsController < ApplicationController
  before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource
  
  # GET /movements
  # GET /movements.json
  def index
    @title = t('view.movements.index_title')
    @searchable = true
    @movements = Movement.filtered_list(params[:q]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movements }
    end
  end

  # GET /movements/1
  # GET /movements/1.json
  def show
    @title = t('view.movements.show_title')
    @movement = Movement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movement }
    end
  end

  # GET /movements/new
  # GET /movements/new.json
  def new
    @title = t('view.movements.new_title')
    @movement = Movement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movement }
    end
  end

  # GET /movements/1/edit
  def edit
    @title = t('view.movements.edit_title')
    @movement = Movement.find(params[:id])
  end

  # POST /movements
  # POST /movements.json
  def create
    @title = t('view.movements.new_title')
    @movement = Movement.new(params[:movement])

    respond_to do |format|
      if @movement.save
        format.html { redirect_to @movement, notice: t('view.movements.correctly_created') }
        format.json { render json: @movement, status: :created, location: @movement }
      else
        format.html { render action: 'new' }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movements/1
  # PUT /movements/1.json
  def update
    @title = t('view.movements.edit_title')
    @movement = Movement.find(params[:id])

    respond_to do |format|
      if @movement.update_attributes(params[:movement])
        format.html { redirect_to @movement, notice: t('view.movements.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_movement_url(@movement), alert: t('view.movements.stale_object_error')
  end

  # DELETE /movements/1
  # DELETE /movements/1.json
  def destroy
    @movement = Movement.find(params[:id])
    @movement.destroy

    respond_to do |format|
      format.html { redirect_to movements_url }
      format.json { head :ok }
    end
  end

  def autocomplete_for_bank_name
    banks = Bank.filtered_list(params[:q]).order('name DESC').limit(10)

    respond_to do |format|
      format.json { render json: banks }
    end
  end

  def autocomplete_for_code_number
    codes = Code.filtered_list(params[:q]).order('number DESC').limit(10)

    respond_to do |format|
      format.json { render json: codes }
    end
  end

  def autocomplete_for_client_name
    clients = Client.filtered_list(params[:q]).order('name DESC').limit(10)

    respond_to do |format|
      format.json { render json: clients }
    end
  end
end
