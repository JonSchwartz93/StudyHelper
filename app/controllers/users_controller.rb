get '/users/new' do
	erb :'users/new'
end

post '/users' do
	@user = User.new(params[:user])
	if @user.save
		session[:user_id] = @user.id
		redirect "/users/#{@user.id}"
	else
		@errors = @user.errors.full_messages
		erb :'users/new'
	end
end

get '/users/:id' do
	redirect '/decks' unless session[:user_id] && session[:user_id] == params[:id].to_i 
	@user = User.find_by(id: params[:id])
	#require_user
	erb :'users/show'
end

