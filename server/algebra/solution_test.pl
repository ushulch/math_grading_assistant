%% -*-prolog-*-
%%
%%
:- module(solution_test, [
              max_test/1,
              min_test/1,
              too_many_restatements/1
          ]).
:- use_module(solution).

max_test(Res) :-
    TestResults = results{step_count: 2, error_count:0, messages:[]},
    solution([], 1, 1, [], [], TestResults, ResultsOut),
    results{step_count: 3, error_count:1, messages:_} = ResultsOut,
    Res = pass.


min_test(Res) :-
    TestResults = results{step_count: 1, error_count:0, messages:[]},
    solution([], 3, 1, [], [], TestResults, ResultsOut),
    results{step_count: 2, error_count:1, messages:_} = ResultsOut,
    Res = pass.

too_many_restatements(Res) :-
    Problem = ['x', '+', '3', '=', '5'],
    TestResults = results{step_count: 1, error_count:0, messages:[]},
    solution(Problem, 1, 10, Problem, [Problem], TestResults, ResultsOut),
    results{step_count: 2, error_count:1, messages:_} = ResultsOut,
    Res = pass.
