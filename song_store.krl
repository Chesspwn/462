ruleset song_store {
  meta {
    name "My song_store"
    description <<
A song_store thing
>>
    author "Thomas Hutchins"
    logging on
    sharing on
    provides songs, hymns, secular_music
 
  }
  
  global {
 songs = function() {ent:archive_songs
 };
 hymns = function() {ent:archive_hymns
 };
 secular_music = function() {
 ent:archive_songs.filter(function(k,v){not ent:archive_hymns.keys().has(k)}) 
 };
  }

 rule collect_songs  is active {
  select when explicit sung song "(.*)" setting(m) 
  pre { 
  temp = {m : time:new()};
  songs = ent:archive_songs || {"a" : "a"};
    new_map = songs.put(temp);
  } 
  send_directive("normal") with
   t = temp and
    songs  =  {"a" : "something"};
  always {
    set ent:archive_songs new_map if (not songs.keys().has(m));
  }
 } 

 rule collect_hymns is active {
  select when explicit found_hymn song "(.*)" setting(m) 
  pre { 
  songs = ent:archive_hymns || {"a" : "a"};
    new_array = songs.put(m, time:new());
  } 
  send_directive("hymns") with
    hymns  =  songs || {"a" : "a"};
  always {
    set ent:archive_hymns new_array if (not songs.keys().has(m))
  }
}

 rule clear_songs  is active {
  select when song reset
  send_directive("reset");
  always {
    clear ent:archive_hymns;
    clear ent:archive_songs;
  }
 } 
 
}
