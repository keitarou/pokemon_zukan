# pokemon_zukan

[![Build Status](https://travis-ci.org/keitarou/pokemon_zukan.svg?branch=develop)](https://travis-ci.org/keitarou/pokemon_zukan)

ポケモン図鑑のgemです。
ポケモンXYの全国図鑑に対応しています

## Install

	gem install pokemon_zukan

## Use

	require 'pokemon_zukan'
 
## Propaties
	@no
	@name

	0.1.0からサポート
	@type

	0.3.1からサポート
	@classification
	@tribeValue

## Methods

	pokemon = PokemonZukan.find("001")
	pokemons = PokemonZukan.find_all(["001", "002", "003"])

	0.1.0からサポート
	pokemon.next
	pokemon.prev
	pokemon = PokemonZukan.find_by_name("ピカチュウ")
	pokemon = PokemonZukan.find_all_by_name(["ピカチュウ", "ライチュウ"])

## Copyright

Copyright (c) 2013 keitarou.oonishi. See LICENSE.txt for
