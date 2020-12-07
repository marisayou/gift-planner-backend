class SearchItemsController < ApplicationController

    def create
        # destroy all search items first if there are any
        SearchItem.all.destroy_all

        # scrape Nordstrom for items and put results in a file
        SearchItem.search(params[:query])

        # read results from file and create search items in db
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
