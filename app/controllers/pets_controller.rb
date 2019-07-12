class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
  #  puts params
    @pet = Pet.new
    @pet.name = params[:pet_name]
    if params.has_key?("owner_id")
      @pet.owner=Owner.find(params[:owner_id].to_i)
    end
    if !params[:owner_name].empty?
      @pet.owner = Owner.create(name: params["owner_name"])
    end
    @pet.save
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    # @owners = Owner.all

    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])


    if params.has_key?("owner_id")

      @pet.owner=Owner.find(params[:owner_id].to_i)
    #  binding.pry
  end
    if  params["owner"]["name"] != ""
      @pet.owner = Owner.create(name: params["owner"]["name"])

    end
  
    @pet.save

    redirect to "pets/#{@pet.id}"
  end
end
