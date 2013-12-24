#coding: utf-8
require './helper.rb'
require './../lib/pokemon_zukan'

class TestPokemonZukan < Test::Unit::TestCase

  def test_find
    pokemon = PokemonZukan::find 1
    assert_equal("フシギダネ", pokemon.name)
  end

  def test_Numeric_to_pokemon
    pokemon = 1.to_pokemon
    assert_equal("フシギダネ", pokemon.name)
  end

  def test_String_to_pokemon
    pokemon = "フシギダネ".to_pokemon
    assert_equal("フシギダネ", pokemon.name)
  end

  def test_Array_to_pokemon
    pokemons = [1, 2, "フシギバナ"].to_pokemon
    assert_equal("フシギダネ", pokemons[0].name)
    assert_equal("フシギソウ", pokemons[1].name)
    assert_equal("フシギバナ", pokemons[2].name)
  end

  def test_find_all
    pokemons = PokemonZukan::find_all([1, 2, 3])
    assert_equal("フシギダネ", pokemons[0].name)
    assert_equal("フシギソウ", pokemons[1].name)
    assert_equal("フシギバナ", pokemons[2].name)
  end

  def test_find_by_name
    pokemon = PokemonZukan::find_by_name("フシギダネ")
    assert_equal("フシギダネ", pokemon.name)
  end

  def test_find_all_by_name
    pokemons = PokemonZukan::find_all_by_name(["フシギダネ", "フシギソウ", "フシギバナ"])
    assert_equal("フシギダネ", pokemons[0].name)
    assert_equal("フシギソウ", pokemons[1].name)
    assert_equal("フシギバナ", pokemons[2].name)
  end

  def test_find_by_type
    pokemons = PokemonZukan::find_by_type "くさ"
    assert_equal("くさ", pokemons[0].type[0])
  end

  def test_find_all_by_type
    pokemons = PokemonZukan::find_all_by_type(["くさ", "ほのお"])
    assert_equal("くさ", pokemons[0][0].type[0])
  end

  def test_next
    pokemon1 = 1.to_pokemon
    pokemon2 = 2.to_pokemon
    assert_equal(pokemon2.name, pokemon1.next.name)
  end

  def test_prev
    pokemon1 = 1.to_pokemon
    pokemon2 = 2.to_pokemon
    assert_equal(pokemon1.name, pokemon2.prev.name)
  end
end
