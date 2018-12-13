%% -*-prolog-*-
%%
:- module(prolog_webservice, [server/1]).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_session)).

:- use_module(card_selector/card_selector).


:- http_handler(root('select_card'), select_card_handler, []).

http_set_session_options([timeout(0)]).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

select_card_handler(_Request) :-
    card_selector:select_card(SelectedCard),
    reply_json_dict(SelectedCard, [tag(card)]).
