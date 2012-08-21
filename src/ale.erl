-module(ale).
-export([parse_transform/2]).


parse_transform(Forms, _Options) ->
    io:format(user, "Before:\t~p\n\n", [Forms]),
%   io:format(user, "Before:\t~p\n\nAfter:\t~p\n", [Forms, X]),
    Forms.
