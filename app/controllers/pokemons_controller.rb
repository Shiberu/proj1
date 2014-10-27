class PokemonsController < ApplicationController
	def new
		@pokemon = Pokemon.new
	end

	def create
		@pokemon = Pokemon.new(pokemon_params)
		@pokemon.health = 100
		@pokemon.level = 1
		@pokemon.trainer_id = current_trainer.id
		if @pokemon.save
			redirect_to trainer_path(current_trainer.id)
		else
			flash[:error] = @pokemon.errors.full_messages.to_sentence
			redirect_to new_pokemon_path
		end
		
	end

	def pokemon_params
		params.require(:pokemon).permit(:name, :health, :level, :trainer_id)
	end

	def capture
		curr_pokemon = Pokemon.find(params[:id])
		curr_pokemon.update_attribute(:trainer_id, current_trainer.id)
		curr_pokemon.save
		redirect_to root_path
	end

	def damage
		curr_pokemon = Pokemon.find(params[:id])
		curr_pokemon.update_attribute(:health, curr_pokemon.health-10)
		if curr_pokemon.health < 0
			curr_pokemon.health = 0
		end
		curr_pokemon.save
		redirect_to trainer_path(curr_pokemon.trainer_id)
	end

	def heal
		curr_pokemon = Pokemon.find(params[:id])
		curr_pokemon.update_attribute(:health, curr_pokemon.health+10)
		if curr_pokemon.health > 100
			curr_pokemon.health = 100
		end
		curr_pokemon.save
		redirect_to trainer_path(curr_pokemon.trainer_id)
	end
end
