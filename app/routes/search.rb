
class App < Sinatra::Application

  # Show environment info
   get '/env' do
     if params[:json] == 'yes'
       content_type :json
       ENV.to_h.to_json
     else
       'Environment (as <a href="/env?json=yes">JSON</a>):<ul>' +
         ENV.each.map { |k, v| "<li><b>#{k}:</b> #{v}</li>" }.join + '</ul>'
     end
   end

  get '/status' do
    content_type :json
    {status:'OK'}.to_json
  end

  get '/search/*' do
    erb :search
  end



end # class App < Sinatra::Application
