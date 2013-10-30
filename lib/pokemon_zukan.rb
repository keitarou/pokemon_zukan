# coding: utf-8
require 'json'

class PokemonZukan

  DATA_DIR = File.dirname(__FILE__) + '/../data'

  attr_reader :no, :name, :type, :classification, :tribeValue

  def initialize(data={})
    @no = data["no"]
    @name = data["name"]
    @type = data["type"]
    @classification = data["classification"]
    @tribeValue = data["tribeValue"]
  end

  def self.find(no="", series="xy")
    no = format("%03d", no.to_i)
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

  def self.find_by_name(name="", series="xy")
    file = File.open("#{DATA_DIR}/#{series}/name_table.json")
    json = JSON.parser.new(file.read())
    file.close

    hash = json.parse()
    return self.find(hash[name], series)
  end

  def self.find_all_by_name(names=[], series="xy")
    retData = []
    names.each do |name|
      retData.push self.find_by_name(name, series)
    end
    return retData
  end

  def self.find_by_type(type="", series="xy")
    file = File.open("#{DATA_DIR}/#{series}/type_table.json")
    json = JSON.parser.new(file.read())
    file.close

    hash = json.parse()
    return self.find_all(hash[type], series)
  end

  def self.find_all_by_type(types=[], series="xy")
    retData = []
    types.each do |type|
      retData.push self.find_by_type(type, series)
    end
    return retData
  end

  def next(series="xy")
    PokemonZukan::find(@no.to_i+1, series)
  end

  def prev(series="xy")
    PokemonZukan::find(@no.to_i-1, series)
  end
end
