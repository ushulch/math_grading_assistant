%% -*-prolog-*-
%%
%%
:- use_module(library(http/json)).

encode(Term) :-
    json_write_dict(current_output, Term, [tag(type)]).


decode(String) :-
    new_memory_file(MemoryFile),
    open_memory_file(MemoryFile, write, WriteStringStream),
    format(WriteStringStream, String, []),
    close(WriteStringStream),
    open_memory_file(MemoryFile, read, ReadStringStream, [free_on_close(true)]),

    json_read_dict(ReadStringStream, DecodedDict, [tag(type)]),
    format("~w~n", [DecodedDict]),

    close(ReadStringStream).



encode_card() :-
    Card = card( question('1+1'), answer('2'), recent_answer_history([correct, correct, correct]) ),
    encode_card(Card).


encode_card(card( question(Question), answer(Answer), recent_answer_history(History) )) :-
    encode(card{question:Question, answer:Answer, recent_answer_history:History}).
