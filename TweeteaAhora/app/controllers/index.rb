get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  
  erb :index
end


post '/fetch' do



handle = params[:handle]
p handle

 redirect to '/' + handle

end

post '/tweet' do

  tweet = URI.decode(params[:tweet_text].gsub("+"," "))
  
  # tweet = params[:tweet_text]
  p tweet
  
  if CLIENT.update(tweet)
    session[:message] = "Tu tweet fue actualizado"
    session[:color] = "blue"
    redirect to ('/')
  else
    session[:message] = "Tu tweet no fue actualizado"
    session[:color] = "red"
    redirect to ('/')
  end
  

end


get '/:handle' do

  session[:message].clear

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