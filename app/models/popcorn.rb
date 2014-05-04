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

  def get_all
    @elements = @engines.inject([]) {|movies, engine| movies.concat Popcorn::Parser.new(engine: engine[1], output_name: @options[:output_name]).parse}
    @options[:group_by_name] == true ? group_by_name : @elements
  end

private

  def group_by_name
    @elements.group_by(&:international_name).inject([]) do |movies, (name, group)|
      movie = group.first
      movie.links = group.map(&:href)
      movie.images = group.map(&:src)
      movies.push movie
    end
  end


  class Parser

    def initialize(options={})
      @available_attributes = %w(name international_name href src)
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

    def parse_name(link)
      name = @output_name.nil? ? 'name' : @output_name
      string = link.instance_eval(@engine.parsing.rules[name])
      string.empty? ? link.instance_eval(@engine.parsing.rules.name) : string
    end

    def parse_international_name(link)
      string = link.instance_eval(@engine.parsing.rules.international_name)
      string.empty? ? parse_name(link) : string
    end

    def parse_href(link)
      @engine.link_types == 'absolute' ? link.instance_eval(@engine.parsing.rules.href) : "http://#{@engine.domain}#{link.instance_eval(@engine.parsing.rules.href)}"
    end

    def parse_src(link)
      link.instance_eval(@engine.parsing.rules.src)
    end

  end


end