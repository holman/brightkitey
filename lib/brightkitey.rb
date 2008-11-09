require 'rubygems'
require 'activeresource'

module Brightkitey
  VERSION = '0.0.1'

  class << self
    def authenticate(user, password)
      Brightkitey::Base.user = user
      Brightkitey::Base.password = password
    end
  end
  
  class Base < ActiveResource::Base
    def self.inherited(base)
      base.site = "http://brightkite.com/"
      base.element_name = base.to_s.split('::').last.downcase
      super
    end
  end
  
  class Checkin < Base
  end
  
  class Friend < Base
  end
  
  class Comment < Base
  end
  
  class Note < Base
  end
  
  class Objekt < Base
  end
  
  class Person < Base
    def checkins
      Checkin.find(:all, :from => "/people/#{login}/objects.xml", :params => {:filters => :checkins})
    end
    
    def checkins
      Note.find(:all, :from => "/people/#{login}/objects.xml", :params => {:filters => :notes})
    end
    
    def photos
      Photo.find(:all, :from => "/people/#{login}/objects.xml", :params => {:filters => :photos})
    end
    
    def objects(options = {})
      Objekt.find(:all, :from => "/people/#{login}/search.xml", :params => options)
    end
    
    def friends
      Friend.find(:all, :from => "/people/#{login}/friends.xml")
    end
  end
  
  class Photo < Base
    self.element_name = 'object'
    
    def comments
      Comment.find(:all, :from => "/objects/#{id}/comments")
    end
  end
  
  class Place < Base
    def checkins
      Checkin.find(:all, :params => options.update(:project_id => id))
    end
  end

end