%% -*-prolog-*-
%%
:- module(card_selector, [select_card/1, select_card/2, all_seen_cards_mastered/1]).
:- use_module(unseen_cards).
:- use_module(unmastered_cards).







select_card(SelectedCard) :-
    CardList =
    [
        card{ question:'1+1', answer:'2', recent_answer_history:[correct, correct, correct] },
        card{ question:'1+2', answer:'3', recent_answer_history:[] },
        card{ question:'1+3', answer:'4', recent_answer_history:[correct, correct, correct] }
    ],
    select_card(CardList, SelectedCard).



select_card(CardList, SelectedCard) :-
    (
        select_unseen_card(CardList, SelectedCard);
        select_unmastered_card(CardList, SelectedCard)
    ),
    !.



%%
%% Rules to select the first card of a specific type
%%
select_unseen_card(CardList, SelectedCard) :-
    should_select_unseen_card(CardList),
    unseen_cards:first_unseen_card(CardList, SelectedCard).

select_unmastered_card(CardList, SelectedCard) :-
    should_not_select_unseen_card(CardList),
    unmastered_cards:first_unmastered_card(CardList, SelectedCard).



%%
%% Rules to determine if an unseen card should be presented at this time
%%
should_select_unseen_card(CardList) :-
    unseen_cards:all_cards_unseen(CardList);
    unmastered_cards:all_seen_cards_mastered(CardList).

should_not_select_unseen_card(CardList) :- \+ should_select_unseen_card(CardList).
