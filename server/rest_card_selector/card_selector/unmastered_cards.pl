%% -*-prolog-*-
%%
%%
:- module(unmastered_cards, [
              mastered_card/1,
              unmastered_card/1,
              first_unmastered_card/2,
              all_seen_cards_mastered/1
          ]).

:- use_module(unseen_cards).

%%
%% Rules to determine if all seen cards are mastered
%%
all_seen_cards_mastered([]).
all_seen_cards_mastered([FirstCard | RestCards]) :-
    unseen_cards:seen_card(FirstCard),
    mastered_card(FirstCard),
    all_seen_cards_mastered(RestCards).
all_seen_cards_mastered([FirstCard | RestCards]) :-
    unseen_cards:unseen_card(FirstCard),
    all_seen_cards_mastered(RestCards).



%%
%% Rules for selecting the first unmastered card
%%
first_unmastered_card([], fail) :- fail.
first_unmastered_card([FirstCard | RestCards], SelectedCard) :-
    unseen_cards:unseen_card(FirstCard),
    first_unmastered_card(RestCards, SelectedCard).
first_unmastered_card([FirstCard | RestCards], SelectedCard) :-
    mastered_card(FirstCard),
    first_unmastered_card(RestCards, SelectedCard).
first_unmastered_card([FirstCard | _RestCards], FirstCard) :-
    unmastered_card(FirstCard),
    !.


%%
%% Rules for history analysis
%%
most_recent_n_correct(_History, N, CurrentCount) :-
    N = CurrentCount.

most_recent_n_correct([], _, _) :- fail.

most_recent_n_correct([FirstHistory | RestHistory], N, CurrentCount) :-
    FirstHistory = correct,
    NextCount is CurrentCount + 1,
    most_recent_n_correct(RestHistory, N, NextCount).


most_recent_n_correct(History, N) :-
    most_recent_n_correct(History, N, 0).



%%
%% Rules for determining if cards have been mastered or not
%%
mastered_card(Card) :-
    Card = card{question:_, answer:_, recent_answer_history:History},
    N = 3,
    most_recent_n_correct(History, N),
    !.

unmastered_card(Card) :- \+ mastered_card(Card).
