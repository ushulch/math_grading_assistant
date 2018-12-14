%% -*-prolog-*-
%%
%%
:- module(algebra_rules, [
              problem_restatement/2
          ]).

%%
%% Students are allowed to restate the problem whenever they like.
%%
problem_restatement(Problem, StudentWorkLine) :-
    Problem = StudentWorkLine.
