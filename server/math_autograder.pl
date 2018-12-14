%% -*-prolog-*-
%%
:- module(math_autograder, [server/1]).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_session)).

:- use_module(algebra/solution).


:- http_handler(root('math_autograder/solutions'), autograder_handler, []).



http_set_session_options([timeout(0)]).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

autograder_handler(Request) :-
    _SampleAttemptedSolution = attempted_solution{problem:['x', '+', '3', '=', '5'],
                                                  min_num_steps: 2,
                                                  max_num_steps: 12,
                                                  student_work:[
						      ['x', '+', '3', '=', '5'],
						      ['x', '=', '5', '-', '3'],
						      ['x', '=', '2']
                                                  ],
						  grader_results: [
                                                      ["Correct"],
                                                      ["Correct"],
                                                      ["Correct"]
                                                  ]},

    http_read_json_dict(Request, AttemptedSolution, [tag(type)]),

    AttemptedSolution = attempted_solution{problem:Problem,
                                           min_num_steps:MinNumSteps,
                                           max_num_steps:MaxNumSteps,
                                           student_work:StudentWork,
                                           grader_results:_},

    solution:solution(Problem, MinNumSteps, MaxNumSteps, StudentWork, Results),

    GradedSolution = attempted_solution{problem:Problem,
                                        min_num_steps:MinNumSteps,
                                        max_num_steps:MaxNumSteps,
                                        student_work:StudentWork,
                                        grader_results:Results},

    reply_json_dict(GradedSolution, [tag(type)]).
