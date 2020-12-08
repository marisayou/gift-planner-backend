require 'sqlite3'

db = SQLite3::Database.open "development.sqlite3"
records = db.execute("SELECT id, price, link FROM items")

# array of ids
ids = records.map do |record|
    record[0]
end

# array of prices
prices = records.map do |record|
    record[1]
end

# array of links
links = records.map do |record|
    record[2]
end
str_links = links.to_s
str_links = str_links[1...str_links.length - 1]

# get new prices using links
system("node ../app/models/concerns/track_price.js #{str_links}")
file = File.open("../app/models/concerns/updated_price.txt")
new_prices = file.readlines.map do |price|
    price.to_f
end
file.close

# update price changes
for i in 0...prices.count
    if new_prices[i] != prices[i] 
        db.execute("UPDATE items SET price = #{new_prices[i]} WHERE id = #{ids[i]}")
    end
end