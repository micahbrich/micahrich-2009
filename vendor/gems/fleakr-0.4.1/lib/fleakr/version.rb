module Fleakr
  module Version # :nodoc:
    
    MAJOR = 0
    MINOR = 4
    TINY  = 1
    
    def self.to_s
      [MAJOR, MINOR, TINY].join('.')
    end
    
  end
end