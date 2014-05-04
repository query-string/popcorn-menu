require 'open-uri'
class Popcorn


  def initialize(options={})

    @options = options
    @engines = Dir["#{Rails.root}/config/popcorn_engines/*.yml"].inject({}){|configs, file| configs.merge YAML.load_file(file)}
    @engines.each do |engine|
      define_singleton_method("get_#{engine[0]}") do
        Popcorn::Parser.new(engine: engine[1], output_name: @options[:output_name]).parse
      end
    end

  end

  def get_all(group = false)
    @elements = @engines.inject([]) {|movies, engine| movies.concat Popcorn::Parser.new(engine: engine[1], output_name: @options[:output_name]).parse}
    group == true ? group_by_name : @elements
  end

private

  def group_by_name
    @elements.group_by(&:international_name).inject([]) do |movies, (name, group)|
      movie = group.first
      movie.links = group.inject({}){|links, movie| links[movie.engine] = movie.link; links}
      movie.covers = group.map(&:cover)
      movies.push movie
    end
  end


  class Parser

    def initialize(options={})
      @available_attributes = %w(engine name international_name link cover)
      @engine = options[:engine].to_hashugar
      @output_name = options[:output_name]
      @page = Nokogiri::HTML(open(@engine.parsing.page, {"User-Agent" => "Googlebot/2.1"}), nil, @engine.parsing.encoding)
    end

    def parse
      @page.css(@engine.parsing.elements).inject([]) {|movies, link| movies << self.set_attributes(link)}
    end

    def set_attributes(link)
      @available_attributes.inject({}){|hash, attribute| hash[attribute] = send("parse_#{attribute}", link); hash}.to_hashugar
    end

  private

    def parse_engine(link)
      @engine.domain.split('.').first
    end

    def parse_name(link)
      name = @output_name.nil? ? 'name' : @output_name
      string = link.instance_eval(@engine.parsing.rules[name])
      string.empty? ? link.instance_eval(@engine.parsing.rules.name) : string
    end

    def parse_international_name(link)
      string = link.instance_eval(@engine.parsing.rules.international_name)
      string.empty? ? parse_name(link) : string
    end

    def parse_link(link)
      @engine.link_types == 'absolute' ? link.instance_eval(@engine.parsing.rules.link) : "http://#{@engine.domain}#{link.instance_eval(@engine.parsing.rules.link)}"
    end

    def parse_cover(link)
      link.instance_eval(@engine.parsing.rules.cover)
    end

  end


end