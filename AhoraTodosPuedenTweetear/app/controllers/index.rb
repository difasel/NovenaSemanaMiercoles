get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  
  erb :index
end


post '/fetch' do



handle = params[:handle]
p handle

 redirect to '/twiter' + handle

end

post '/tweet' do

  # tweet = URI.decode(params[:tweet_text].gsub("+"," "))
  
  tweet = params[:tweet_text]
  p tweet
  
  user = Usertw.find_by(user: session[:name])
  if user.cliente.update(tweet)
    session[:message] = "Tu tweet fue actualizado"
    session[:color] = "blue"
    redirect to ('/')
  else
    session[:message] = "Tu tweet no fue actualizado"
    session[:color] = "red"
    redirect to ('/')
  end
  

end


get '/twiter/:handle' do

  # session[:message].clear

  @handle = params[:handle]
  p @handle

  client_count = 0
  database_count = 0
  # Se crea un TwitterUser si no existe en la base de datos de lo contrario trae de la base al usuario. 

  if Usertw.find_by(user: @handle)
    @user = Usertw.find_by(user: @handle)
  else
    @user = Usertw.create(user: @handle)
  end

  if @user.tweets.count == 0 # La base de datos no tiene tweets?  
    CLIENT.user_timeline(@handle).each do |tweets|
      @tweet = Tweet.create(tweet: tweets.text)
      @user.tweets << @tweet
    end
    # Pide a Twitter los últimos tweets del usuario y los guarda en la base de datos
  end

  # p client_count = CLIENT.user_timeline(@handle).count
  # p database_count = @user.tweets.count

  
  p client_first = CLIENT.user_timeline(@handle).first.text
  p db_first = Usertw.all.find_by(user: @handle).tweets.first.tweet

  # if ( client_count != database_count ) || ( client_first != db_first )

  if ( client_first != db_first )

    p "*" * 50
    @user.tweets.each { |tw|  tw.destroy }
    CLIENT.user_timeline(@handle).each do |tweets|
    @tweet = Tweet.create(tweet: tweets.text)
    @user.tweets << @tweet
    end

  end
 
 @user = Usertw.find_by(user: @handle)

  # Se hace una petición por los ultimos 10 tweets a la base de datos. 

  
  erb :twitter, layout: false

end



get '/sign_in' do
  # El método `request_token` es uno de los helpers
  # Esto lleva al usuario a una página de twitter donde sera atentificado con sus credenciales
  redirect request_token.authorize_url(:oauth_callback => "http://#{host_and_port}/auth")
  # Cuando el usuario otorga sus credenciales es redirigido a la callback_url 
  # Dentro de params twitter regresa un 'request_token' llamado 'oauth_verifier'
end

get '/auth' do
  # Volvemos a mandar a twitter el 'request_token' a cambio de un 'acces_token' 
  # Este 'acces_token' lo utilizaremos para futuras comunicaciones.   
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # Despues de utilizar el 'request token' ya podemos borrarlo, porque no vuelve a servir. 
  
  session.delete(:request_token)

  p session[:oauth_token] = @access_token.params[:oauth_token]
  p session[:name] = @access_token.params[:screen_name]
  p session[:oauth_token_secret] = @access_token.params[:oauth_token_secret]
  
  if Usertw.find_by(user: session[:name])
    user_loged = Usertw.find_by(user: session[:name])
    user_loged.update(access_token: session[:oauth_token], access_token_secret: session[:oauth_token_secret])
  else
    user_loged = Usertw.create(user: session[:name], access_token: session[:oauth_token], access_token_secret: session[:oauth_token_secret])

  end
  
  redirect to '/'
  # Aquí es donde deberás crear la cuenta del usuario y guardar usando el 'acces_token' lo siguiente:
  # nombre, oauth_token y oauth_token_secret
  # No olvides crear su sesión 

end

get '/sign_out' do

  session.clear
  redirect to '/'
  # Para el signout no olvides borrar el hash de session

end

  


