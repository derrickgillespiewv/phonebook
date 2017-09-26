require "sinatra"
# require_relative "isbn.rb"
require 'pg'
load './local_env.rb' if File.exist?('./local_env.rb')




db_params = {
    host: ENV['host'],
    port: ENV['port'],
    dbname: ENV['db_name'],
    user: ENV['user'],
    password: ENV['password']
}

db = PG::Connection.new(db_params)


get '/' do
erb :enter_phone
end 

get '/enter_phone' do 
	erb :enter_phone
end

post '/enter_phone' do
	first_name = params[:first_name]
	last_name = params[:last_name]
	city = params[:city]
	street = params[:street]
	zip = params[:zip]
	phone = params[:phone]

	username = params[:user_name]
	password = params[:pass_word]

	db.exec("INSERT INTO phonebook(first_name, last_name, city, street, zip_code, phone_number) VALUES('#{first_name}', '#{last_name}', '#{city}', '#{street}', '#{zip}', '#{phone}')");

	db.exec("INSERT INTO login_table(username, password, phone_number) VALUES('#{username}', '#{password}', '#{phone}')");
redirect '/phone_out?first_name=' + first_name.to_s + '&last_name=' + last_name.to_s + '&city=' + city.to_s + '&street=' + street.to_s + '&zip=' + zip.to_s + '&phone=' + phone.to_s  
end 

get '/phone_out' do 
	first_name = params[:first_name]
	last_name = params[:last_name]
	city = params[:city]
	street = params[:street]
	zip = params[:zip]
	phone = params[:phone]
erb :phone_out, :locals => {:first_name=>first_name, :last_name=>last_name, :city=>city, :street=>street, :zip=>zip, :phone=>phone }
	
end

post '/phone_out' do
	redirect '/phone_book?='
end

get '/phone_book' do
	 phonebook = db.exec("Select * From phonebook")
    erb :phone_book, locals: {phonebook: phonebook}
end 

post '/phone_book' do 
	redirect '/phone_book?='
end 

post '/update'


post '/delete' do
    deleted = params[:user_delete]    
    username = params[:user_name]
	password = params[:pass_word]
	correct_user = db.exec("SELECT * FROM login_table WHERE username = '#{username}'")
	correct_password = db.exec("SELECT * FROM login_table WHERE password = '#{password}'")
  	confirm_user = db.exec("SELECT * FROM login_table WHERE username = '#{username}' AND password = '#{password}'");
  	puts confirm_user 

    # login_data = correct_login.values.flatten
    
    # if login_data[0] == checked_username && login_data[1] == checked_password
    # db.exec("DELETE FROM phonebook WHERE phone_number = '#{deleted}'");
    redirect '/phone_book?='
end
username = "Bobman"
# password = "smith"
# confirm_user = db.exec("SELECT * FROM login_table WHERE username = '#{username}' AND password = '#{password}'");
correct_user = db.exec("SELECT * FROM login_table WHERE username = '#{username}'");
correct_user
p correct_user

# get '/' do
# erb :enter_isbn
# end 

# get '/enter_isbn' do
# erb :enter_isbn
# end

# post '/enter_isbn' do
# isbn_data = params[:isbn_data].to_s
# isbn_done = params[:isbn_done].to_s
# isbn_done = isbn_check(isbn_data)
# isbn_done = isbn_text(isbn_done).to_s

# redirect '/isbn_out?isbn_done=' + isbn_done.to_s + '&isbn_data=' + isbn_data.to_s
# end 

# get '/isbn_out' do 
# isbn_data = params[:isbn_data]
# isbn_done = params[:isbn_done]
# push_to_bucket(isbn_data, isbn_done)

# erb :isbn_out, :locals => {:isbn_data=>isbn_data, :isbn_done=>isbn_done}
# end

# post '/isbn_out' do 

# isbn_data = params[:isbn_data]
# isbn_done = params[:isbn_done]
# list_display = params[:list_display]
# list_display = get_file
# redirect '/list_isbn?isbn_done=' + isbn_done.to_s + '&isbn_data=' + isbn_data.to_s + '&list_display=' + list_display.to_s
# end

# get '/list_isbn' do
# isbn_data = params[:isbn_data]
# isbn_done = params[:isbn_done]
# list_display = params[:list_display]
# erb :list_isbn, :locals => {:isbn_data=>isbn_data, :isbn_done=>isbn_done, :list_display=>list_display}
# end 
# # <input type ="number" min = 1 max = 100 value = isbn_data[] autofocus = "autofocus" id ="nameList" oninput = "nameFunction()" >
# #     <p id = "demo"></p>
# #     <br>

    # <form>
    #         <select name = 'new_table_cell'>
    #             <option value=0>First Name</option>
    #             <option value=1>Last Name</option>
    #             <option value=2>City</option>
    #             <option value=3>Street Address</option>
    #             <option value=4>Zip Code</option>
    #             <option value=5>Phone Number</option>
    #         </select>
    #     </form>
