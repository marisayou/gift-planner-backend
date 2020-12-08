require 'sqlite3'

Item.all.each do |item|
    link = item.link
    system("node app/models/concerns/track_price.js #{link}")
    new_price = File.read("app/models/concerns/updated_price.txt")
    puts new_price
    if (new_price != item.price) 
        item.update(price: new_price.to_f)
    end
end