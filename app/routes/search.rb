require_relative '../lib/parser'


class App < Sinatra::Application
  
  get '/status' do
    content_type :json
    {status:'OK'}.to_json
  end

  get '/search/:name' do |name|
    @search_string = name
    @results = Parser.search_by_name name

    @results.each do |r|
      insert(r)
      r[:id] = Entry.last["_id"].to_s

      p r[:id]
    end unless @results.nil?

    if params[:json] == 'yes'
      content_type :json
      @results.to_json
    else
      erb :results
    end
  end

   get '/entry/:id' do |id|
     @a_entry = Entry.find(id)


     links = Parser.parse_entry(@a_entry)

     @a_entry.set(links: links)

     if params[:json] == 'yes'
       content_type :json
       @a_entry.to_json
     else
       if @a_entry[:type] == 'pelicula'
         erb :movie
       else
         erb :show
       end
     end



   end

  get '/all/*' do
    content_type :json
    Entry.all[1..-1].to_json
  end

  private

  def insert(entry)

    Entry.create(
             name: entry[:name],
             url: entry[:url],
             type: entry[:type]
    )
  end





end # class App < Sinatra::Application
