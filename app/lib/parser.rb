require 'nokogiri'
require 'open-uri'


class String
  def clean
    self.gsub(' ','+').downcase
  end
end

class Parser
  class << self
    URL = 'http://www.divxtotal1.org'

    def search_by_name( name )
      busq = URL + '/?s=' + name.clean

      encontrados = []
      doc = Nokogiri::HTML(open(busq))

      tbody = doc.css('table.table tbody')[0]
      entries = tbody.css('tr').to_a

      entries.each do |entry|
        found = {}

        #sleep(1.0 + rand)

        info = entry.css('td.text-left')[0].css('a')
        found[:name] = info.text.capitalize
        found[:url] = info[0]['href']

        if found[:url].include? 'serie'
          found[:type] = 'serie'
        elsif found[:url].include? 'pelicula'
          found[:type] = 'pelicula'
        else
          found[:type] = 'otro'
        end

        encontrados << found
      end
    encontrados
    end

    def parse_entry(entry)
      # entry = {:name, :url}

      if entry[:url].include? 'pelicula'
        parse_movie(entry)
      elsif entry[:url].include? 'serie'
        parse_tv_show(entry)
      end
    end


    def parse_movie( movie )
      raise 'No es una película' unless movie[:url].include? 'pelicula'

      link = {}

      doc = Nokogiri::HTML(open(movie[:url]))
      link_torrent = doc.css('a.linktorrent').to_a
      url = link_torrent[0]['href'].gsub('(','%28').gsub(')','%29')

      link[:name] = movie[:name]
      link[:url] = url

      return [link]
      # En models solo cuento con entry. Deberia crear modelos para serie y pelicula

    end

    def parse_tv_show( show )
      # show = {:name, :url, :type}
      raise 'No es una serie' unless show[:url].include? 'serie'

      links = []

      doc = Nokogiri::HTML(open(show[:url]))
      trs = doc.css('tbody tr').to_a

      trs.each do |tr|
        link = {}
        td = tr.css('a')[0]
        link[:name] = td.text
        link[:url] = td['href'].gsub('(','%28').gsub(')','%29')
        links << link
      end

      return links.reverse
      # => capitulos = [ {:name, :url} ... ]
    end

  end

end