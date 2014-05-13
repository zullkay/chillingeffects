require 'validates_automatically'

class InfringingUrl < ActiveRecord::Base
  include ValidatesAutomatically

  validates_format_of :url, with: /\A([a-z]{3,5}:)?\/\/.+/i
end
