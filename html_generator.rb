require 'byebug'
require 'yaml'
require 'erb'
require 'fileutils'
class HTMLGenerator

  # Reads all the key value pairs from the yaml files and creates instances variables
  def initialize
    hash = YAML.load_file(Dir.pwd + '/config.yml')
    hash.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  # Using ERB to bind the instance variables to the view
  def generate_html_pages
    template = File.read(Dir.pwd + '/test_template.html.erb')
    result = ERB.new(template).result(binding)
    File.open("output.html", "w+") do |f|
      f.write result
    end
  end
end
