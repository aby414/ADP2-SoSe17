%% @author Punneliparambil & Seemann
%% @doc @todo Add description to ssort_test.


-module(sort_test).
-include_lib("eunit/include/eunit.hrl").


insertionS_test() ->
	L1 = [12,9,4,99,120,1,3,10,1,2,4],
	L2 = lists:reverse([X||X<- lists:seq(1, 1000)]),
	?assert(ssort:insertionS(L1) == [1,1,2,3,4,4,9,10,12,99,120]),
	?assert(ssort:insertionS(L2) == [X||X<- lists:seq(1, 1000)] ),
	?assert(ssort:insertionS([]) == []),
	?assert(ssort:insertionS([1]) == [1]).

qsort_test() ->
	L1 = [12,9,4,99,120,1,3,10,1,2,4],
	
	?assert(ksort:qsort(left,L1,1) == [1,1,2,3,4,4,9,10,12,99,120]),
	?assert(ksort:qsort(right,L1,1) == [1,1,2,3,4,4,9,10,12,99,120]),
	?assert(ksort:qsort(middle,L1,1) == [1,1,2,3,4,4,9,10,12,99,120]),
	?assert(ksort:qsort(median,L1,1) == [1,1,2,3,4,4,9,10,12,99,120]),
	?assert(ksort:qsort(random,L1,1) == [1,1,2,3,4,4,9,10,12,99,120]),

	?assert(ksort:qsort(left,L1,0) == [1,1,2,3,4,4,9,10,12,99,120]),
	?assert(ksort:qsort(left,L1,80) == [1,1,2,3,4,4,9,10,12,99,120]).


selectionS_test() ->
	L1 = [5,64,75641,1,65546,80,14156,15,25,35],
	L2 = lists:reverse([X||X<- lists:seq(1, 10000)]),

	?assert(ssort:selectionS(L1) == [1,5,15,25,35,64,80,14156,65546,75641]),
	?assert(ssort:selectionS(L2) == [X||X<- lists:seq(1, 10000)]),
	?assert(ssort:selectionS([]) == []),
	?assert(ssort:selectionS([1]) == [1]).

msort_test() ->
	L1 = [5,64,75641,1,65546,80,14156,15,25,35],
	L2 = lists:reverse([X||X<- lists:seq(1, 10000)]),

	?assert(ksort:msort(L1) == [1,5,15,25,35,64,80,14156,65546,75641]),
	?assert(ksort:msort(L2) == [X||X<- lists:seq(1, 10000)]),
	?assert(ksort:msort([]) == []),
	?assert(ksort:msort([1]) == [1]).
