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
  select when echo message input "(.*)" msg_type "song" setting(m) 
  send_directive("sing") with
    song  =  m;
  fired {
  raise explicit event "sung" with
    song  =  m;}
 } 

 rule find_hymn is active {
  select when explicit sung song "(.*)" setting (m)
  send_directive("sing") with
    song  =  m;
  fired {
  raise explicit event "found_hymn"
  if (m eq #"*god*"#i)}
 }
}
