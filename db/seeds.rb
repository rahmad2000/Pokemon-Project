# This script is designed to interact with the PokeAPI to fetch data about
# Pokemon, their types, abilities, and generations. It then saves this data
# into various Ruby objects for further use.

require 'open-uri'
require 'json'

# The fetch function takes a URL as an argument, opens it using URI, reads the
# data, and then parses it as JSON.
def fetch(url)
    JSON.parse(URI.open(url).read)
end

# The pokemon_url function generates the URL for a specific Pokemon based on its name.
def pokemon_url(name)
    "https://pokeapi.co/api/v2/pokemon/#{name}"
end

# The pokemon_species function generates the URL for a specific Pokemon species
# based on its name.
def pokemon_species(name)
    "https://pokeapi.co/api/v2/pokemon-species/#{name}"
end

# The pokemon_generation function generates the URL for a specific Pokemon
# generation based on its name.
def pokemon_generation(name)
    "https://pokeapi.co/api/v2/generation/#{name}"
end

# The pokemon_type function generates the URL for a specific Pokemon type
# based on its name.
def pokemon_type(name)
    "https://pokeapi.co/api/v2/type/#{name}"
end

# The pokemon_ability function generates the URL for a specific Pokemon ability
# based on its name.
def pokemon_ability(name)
    "https://pokeapi.co/api/v2/ability/#{name}"
end

# Fetches the list of Pokemon and stores it in the pokemon_list variable.
pokemon_list = fetch("https://pokeapi.co/api/v2/pokemon?limit=300")

# Fetches the list of Pokemon types and stores it in the types_list variable.
types_list = fetch("https://pokeapi.co/api/v2/type?limit=50")

# Fetches the list of Pokemon abilities and stores it in the pokemon_abilities variable.
pokemon_abilities = fetch("https://pokeapi.co/api/v2/ability?limit=300")

# Loops through the list of types and creates a new Type object for each one.
types_list['results'].each do |type|
    new_type = Type.new
    type_recovered = fetch(pokemon_type(type['name']))
    pokemon_generation = fetch(pokemon_generation(type_recovered['generation']['name']))

    new_type.name = type_recovered['name']
    new_type.save
end

# Loops through the list of Pokemon and creates a new Pokemon object for each one.
pokemon_list['results'].each do |pokemon|
    new_pokemon = Pokemon.new
    pokemon_recovered = fetch(pokemon_url(pokemon['name']))
    pokemon_species = fetch(pokemon_species(pokemon['name']))
    pokemon_generation = fetch(pokemon_generation(pokemon_species['generation']['name']))
    pokemon_types = pokemon_recovered['types']

    new_pokemon.name = pokemon_recovered['name']
    new_pokemon.height = pokemon_recovered['height']
    new_pokemon.weight = pokemon_recovered['weight']
    new_pokemon.color = pokemon_species['color']['name']
    if pokemon_species['evolves_from_species']
        new_pokemon.evolves_from = pokemon_species['evolves_from_species']['name']
    end
    new_pokemon.generation = pokemon_generation['main_region']['name']
    new_pokemon.url = pokemon_recovered['sprites']['front_default']
    new_pokemon.save

    # Loops through the list of types for each Pokemon and associates them with the Pokemon.
    pokemon_types.each do |pokemon_type|
        poke_type = Type.find_or_create_by(name: pokemon_type['type']['name'])

        poke = Pokemon.find_or_create_by(name: pokemon_recovered['name'])
        poke_type.pokemons << poke
        poke_type.save
    end

end

# Loops through the list of abilities and creates a new Ability object for each one.
pokemon_abilities['results'].each do |ability|
    new_ability = Ability.new
    ability_recovered = fetch(pokemon_ability(ability['name']))
    ability_text = ability_recovered['flavor_text_entries']
    ability_pokemon = ability_recovered['pokemon']

    new_ability.name = ability_recovered['name']

    ability_text.each do |text|
        if text['language']['name'] == 'en'
            new_ability.description = text['flavor_text']
            break
        end
    end
    new_ability.save

    ability_pokemon.each do |pokemon|
        poke_ability = Ability.find_or_create_by(name: ability_recovered['name'])

        poke = Pokemon.find_or_create_by(name: pokemon['pokemon']['name'])
        poke_ability.pokemons << poke
        poke_ability.save
    end
end
