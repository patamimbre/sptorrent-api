require 'nokogiri'
require 'open-uri'

class String
  def clean
    self.gsub(' ','+').downcase
  end

  def extract_se
    info = {}

    begin
      info[:episode] = self.split('x')[-1]
      resto = self.split('x')[-2]
      if resto[-2].is_a? Numeric
        info[:season] = resto [-2..0]
      else
        info[:season] = resto [-1]
      end

    rescue
      info[:episode] = 0
      info[:season] = 0
    end
    info
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

        type = found[:url].split('/')[3]

        if type.include? 'pelicula'
          found[:type] = 'pelicula'
        elsif type.include? 'serie'
          found[:type] = 'serie'
        else
          found[:type] = 'other'
        end


        encontrados << found
      end
    encontrados
    end

    def search_movie( movie )
      # movie = {:name, :url, :type}
      raise 'No es una película' unless movie[:type].include? 'pelicula'

      doc = Nokogiri::HTML(open(movie[:url]))
      link_torrent = doc.css('a.linktorrent').to_a

      link_torrent.map {|x| x['href'].gsub('(','%28').gsub(')','%29')}

    end

    def search_tv_show( show )
      # show = {:name, :url, :type}
      raise 'No es una serie' unless show[:type].include? 'serie'

      capitulos = []

      doc = Nokogiri::HTML(open(show[:url]))
      trs = doc.css('div.col-lg-12 tbody tr').to_a
      trs.each do |tr|
        a = tr.css('a')[0]
        capitulo = a.text.extract_se
        capitulo[:url] = a['href'].gsub('(','%28').gsub(')','%29')
        capitulos << capitulo
      end

      capitulos.reverse
      # => capitulos = [ {:episode, :season, :url} ... ]
    end

  end

end