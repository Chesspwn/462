ruleset see_songs {
  meta {
    name "My see songs 2"
    description <<
An seeing song thing 2
>>
    author "Thomas Hutchins"
    logging on
    sharing on
    provides hello
 
  }
  global {
    hello = function(obj) {
      msg = "Hello " + obj
      msg
    };
 
  }
 rule songs is active {
  select when echo message input "(.*)" setting(m) and msg_type = song
  send_directive("sing") with
    song  =  m;
}
}
