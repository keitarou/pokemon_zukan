# coding: utf-8
require 'json'

class PokemonZukan

  DATA_DIR = File.dirname(__FILE__) + '/../data'

  def self.find(no, series="xy")
    file = File.open("#{DATA_DIR}/#{series}/#{no}.json")
    json = JSON.parser.new(file.read())
    file.close

    hash = json.parse()
    self.no = hash["no"]
    self.name = hash["name"]

    return self
  end
end
