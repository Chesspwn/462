ruleset see_songs {
  meta {
    name "My see songs"
    description <<
An seeing song thing
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
  select when echo message input "(.*)" setting(m)
  send_directive("say") with
    something = "You said to say: " + m;
}
}
