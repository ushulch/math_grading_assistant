%% -*-prolog-*-
%%
%%
:- module(unseen_cards, [
              unseen_card/1,
              seen_card/1,
              all_cards_unseen/1,
              first_unseen_card/2
          ]).


%%
%% Rules for determining if cards are seen or unseen
%%
unseen_card( card{question:_, answer:_, recent_answer_history:[]} ).
seen_card(Card) :- \+ unseen_card(Card).


%%
%% Rules to determine if all cards are unseen
%%
all_cards_unseen([]).
all_cards_unseen([FirstCard | RestCards]) :-
    unseen_card(FirstCard),
    all_cards_unseen(RestCards).




%%
%% Rules for selecting the first unseen card
%%
first_unseen_card([], fail) :- fail.

first_unseen_card([FirstCard | _RestCards], FirstCard) :-
    unseen_card(FirstCard),
    !.

first_unseen_card([FirstCard | RestCards], SelectedCard) :-
    seen_card(FirstCard),
    first_unseen_card(RestCards, SelectedCard).
