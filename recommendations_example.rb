require 'sinatra'
require 'cadet'
require 'active_support'
require 'active_support/core_ext'

class RecommendationsExample < Sinatra::Base

  post '/person/:id' do
    g = Cadet::Session.open "#{ENV['RACK_ENV']}_graph.db/"
    g.transaction do
      person = g.Person_by_id(params["id"].to_i)
      person.data = {
        name: params['name'],
        age:  params['age'].to_i,
        id:   params['id'].to_i
      }
    end
    g.close
  end

  post '/interest/:id' do
    g = Cadet::Session.open "#{ENV['RACK_ENV']}_graph.db/"
    g.transaction do
      interest = g.Interest_by_id(params["id"].to_i)
      interest.data = {
        name: params['name'],
        id:   params['id'].to_i
      }
    end
    g.close
  end

  post '/create_interest/' do
    g = Cadet::Session.open "#{ENV['RACK_ENV']}_graph.db/"
    g.transaction do
      interest = g.Interest_by_id(params["interest_id"].to_i)
      person   = g.Person_by_id(params["person_id"].to_i)
      person.outgoing(:likes) << interest
    end
    g.close
  end


end
