require 'spec_helper.rb'

describe "RecommendationsExample" do
  it "should create or update a nodes attrs on POST" do
    post '/person/', {name: "Javad", age: 25}

    Cadet::Session.open "#{ENV['RACK_ENV']}_graph.db/" do
      transaction do
        Person_by_name("Javad")[:age].should == 25
      end
    end
  end
end
