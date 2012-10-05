class ChargesController < ApplicationController
  
  # GET /charges
  # GET /charges.json
  def index
    @title = t('view.charges.index_title')
    @charges = Charge.order('created_at DESC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @charges }
    end
  end

  # GET /charges/1
  # GET /charges/1.json
  def show
    @title = t('view.charges.show_title')
    @charge = Charge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @charge }
    end
  end

  # GET /charges/new
  # GET /charges/new.json
  def new
    @title = t('view.charges.new_title')
    @charge = Charge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @charge }
    end
  end

  # GET /charges/1/edit
  def edit
    @title = t('view.charges.edit_title')
    @charge = Charge.find(params[:id])
  end

  # POST /charges
  # POST /charges.json
  def create
    @title = t('view.charges.new_title')
    @charge = Charge.new(params[:charge])

    respond_to do |format|
      if @charge.save
        format.html { redirect_to @charge, notice: t('view.charges.correctly_created') }
        format.json { render json: @charge, status: :created, location: @charge }
      else
        format.html { render action: 'new' }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /charges/1
  # PUT /charges/1.json
  def update
    @title = t('view.charges.edit_title')
    @charge = Charge.find(params[:id])

    respond_to do |format|
      if @charge.update_attributes(params[:charge])
        format.html { redirect_to @charge, notice: t('view.charges.correctly_updated') }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @charge.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_charge_url(@charge), alert: t('view.charges.stale_object_error')
  end

  # DELETE /charges/1
  # DELETE /charges/1.json
  def destroy
    @charge = Charge.find(params[:id])
    @charge.destroy

    respond_to do |format|
      format.html { redirect_to charges_url }
      format.json { head :ok }
    end
  end
end
