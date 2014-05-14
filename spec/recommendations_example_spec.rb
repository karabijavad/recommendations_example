require 'spec_helper.rb'

`rm -rf "#{ENV['RACK_ENV']}_graph.db/"`

describe "RecommendationsExample" do
  it "should create or update a nodes attrs on POST" do

    post '/person/10', {name: "Javad", age: 25}

    Cadet::Session.open "#{ENV['RACK_ENV']}_graph.db/" do
      transaction do
        Person_by_id(10).data.should == {
          name: "Javad",
          age:  25,
          id:   10
        }
      end
    end
  end

  it "should create or update a nodes attrs on POST" do

    post '/interest/110', {name: "Pizza"}

    Cadet::Session.open "#{ENV['RACK_ENV']}_graph.db/" do
      transaction do
        Interest_by_id(110).data.should == {
          name: "Pizza",
          id:   110
        }
      end
    end
  end

  it "should create or update a nodes attrs on POST" do

    post '/person/10',    {name: "Javad", age: 25}
    post '/person/11',    {name: "Ellen", age: 25}
    post '/interest/110', {name: "Pizza"}
    post '/create_interest/', {person_id: 10, interest_id: 110}
    post '/create_interest/', {person_id: 11, interest_id: 110}

    Cadet::Session.open "#{ENV['RACK_ENV']}_graph.db/" do
      transaction do
        Person_by_id(10).outgoing(:likes).incoming(:likes).to_a.should == [Person_by_id(11), Person_by_id(10)]
      end
    end
  end


end
