class ItemsController < ApplicationController

    def index
        items = Item.all
        render json: items, except: [:created_at, :updated_at]
    end

    def show
        item = Item.find(params[:id])
        render json: item, except: [:created_at, :updated_at]
    end

end
