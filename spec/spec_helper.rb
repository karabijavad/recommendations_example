require 'rack/test'
require 'recommendations_example'

require File.expand_path '../../recommendations_example.rb', __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() RecommendationsExample end
end

# For RSpec 2.x
RSpec.configure { |c| c.include RSpecMixin }
