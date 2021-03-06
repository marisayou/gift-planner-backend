class ItemsController < ApplicationController

    def index
        items = Item.all
        render json: items, except: [:created_at, :updated_at]
    end

    def show
        item = Item.find(params[:id])
        render json: item.to_json(
            :include => {
                :recipient_items => {
                    :except => [:created_at, :updated_at]
                }
            }, 
            :except => [:created_at, :updated_at]
        ) 
    end

    def create
        item = Item.create(item_params)
        render json: item, except: [:created_at, :updated_at]
    end

    def update
        item = Item.find(params[:id])
        item.update(item_params)
        render json: item, except: [:created_at, :updated_at]
    end

    def destroy
        item = Item.find(params[:id])
        item.destroy
    end

    private
    def item_params
        params.require(:item).permit(:name, :price, :link, :image_url)
    end

end
