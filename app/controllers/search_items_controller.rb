class SearchItemsController < ApplicationController

    def create
        SearchItem.search(params[:query])
        puts params[:query]
        results = SearchItem.read_results()
        for i in 0...results.count
            name = results[i][0]
            price = results[i][1].to_f
            link = results[i][2]
            image_url = results[i][3]
            SearchItem.create(name: name, price: price, link: link, image_url: image_url)
        end
    end

    def index
        search_items = SearchItem.all
        render json: search_items, except: [:created_at, :updated_at]
    end

    def destroy
        SearchItem.all.destroy_all
    end
end
