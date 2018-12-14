%% -*-prolog-*-
%%
:- module(solution, [solution/5, solution/7]).
:- use_module(algebra_rules).


%% Helper function for solution 7, this is what should be called from external code.
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
%% PreviousStudentWorkLine is the previous line of the possible solution, for the first call, it should be
%% the sam as Problem, and has the same form as an inner list for StudentWork.
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

%%
%% Identify total steps above maximum number of steps
%%
solution(_Problem, _MinNumSteps, MaxNumSteps, _PreviousStudentWorkLine, _StudentWork, ResultsIn, ResultsOut) :-
    results{step_count:StepCount, error_count:ErrorCount, messages:Messages} = ResultsIn,
    StepCount > MaxNumSteps,
    append(Messages, ["Too Many Steps"], NewMessages),
    NewErrorCount is ErrorCount + 1,
    NewStepCount is StepCount + 1,
    ResultsOut = results{step_count:NewStepCount, error_count:NewErrorCount, messages:NewMessages}.


%%
%% Identify total steps below minimum number of steps
%%
solution(_Problem, MinNumSteps, _MaxNumSteps, _PreviousStudentWorkLine, StudentWork, ResultsIn, ResultsOut) :-
    StudentWork = [],
    results{step_count:StepCount, error_count:ErrorCount, messages:Messages} = ResultsIn,
    StepCount < MinNumSteps,
    append(Messages, ["Too Few Steps"], NewMessages),
    NewErrorCount is ErrorCount + 1,
    NewStepCount is StepCount + 1,
    ResultsOut = results{step_count:NewStepCount, error_count:NewErrorCount, messages:NewMessages}.

%%
%% Identify end of student work, Check to see if it's simplified, and set results out to results in
%%
solution(_Problem, _MinNumSteps, _MaxNumSteps, _PreviousStudentWorkLine, [], ResultsIn, ResultsOut) :-
    %Should check for simplified solution
    ResultsOut = ResultsIn.


%%
%% Identify when the student has just re-stated the problem.
%%
solution(Problem, MinNumSteps, MaxNumSteps, _PreviousStudentWorkLine, [StudentWorkLine | RemainingStudentWork], ResultsIn, ResultsOut) :-
    results{step_count:StepCount, error_count:ErrorCount, messages:Messages} = ResultsIn,

    algebra_rules:problem_restatement(Problem, StudentWorkLine),

    append(Messages, ["Problem Restatement"], NewMessages),
    NewErrorCount = ErrorCount,
    NewStepCount is StepCount + 1,
    Results = results{step_count:NewStepCount, error_count:NewErrorCount, messages:NewMessages},
    solution(Problem, MinNumSteps, MaxNumSteps, StudentWorkLine, RemainingStudentWork, Results, ResultsOut).

solution(Problem,
	 MinNumSteps,
	 MaxNumSteps,
	 _PreviousStudentWorkLine,
	 [StudentWorkLine | RemainingStudentWork],
	 ResultsIn,
	 ResultsOut) :-

    results{step_count:StepCount, error_count:ErrorCount, messages:Messages} = ResultsIn,

    append(Messages, ["Unrecognized Transform or Computation"], NewMessages),
    NewErrorCount = ErrorCount,
    NewStepCount is StepCount + 1,
    Results = results{step_count:NewStepCount, error_count:NewErrorCount, messages:NewMessages},
    solution(Problem, MinNumSteps, MaxNumSteps, StudentWorkLine, RemainingStudentWork, Results, ResultsOut).
