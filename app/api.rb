require 'bundler/setup'
require 'sinatra/base'
require 'json'

Data = JSON.parse(File.read('data.json'))

class Api < Sinatra::Base

  not_found do
    'page not found.'
  end

	get '/hello' do
		'Hello world!'
	end

  Data.keys.each do |resource_name|

    get "/#{resource_name}" do
      resources = Data[resource_name]
      JSON.pretty_generate(resources)
    end

    get "/#{resource_name}/:id" do |id|
      resource = find_resource(resource_name, id)
      if !resource
        'Not Found'
      else
        expanded_resource = expand_resource(resource)
        JSON.pretty_generate(expanded_resource)
      end
    end
  end

  def expand_resource(resource)
    result = {}
    resource.each do |name, value|
      if name.end_with?('_id')
        nested_resource_name = name[0..-4]
        result[nested_resource_name] = find_resource(nested_resource_name + "s", value)
      else
        result[name] = value
      end
    end
    result
  end

  def find_resource(resource_name, id)
    Data[resource_name].find { |resource| resource['id'] == id.to_i }
  end
end
