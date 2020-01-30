% Prolog Programming

% is_even(Number) - succeeds if the number is even
is_even(Number) :-
    Number mod 2 =:= 0.

% sumsq_even(Numbers, Sum) - sums the squares of only the even numbers in a list of integers
sumsq_even([], 0).
sumsq_even([Number|Rest], Sum) :-
    is_even(Number),
    sumsq_even(Rest, SumOfRest),
    Sum is Number * Number + SumOfRest.
sumsq_even([Number|Rest], Sum) :-
    not(is_even(Number)),
    sumsq_even(Rest,SumOfRest),
    Sum is SumOfRest.


% same_name(Person1, Person2) - succeeds if it can be deduced from the facts in the database that Person1 and Person2 will have the same family name
same_name(Person1, Person2) :-
    parent(Parent1, Person1),
    male(Parent1),
    parent(Parent2, Person2),
    male(Parent2),
    same_name(Parent1, Parent2).
same_name(Person1, Person2) :-
    parent(Parent1, Person1),
    male(Parent1),
    same_name(Parent1, Person2).
same_name(Person1, Person2) :-
    parent(Parent2, Person2),
    male(Parent2),
    same_name(Person1, Parent2).
same_name(Person1, Person2) :-
    Person1 = Person2.


% log_table(NumberList,ResultList) - binds ResultList to the list of pairs consisting of a number and its log, for each number in NumberList
log_table([],[]).
log_table(NumberList,ResultList) :-
    [Num | Tail] = NumberList,
    [Log | LogTail] = ResultList,
    lg(Num, X),
    Log = [Num, X],
    log_table(Tail, LogTail).

% lg(X,Y) - binds the log(X) to Y
lg(X,Y) :-
    Y is log(X).


% paruns(List, RunList) - converts a list of numbers into the corresponding list of parity runs
paruns([],[]).
paruns(List, RunList) :-
    [ListHead|ListTail] = List,
    [RunListHead|RunListTail] = RunList,
    transfer(ListHead, ListTail, Ys, RunListHead),
    paruns(Ys, RunListTail).

% transfer(ListHead, ListTail, RunListHead, RunListTail) - helper function to iterate through list and determine if parity changes in the next List element
transfer(ListHead, [],[], [ListHead]).
transfer(ListHead,[ListHeadNext|ListTailRest],[ListHeadNext|ListTailRest],[ListHead]) :-
    ListHead mod 2 =\= ListHeadNext mod 2.
transfer(ListHead, [ListHeadNext| ListTailRest], Z,[ListHead|ListTail]) :-
    transfer(ListHeadNext, ListTailRest, Z, ListTail).



% tree_eval(Value, Tree, Eval) - binds Eval to the result of evaluating the expression-tree Tree, with the variable z set equal to the specified Value
tree_eval(Value, Tree, Eval) :-
    tree(L,D,R) = Tree,
    D == '+',
    tree_eval(Value,R,EvalR),
    tree_eval(Value,L, EvalL),
    Eval is EvalR+EvalL.

tree_eval(Value, Tree, Eval) :-
    tree(L,D,R) = Tree,
    D == '-',
    tree_eval(Value,R,EvalR),
    tree_eval(Value,L, EvalL),
    Eval is EvalL-EvalR.

tree_eval(Value, Tree, Eval) :-
    tree(L,D,R) = Tree,
    D == '*',
    tree_eval(Value,R,EvalR),
    tree_eval(Value,L, EvalL),
    Eval is EvalR*EvalL.

tree_eval(Value, Tree, Eval) :-
    tree(L,D,R) = Tree,
    D == '/',
    tree_eval(Value,R,EvalR),
    tree_eval(Value,L, EvalL),
    Eval is EvalL / EvalR.

tree_eval(_, Tree, Eval) :-
    tree(_,D,_) = Tree,
    integer(D),
    Eval is D.

tree_eval(Value, Tree,Eval) :-
    tree(_,D,_) = Tree,
    D == 'z',
    Eval is Value.













