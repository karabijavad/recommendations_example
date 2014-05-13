require 'sinatra'
require 'cadet'
require 'active_support'
require 'active_support/core_ext'

class RecommendationsExample < Sinatra::Base

  post '/person/' do
    g = Cadet::Session.open "#{ENV['RACK_ENV']}_graph.db/"
    g.transaction do
      person = g.Person_by_name(params["name"])
      person.data = {
        age: params["age"].to_i
      }
    end
    g.close
  end

end
