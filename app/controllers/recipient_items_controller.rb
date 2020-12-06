class RecipientItemsController < ApplicationController

    def index 
        recipient_items = RecipientItem.where(recipient_id: params[:recipient_id])
        sorted_recipient_items = recipient_items.sort_by { |ri| ri["updated_at"] }

        render json: sorted_recipient_items.to_json(
            :include => {
                :recipient => { :except => [:created_at, :updated_at] },
                :item => { :except => [:created_at, :updated_at] }
            }, except: [:created_at]
        )
    end

    def show 
        recipient_item = RecipientItem.find(params[:id])
        render json: recipient_item.to_json(
            :include => {
                :recipient => { :except => [:created_at, :updated_at] },
                :item => { :except => [:created_at, :updated_at] }
            }, except: [:created_at, :updated_at]
        )
    end

    def create
        recipient_item = RecipientItem.create(recipient_item_params)
        render json:recipient_item, except: [:created_at, :updated_at]
    end

    def update
        recipient_item = RecipientItem.find(params[:id])
        recipient_item.update(recipient_item_params)
        render json: recipient_item, except: [:created_at, :updated_at]
    end

    def destroy
        recipient_item = RecipientItem.find(params[:id])
        recipient_item.destroy
    end

    private
    def recipient_item_params
        params.require(:recipient_item).permit(:recipient_id, :item_id, :bought, :price)
    end
end
