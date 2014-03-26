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

  @@series   = 'xy'
  @@language = 'ja'
  @@data_dir = File.dirname(__FILE__) + '/../data'

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

  def self.file_dir
    "#{@@data_dir}/#{@@series}/#{@@language}/"
  end

  def self.find(no="")
    no = format("%03d", no.to_i)
    file = File.open("#{PokemonZukan.file_dir}/#{no}.json")
    json = JSON.parser.new(file.read())
    file.close

    hash = json.parse()
    PokemonZukan.new(hash)
  end

  def self.find_all(nos=[])
    nos.map{|no| PokemonZukan::find(no)}
  end

  def self.find_by_name(name="")
    file = File.open("#{PokemonZukan.file_dir}/name_table.json")
    json = JSON.parser.new(file.read())
    file.close

    hash = json.parse()
    PokemonZukan::find(hash[name])
  end

  def self.find_all_by_name(names=[])
    names.map{|name| PokemonZukan::find_by_name(name)}
  end

  def self.find_by_type(type="")
    file = File.open("#{PokemonZukan.file_dir}/type_table.json")
    json = JSON.parser.new(file.read())
    file.close

    hash = json.parse()
    PokemonZukan::find_all(hash[type])
  end

  def self.find_all_by_type(types=[])
    types.map{|type| PokemonZukan::find_by_type(type)}
  end

  def next
    PokemonZukan::find(@no.to_i+1)
  end

  def prev
    PokemonZukan::find(@no.to_i-1)
  end
end
