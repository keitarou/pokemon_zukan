#coding: utf-8
require 'spec_helper'

describe PokemonZukan, "find method" do
  it "should be find 1 is 001" do
    PokemonZukan::find(1).no.should == '001'
  end

  it "should be find 001 is 001" do
    PokemonZukan::find('001').no.should == '001'
  end

  it "should be find_all [1, 002] is 001 and 002" do
    pokemons = PokemonZukan::find_all([1, '002'])
    pokemons.first.no.should == '001'
    pokemons.last.no.should  == '002'
  end

  it "should be find_all [1, 719] is 719 is nobody" do
    expect{
      PokemonZukan::find_all([1, '719'])
    }.to raise_error
  end

  it "should be find_by_name ピカチュウ no is 025" do
    PokemonZukan::find_by_name('ピカチュウ').no.should == '025'
  end

  it "should be find_by_name ゴリチュウ is nobody" do
    expect{
      PokemonZukan::find_by_name('ゴリチュウ')
    }.to raise_error
  end

  it "should be find_all_by_name ピカチュウ, ライチュウ no is 025 and 026" do
    pokemons = PokemonZukan::find_all_by_name(['ピカチュウ', 'ライチュウ'])
    pokemons.first.no.should == '025'
    pokemons.last.no.should  == '026'
  end

end

describe PokemonZukan, "pokemon is hushigidane" do
  before do
    @pokemon = PokemonZukan::find(1)
  end

  it "should be no is 001" do
    @pokemon.no.should == '001'
  end

  it "should be name is hushigidane" do
    @pokemon.name.should == 'フシギダネ'
  end

  it "should be type is array" do
    @pokemon.type.instance_of?(Array).should be_true
  end

  it "should be classification is tane pokemon" do
    @pokemon.classification.should == 'たねポケモン'
  end

  it "should be tribeValue is array" do
    @pokemon.tribeValue.instance_of?(Array).should be_true
    @pokemon.tribeValue.size.should == 6
    @pokemon.tribeValue[0].instance_of?(String).should be_true
    @pokemon.tribeValue[1].instance_of?(String).should be_true
    @pokemon.tribeValue[2].instance_of?(String).should be_true
    @pokemon.tribeValue[3].instance_of?(String).should be_true
    @pokemon.tribeValue[4].instance_of?(String).should be_true
    @pokemon.tribeValue[5].instance_of?(String).should be_true
  end

  it "should be height is string" do
    @pokemon.height.instance_of?(String).should be_true
  end

  it "should be weight is string" do
    @pokemon.weight.instance_of?(String).should be_true
  end

  it "should be next pokemon is hushigisou" do
    @pokemon.next.name.should == 'フシギソウ'
  end

  it "should be prev pokemon is nobody" do
    expect{
      @pokemon.prev
    }.to raise_error
  end

  it "should be pokemon count is 718" do
    717.times do
      @pokemon = @pokemon.next
    end
    expect{
      @pokemon.next
    }.to raise_error
  end

  after do
  end
end

describe PokemonZukan, "open class methods" do
  before do
    @pokemon1 = 1.to_pokemon
    @pokemon2 = 'フシギダネ'.to_pokemon
    @pokemons = [1, 'フシギダネ'].to_pokemon
  end

  it "should be pokemon1.name == pokemon2.name" do
    (@pokemon1.name == @pokemon2.name).should be_true
  end

  it "should be pokemon1 and pokemon2 == pokemons" do
    (@pokemon1.name == @pokemons.first.name).should be_true
    (@pokemon2.name == @pokemons.last.name) .should be_true
  end

  it "should be 719.to_pokemon is nobody" do
    expect{ 719.to_pokemon }.to raise_error
  end

  it "should be 'ゴリチュウ'.to_pokemon is nobody" do
    expect{ 'ゴリチュウ'.to_pokemon }.to raise_error
  end
end
