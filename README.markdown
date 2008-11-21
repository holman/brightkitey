## brightkitey

by [Zach Holman](http://zachholman.com) ([brightkite](http://brightkite.com/people/holman))

brightkitey is a cute little wrapper around Brightkite's API. It's possibly horribly broken and incomplete, but it's getting there. Pull requests welcome and appreciated.

## installation and usage

    gem sources -a http://gems.github.com
    sudo gem install holman-brightkitey

To get a feel for what you're in for, check out the [Brightkite REST API](http://groups.google.com/group/brightkite-api/web/rest-api). The [object reference](http://groups.google.com/group/brightkite-api/web/api-object-reference) might be helpful, too. Some fun things you can do:

### authentication
    require 'rubygems'
    require 'brightkitey'
    
    Brightkitey.authenticate(:user => 'dr_strangelove', :password => 'cant-allow-gaps')
    Brightkitey.logged_in? # quick login check
    
### brightkitein' around
    
    me = Brightkitey.me
    me.friends.first.checkins # => grab a friend's checkins
    
    home = me.checkins.first.place
    me.checkin(home) # => check yourself in at home
    
    Brightkitey::Place.search("arby's") # => mmmm... I'm thinking Arby's. If you're logged in, this'll pull in those closest to you first.

## thanks

The official [Lighthouse](http://github.com/Caged/lighthouse-api) wrapper was fairly helpful for a newbie like me to wrap my head around. Thankee, Justin.

## license

(The MIT License)

Copyright (c) 2008 Zach Holman

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
