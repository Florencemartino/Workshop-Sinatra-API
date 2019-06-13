require 'spec_helper'
require 'rack/test'
require_relative '../app/api'

RSpec.describe Api do
 include Rack::Test::Methods

  def app
    Api.new
  end

  it 'says hello' do
    get '/hello'
    expect(last_response.body).to eq 'Hello world!'
  end

  it 'returns the list of movies' do
    get '/movies'
    expect(last_response.body).to include 'The Gold Rush'
  end

  it 'returns a specific movie' do
    get '/movies/3'
    expect(last_response.body).to include 'The General'
  end

  it 'returns movie not found' do
    get '/movies/50'
    expect(last_response.body).to include 'Not Found'
  end

  it 'returns resource not found' do
    get '/books'
    expect(last_response.body).to include 'page not found.'
  end
  # Your turn to write the next spec!

end
