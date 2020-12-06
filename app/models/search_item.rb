class SearchItem < ApplicationRecord

    def self.search(query)
        queryTerm = query.split(" ").join("+")

        system("node app/models/concerns/scraper.js #{queryTerm}")
    end

    def self.read_results
        file = File.open("app/models/concerns/search_results.txt")
        results = file.readlines.map(&:chomp)
        file.close
        return results.map {|result| result.split("<|>")}
    end
end
