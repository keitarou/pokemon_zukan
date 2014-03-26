# coding: utf-8
require 'json'

class Numeric
  def to_pokemon
    PokemonZukan::find self
  end
end

class String
  def to_pokemon
    PokemonZukan::find_by_name self
  end
end

class Array
  def to_pokemon
    self.map{|value| value.to_pokemon}
  end
end

class PokemonZukan

  DATA_DIR = File.dirname(__FILE__) + '/../data'
  LANGUAGE = 'ja'

  attr_reader :no, :name, :type, :classification, :tribeValue, :height, :weight

  def initialize(data={})
    @no             = data["no"]
    @name           = data["name"]
    @type           = data["type"]
    @classification = data["classification"]
    @tribeValue     = data["tribeValue"]
    @height         = data["height"]
    @weight         = data["weight"]
  end

  def self.find(no="", series="xy")
    no = format("%03d", no.to_i)
    file = File.open("#{DATA_DIR}/#{series}/#{LANGUAGE}/#{no}.json")
    json = JSON.parser.new(file.read())
    file.close

    hash = json.parse()
    PokemonZukan.new(hash)
  end

  def self.find_all(nos=[], series="xy")
    nos.map{|no| PokemonZukan::find(no, series)}
  end

  def self.find_by_name(name="", series="xy")
    file = File.open("#{DATA_DIR}/#{series}/#{LANGUAGE}/name_table.json")
    json = JSON.parser.new(file.read())
    file.close

    hash = json.parse()
    PokemonZukan::find(hash[name], series)
  end

  def self.find_all_by_name(names=[], series="xy")
    names.map{|name| PokemonZukan::find_by_name(name, series)}
  end

  def self.find_by_type(type="", series="xy")
    file = File.open("#{DATA_DIR}/#{series}/#{LANGUAGE}/type_table.json")
    json = JSON.parser.new(file.read())
    file.close

    hash = json.parse()
    PokemonZukan::find_all(hash[type], series)
  end

  def self.find_all_by_type(types=[], series="xy")
    types.map{|type| PokemonZukan::find_by_type(type, series)}
  end

  def next(series="xy")
    PokemonZukan::find(@no.to_i+1, series)
  end

  def prev(series="xy")
    PokemonZukan::find(@no.to_i-1, series)
  end
end
