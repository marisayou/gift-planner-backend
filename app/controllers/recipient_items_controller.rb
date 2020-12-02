class RecipientItemsController < ApplicationController

    # def create

    # end

    def show 
        recipient_item = RecipientItem.find(params[:id])
        render json: recipient_item, except: [:created_at, :updated_at]
    end

    def update
        recipient_item = RecipientItem.find(params[:id])
        recipient_item.update(recipient_item_params)
        render json: recipient_item, except: [:created_at, :updated_at]
    end

    # def destroy

    # end

    private
    def recipient_item_params
        params.require(:recipient_item).permit(:recipient_id, :item_id, :bought, :price)
    end
end
