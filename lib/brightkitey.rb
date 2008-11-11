require 'rubygems'
require 'activeresource'

module Brightkitey
  VERSION = '0.0.1'

  class << self
    def authenticate(options)
      Brightkitey::Base.user = options[:user]
      Brightkitey::Base.password = options[:password]
      Brightkitey::Me.person
    rescue ActiveResource::UnauthorizedAccess
      false
    end
  end
  
  class Base < ActiveResource::Base
    def self.inherited(base)
      base.site = "http://brightkite.com/"
      base.element_name = base.to_s.split('::').last.downcase
      super
    end    
  end
  
  class Block < Base
  end
  
  class Checkin < Base
  end
  
  class Comment < Base
  end
  
  class DirectMessage < Base
  end
  
  class Friend < Base
  end
  
  class Me < Base
    def self.person
      Me.find(:one, :from => '/me.xml')
    end
    
    def self.friends
      Friend.find(:all, :from => '/me/friends.xml')
    end
    
    def self.sent_messages
      DirectMessage.find(:all, :from => '/me/sent_messages.xml')
    end
    
    def self.received_messages
      DirectMessage.find(:all, :from => '/me/received_messages.xml')
    end
    
    def self.blocks
      Block.find(:all, :from => '/me/blocked_people.xml')
    end
  
    def self.checkin(place_id)
      Brightkitey::Place.connection.post("/places/#{place_id}/checkins",'')
    rescue ActiveResource::Redirection
      true
    end
  end
  
  class Note < Base
  end
  
  class Objekt < Base
    self.element_name = 'object'
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
    
    def pending_friends
      Friend.find(:all, :from => "/people/#{login}/pending_friends.xml")      
    end
    
    def self.search(query)
      Person.find(:all, :from => "/people/search.xml", :params => {:query => query})
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
    
    def self.search(query)
      Place.find(:all, :from => :search, :params => {:q => query})
    end
  end

end