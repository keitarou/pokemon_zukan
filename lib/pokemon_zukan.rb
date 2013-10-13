# coding: utf-8
require 'json'

class PokemonZukan

  DATA_DIR = File.dirname(__FILE__) + '/../data'

  attr_reader :no, :name

  def initialize(data={})
    @no = data["no"]
    @name = data["name"]
  end

  def self.find(no="", series="xy")

    file = File.open("#{DATA_DIR}/#{series}/#{no}.json")
    json = JSON.parser.new(file.read())
    file.close

    hash = json.parse()
    return PokemonZukan.new(hash)
  end
end
