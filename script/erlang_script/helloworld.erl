% hello world program
 -module(helloworld).
 -export([greet/2]).

greet(male,Name) ->
    io.format("hello, Mr. ~s!",[Name]);
greet(female,Name) ->
    io.format("hello, Mrs. ~s!",[Name]);
greet(_,Name) ->
    io.format("hello, ~s!",[Name]).
