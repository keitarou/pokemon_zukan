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
    no = format("%03d", no)
    file = File.open("#{DATA_DIR}/#{series}/#{no}.json")
    json = JSON.parser.new(file.read())
    file.close

    hash = json.parse()
    return PokemonZukan.new(hash)
  end

  def self.find_all(nos=[], series="xy")
    retData = []
    nos.each do |no|
      retData.push self.find(no, series)
    end
    return retData
  end
end
