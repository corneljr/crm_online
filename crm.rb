require 'sinatra'
require 'data_mapper'
require_relative 'rolodex'

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

@@rolodex = Rolodex.new

#routes

get '/' do
	redirect to('/contacts/new')
end

get "/contacts" do
  erb :contacts
end

get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
	new_contact = Contact.new(params[:first_name],params[:last_name],params[:email], params[:note])
	@@rolodex.add_contact(new_contact)
	redirect to('/')
end

get '/contacts/modify' do
	erb :select_for_modify
end

get '/contacts/delete' do
	erb :select_for_delete
end

get '/contacts/:id/delete' do
	@contact = @@rolodex.contacts.find { |contact| contact.id == params[:id].to_i }
	@@rolodex.delete_contact(@contact)
	redirect to('/contacts')
end

get '/contacts/:id/edit' do
	@contact = @@rolodex.contacts.find { |contact| contact.id == params[:id].to_i }
	erb :edit_contact
end

post '/contacts/:id' do
	@contact = @@rolodex.contacts.find { |contact| contact.id == params[:id].to_i }
	@contact.first_name = params[:first_name]
	@contact.last_name = params[:last_name]
	@contact.email = params[:email]
	@contact.note = params[:note]
	redirect to('/contacts')
end








