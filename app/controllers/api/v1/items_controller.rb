class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    new_item = Item.create(item_params)
    render json: ItemSerializer.new(new_item), status: 201
  end

  def update 
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item)
    else
      render json: "", status: 400
    end
  end

  def destroy
    item = Item.find(params[:id])
    invoice_ids = item.invoice_items.pluck(:invoice_id)
    invoices = Invoice.find(invoice_ids)
    if invoices.any?
      Invoice.delete_invoices(invoices, item)
      item.destroy
      render status: :no_content
    elsif item.destroy
      render status: :no_content
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end