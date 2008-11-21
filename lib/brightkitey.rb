require 'rubygems'
require 'activeresource'

module Brightkitey
  VERSION = '0.1.0'
  
  attr_accessor :logged_in

  class << self
    def authenticate(options)
      Brightkitey::Base.user = options[:user]
      Brightkitey::Base.password = options[:password]
      Brightkitey::Me.person
      @logged_in = true
    rescue ActiveResource::UnauthorizedAccess
      false
    end
    
    def logged_in?
      @logged_in == true
    end
    
    def me
      Brightkitey::Me.person
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
  
  class Note < Base
  end
  
  class Objekt < Base
    self.element_name = 'object'
  end
  
  class Person < Base
    def checkins
      Checkin.find(:all, :from => "/people/#{login}/objects.xml", :params => {:filters => :checkins})
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
  
  class Friend < Person
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

  class Me < Person
    def self.person
      Me.find(:one, :from => '/me.xml')
    end
 
    def sent_messages
      DirectMessage.find(:all, :from => '/me/sent_messages.xml')
    end
    
    def received_messages
      DirectMessage.find(:all, :from => '/me/received_messages.xml')
    end
    
    def blocks
      Block.find(:all, :from => '/me/blocked_people.xml')
    end
  
    def checkin(place)
      place = place.id if place.kind_of?(Place)
      Brightkitey::Place.connection.post("/places/#{place}/checkins",'')
    rescue ActiveResource::Redirection
      true
    end
  end

end