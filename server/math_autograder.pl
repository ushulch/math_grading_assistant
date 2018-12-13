%% -*-prolog-*-
%%
:- module(math_autograder, [server/1]).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_session)).



:- http_handler(root('math_autograder/solutions'), autograder_handler, []).



http_set_session_options([timeout(0)]).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

autograder_handler(_Request) :-
    SampleAttemptedSolution = attempted_solution{student_work:[
						     ['x', '+', '3', '=', '5'],
						     ['x', '=', '5', '-', '3'],
						     ['x', '=', '2']
                                                 ],
						 grader_results: [
                                                     ["Correct"],
                                                     ["Correct"],
                                                     ["Correct"]
                                                 ]},
    reply_json_dict(SampleAttemptedSolution, [tag(attempted_solution)]).
