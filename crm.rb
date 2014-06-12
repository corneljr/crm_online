require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource
	
	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

#routes

get '/' do
	redirect to('/contacts/new')
end

get "/contacts" do
	@contacts = Contact.all
  erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
	new_contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note]
	)
	redirect to('/')
end

get '/contacts/modify' do
	@contacts = Contact.all
	erb :select_for_modify
end

get '/contacts/delete' do
	@contacts = Contact.all
	erb :select_for_delete
end

get '/contacts/:id/delete' do
	@contact = Contact.get(params[:id].to_i)
	@contact.destroy
	redirect to('/contacts')
end

get '/contacts/:id/edit' do
	@contact = Contact.get(params[:id].to_i)
	erb :edit_contact
end

post '/contacts/:id' do
	@contact = Contact.get(params[:id].to_i)
	@contact.update(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note]
	)
	redirect to('/contacts')
end








