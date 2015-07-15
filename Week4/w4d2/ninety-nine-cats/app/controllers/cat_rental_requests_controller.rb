class CatRentalRequestsController < ApplicationController

  def show
    @rental_request = CatRentalRequest.find(params[:id])
    redirect_to cat_url(@rental_request.cat_id)
  end

  def new
    @cats = Cat.all
    @rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cats = Cat.all
    @rental_request = CatRentalRequest.new(cat_rental_requests_params)
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat_id)
    else
      render :new
    end
  end

  def edit
    @cats = Cat.all
    @rental_request = CatRentalRequest.find(params[:id])
    render :edit
  end

  def update
    @cats = Cat.all
    @rental_request = CatRentalRequest.find(params[:id])
    if @rental_request.update(cat_rental_requests_params)
      redirect_to cat_rental_request_url(@rental_request)
    else
      render :edit
    end
  end

  def approve
    request = CatRentalRequest.find(params[:id])
    request.approve!
    redirect_to cat_url(request.cat_id)
  end

  def deny
    request = CatRentalRequest.find(params[:id])
    request.deny!
    redirect_to cat_url(request.cat_id)
  end

  private

  def cat_rental_requests_params
    params
      .require(:cat_rental_request)
      .permit(:start_date, :end_date, :cat_id)
  end
end
