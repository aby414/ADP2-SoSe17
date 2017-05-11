%% @author Punneliparambil & Seemann
%% @doc Entwurfsbeschreibung: ADP2_Entwurf2_Punneliparambil_Seemann


-module(ksort).
-export([qsort/3,findPivot/2,msort/1]).
%[12,9,4,99,120,1,3,10,1,2,4]

%----------------------------------------------------------------------------------------------------------------------     
% In den Kommentaren wird gezeigt welcher Codebereich die Punkte des allgemeinen Algorithmus(Entwurf) erfuellt.
%% Quick Sort
qsort(_PM,[],_SN) -> [];														
qsort(_PM,List,_SN) when (length(List) == 1) -> List;							% Punkt1(AllgALg): Trivialer Fall, einelementig Liste ist immer sortert.
qsort(_PM,List,SN) when SN > length(List) -> ssort:insertionS(List);			% Ab der Laenge SN wechseln wir zu insertionS/1
qsort(PM,List,SN) ->  Pivot = findPivot(List,PM),									%Punkt2(AllgALg): Wir bestimmen das Pivot-Element 
					  List2 = List -- [Pivot],										
					  {Smaller,Bigger} = qsort(Pivot,[],[],List2),					% und sortieren die Elemente Elemente links und rechts vom Pivot
					  qsort(PM, Smaller, SN) ++ [Pivot] ++ qsort(PM, Bigger, SN).	% Punkt 2(AllgALg): Die Elemente links sind kleiner als Pivot und
																					% die Elemente rechts sind groesser-gleich Pivot
																					%Punkt3(AllgALg): Quicksort wird auf den linken und rechten Vom Pivot angewendet

%Punkt 2(AllgALg): Sequenz sortieren
% Erstellt zwei Listen. Smaller enthealt Elemente, die kleiner als Pivot sind
% und Bigger Elemente, die groesser-gleichr als Pivot sind
qsort(_Pivot,Smaller,Bigger,[]) -> {Smaller,Bigger};
qsort(Pivot,Smaller,Bigger,[H|T]) when Pivot > H -> qsort(Pivot, [H|Smaller], Bigger,T);
qsort(Pivot,Smaller,Bigger,[H|T]) when Pivot =< H -> qsort(Pivot, Smaller, [H|Bigger],T).


%% Findet das Pivot-Element anhand der Pivotmethode PM
findPivot(List,PM) ->
	case PM of
		left -> hd(List);
		right -> lists:last(List);
		middle -> lists:nth(trunc((1+length(List))/2), List);
		median -> L = hd(List), R = lists:last(List), M = lists:nth((1+length(List) div 2), List),
			if 
				(L =< R) and (R =< M) -> R;
				(M =< R) and (R =< L) -> R;
				(L =< M) and (M =< R) -> M;
				(R =< M) and (M =< L) -> M;
				(M =< L) and (L =< R) -> L;
				true -> L
			end;			
		random -> lists:nth(crypto:rand_uniform(1,length(List)+1), List);
		_Else ->  hd(List)
	end.


%----------------------------------------------------------------------------------------------------------------------
% In den Kommentaren wird gezeigt welcher Codebereich die Punkte des allgemeinen Algorithmus(Entwurf) erfuellt.
%% Merge Sort
msort([]) -> [];	% Basisfall

msort([H|[]]) -> [H]; % 1.	Bis die Liste nur noch ein Element lang ist



msort(List) ->
	Length = length(List),
	L1 = sublist(List, Length div 2),					% Sublist halbiert die Liste an dem Counter, hier in der Mitte
	L2 = List -- L1,									% Um die zweite Haelfte zu erhalten ziehen wir den ersten Teil der Liste ab
	merge(												% c.	Fuege die Teillisten sortiert wieder zusammen
	  msort(L1),										% a.	Halbiere die Liste; b.	Fuehre den Algorithmus auf die linke Teilliste aus
	  msort(L2)).										% a.	Halbiere die Liste; b.	Fuehre den Algorithmus auf die rechte Teilliste aus



merge([],List)-> List;
merge(List,[])-> List;

merge([HLeft|TLeft],[HRight|TRight]) when HLeft =< HRight -> [HLeft|merge(TLeft,[HRight|TRight])];

merge([HLeft|TLeft],[HRight|TRight]) -> [HRight|merge([HLeft|TLeft],TRight)].



sublist([],_Counter)-> [];
sublist([H],_Counter) -> [H];
sublist([H|_T],1) -> [H];
sublist(_List,0) -> [];
sublist([H|T],Counter) -> [H]++sublist(T,Counter-1).


