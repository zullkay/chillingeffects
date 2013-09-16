require 'validates_automatically'

class InfringingUrl < ActiveRecord::Base
  include ValidatesAutomatically

  self.primary_key = :id

  before_validation do
    url.match(/[hHfFtTpPsS]{3,5}:\/\/(?:w+\d*?\.)?(.)/)
    routing_key = $1.downcase
    if routing_key.match(/[^a-z\d]/)
      routing_key = 'etc'
    end
    self.routing_key = routing_key
  end

  validates_format_of :url, with: /^([a-z]{3,5}:)?\/\/.+/i
end
