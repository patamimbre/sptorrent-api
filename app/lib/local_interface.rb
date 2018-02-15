require 'open-uri'
require_relative './parser'

class String
  def clean
    self.gsub(/[\s-]/,'+')
  end

  def clean!
    self.gsub!(/[\s-]/,'+')
  end
end


class LocalInterface
  attr_accessor :download_dir

  def initialize(dir)
    @download_dir = dir
    # ask the name and return found entries
    search
  end

  def search
    begin
      @entries = Parser.search_by_name(ask_name.clean)
      selectEntry
    rescue NoMethodError=>e
      puts "No hay coincidencias"
    end
  end

  def ask_name
    print "Busqueda => "
    name = gets.chomp

    while name.empty?
      print "Busqueda => "
      name = gets.chomp
    end

    return name
  end

  def selectEntry
    # print found entries
    @entries.each_with_index do |entry, i|
      p "[#{i}] #{entry[:name]}"
    end

    print "Selecciona una entrada [0] => "
    s = gets.chomp

    begin
      index = Integer(s)
    rescue ArgumentError=>e
      puts "La entrada debe ser un número"
    end

    if index >= @entries.length
      raise 'El índice es incorrecto'
    end

    @entry = @entries.fetch(index)

    # find links in the selected entry
    find_links
  end

  def find_links
    system 'clear'
    puts " == " << @entry.fetch(:name) << " == "

    @links = Parser.parse_entry(@entry)

    @links.each_with_index do |link,i|
      p "[#{i}] #{link[:name]}"
    end

    print "Selecciona una entrada [0], [2-3], all => "
    s = gets.chomp

    @selected = case s
               when /^\d+$/
                 [@links.fetch(Integer(s))]
               when /^\d+-\d+$/
                 vals = s.split('-').map{|x| Integer(x)}
                 @links[vals[0]..vals[1]]
               when 'all'
                 @links
               else
                 raise 'indice incorrecto'
               end

    raise 'El índice es incorrecto' if @selected.nil?

    download_links
  end

  def download_links

   @selected.each do |elem|
     name = elem[:name].gsub(/\s/, '-')
     url = elem[:url]
     `wget #{url} -o #{@download_dir}/#{name}.torrent`
     puts "Descargado " << name
   end

  end






end

dir =  "~/Descargas"
#dir = "/mnt/dietpi_userdata/torrents"

LocalInterface.new(dir)
