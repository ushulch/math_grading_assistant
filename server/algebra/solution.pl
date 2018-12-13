%% -*-prolog-*-
%%
:- module(solution, [solution/5]).

%% Helper function for solution/7, this is what should be called from external code.
solution(Problem, MinNumSteps, MaxNumSteps, PossibleSolutions, ResultsOut) :-
    InitialResults = results{step_count: 0, error_count:0, messages:[]},
    solution(Problem, MinNumSteps, MaxNumSteps, Problem, PossibleSolutions, InitialResults, ResultsOut).

%%
%% Attempts to verify that a possible solution, is, in fact, a possile solution.
%%
%% Problem is the original problem, tokenized as a list, and of the same form of one of the inner lists of
%% PossileSolution.
%%
%% MinNumSteps is the minimum number of steps required for the answer to be acceptable.
%%
%% MaxNumSteps is the maximum number of steps required for the answer to be acceptable
%%
%%
%% CurrentStep, the number of steps we've been through.
%%
%% PreviousPossibleSolutionLine is the previous line of the possible solution, for the first call, it should be
%% the sam as Problem, and has the same form as an inner list for PossibleSolutions.
%%
%% PossibleSolution is a list of lists of tokens for algebraic primitives (1, 2, 3, x, y, z, +, -, =, etc....).
%% It is of the form:
%%         [
%%          ['1', '+', 'x', '=', '2'],
%%          ['x', '=', '2', '-', '1'],
%%          ['x', '=', '1']
%%         ]
%%
%% ResultsIn/ResultsOut is a pair of accumulator variables used to track results.   They are a dict of the form
%%    results{step_count:0, error_count:0, messages:[]}
%%
%%       
%%
%%
solution(_Problem, _MinNumSteps, MaxNumSteps, _PreviousPossibleSolutionLine, _PossibleSolutions, _ResultsIn, ResultsOut) :-
    results{step_count:StepCount, error_count:ErrorCount, messages:Messages},
    StepCount > MaxNumSteps,
    NewMessages = [ ["Max Steps Exceeded"] | Messages ],
    NewErrorCount is ErrorCount + 1,
    NewStepCount is StepCount + 1,
    ResultsOut = results{step_count:NewStepCount, error_count:NewErrorCount, messages:NewMessages}.
	      

solution(Problem,
	 MinNumSteps,
	 MaxNumSteps,
	 CurrentStep,
	 PreviousPossibleSolutionLine,
	 [PossibleSolutionLine | PossibleSolutions],
	 ResultsIn,
	 ResultsOut) :-
    
true.
