%% @author Punneliparambil & Seemann
%% @doc Entwurfsbeschreibung: ADP2_Entwurf2_Punneliparambil_Seemann
%% Testumgebung in Absprache mit Team 20 entwickelt

-module(runtime).
-export([runQS/5,runIS/3,runMS/3,runSS/3,runQS_IS/5]).

%----------------------------------------------------------------------------------------------------------------------
%%Start: Listengroesse Startwert Bsp. 0
%%End: Listengroesse Endwert Bsp. 5000
%%Interval: Sprunginterval von Start
%%Sn: Switch-Number
%%Sorted: aufsteigen sortiert -> true, else random Liste
runQS(Start,End,Interval,SN,Sorted)->
		util:logging('RunQuickVanilla.log', "Size  " ),
		util:logging('RunQuickVanilla.log', "Left  " ),
		util:logging('RunQuickVanilla.log', "Right  " ),
		util:logging('RunQuickVanilla.log', "Middle  " ),
		util:logging('RunQuickVanilla.log', "Median  " ),
		util:logging('RunQuickVanilla.log', "Random" ),
		util:logging('RunQuickVanilla.log', "\n"),
		runQS1(Start,End,Interval,SN,Sorted).

runQS1(Start,End,Interval,SN,Sorted) when Start =< End -> runQS(Start,SN,Sorted), runQS1(Start+Interval,End,Interval,SN,Sorted);
runQS1(_Start,_End,_Interval,_SN,_Sorted) -> util:logging('RunQuickVanilla.log', "\n").
		
runQS(Size,SN,Sorted) -> 
	if 
		Sorted -> List = util:sortliste(Size);
		true -> List = util:randomliste(Size)
	end,
		util:logging('RunQuickVanilla.log', util:to_String(Size) ++ "    "),

		Start1 = erlang:timestamp(),
    	ksort:qsort(left,List,SN),
    	Time1 = timer:now_diff(erlang:timestamp(), Start1)/1000,
		util:logging('RunQuickVanilla.log', util:to_String(Time1)++ "    "),
					
		Start2 = erlang:timestamp(),
    	ksort:qsort(right,List,SN),
    	Time2 = timer:now_diff(erlang:timestamp(), Start2)/1000,
		util:logging('RunQuickVanilla.log', util:to_String(Time2)++ "    "),
					
		Start3 = erlang:timestamp(),
    	ksort:qsort(middle,List,SN),
    	Time3 = timer:now_diff(erlang:timestamp(),Start3)/1000,
		util:logging('RunQuickVanilla.log', util:to_String(Time3)++ "    "),
		
		Start4 = erlang:timestamp(),
    	ksort:qsort(median,List,SN),
    	Time4 = timer:now_diff(erlang:timestamp(),Start4)/1000,
		util:logging('RunQuickVanilla.log', util:to_String(Time4)++ "    "),
		
		Start5 = erlang:timestamp(),
    	ksort:qsort(random,List,SN),
    	Time5 = timer:now_diff(erlang:timestamp(),Start5)/1000,
		util:logging('RunQuickVanilla.log', util:to_String(Time5)++ "    "),
		
		util:logging('RunQuickVanilla.log', "\n").

%----------------------------------------------------------------------------------------------------------------------
%%Insertion Sort mit einer aufsteigend, absteigen und unsortierten Liste
%%Start: Listengroesse Startwert Bsp. 0
%%End: Listengroesse Endwert Bsp. 5000
%%Interval: Sprunginterval von Start
runIS(Start,End,Interval) -> 
		util:logging('RuntimeIS.log', "Size  " ),
		util:logging('RuntimeIS.log', "Ascending  " ),
		util:logging('RuntimeIS.log', "Descending  " ),
		util:logging('RuntimeIS.log', "Random" ),
		util:logging('RuntimeIS.log', "\n"),
		runIS1(Start,End,Interval).


runIS1(Start,End,Interval) when Start =< End -> runIS2(Start), runIS1(Start+Interval,End,Interval);
runIS1(_S,_E,_I) -> util:logging('RuntimeIS.log', "\n").

runIS2(Size) ->
		SortedAsc = util:sortliste(Size),
		SortedDsc = util:resortliste(Size),
		RandList = util:randomlisteD(Size, 1, 100000),
		util:logging('RuntimeIS.log', util:to_String(Size) ++ "    "),
		
		Start1 = erlang:timestamp(),
    	ssort:insertionS(SortedAsc),
    	Time1 = timer:now_diff(erlang:timestamp(), Start1)/1000,
		util:logging('RuntimeIS.log', util:to_String(Time1) ++ "    "),
					
		Start2 = erlang:timestamp(),
    	ssort:insertionS(SortedDsc),
    	Time2 = timer:now_diff(erlang:timestamp(), Start2)/1000,
		util:logging('RuntimeIS.log', util:to_String(Time2) ++ "    "),
					
		Start3 = erlang:timestamp(),
    	ssort:insertionS(RandList),
    	Time3 = timer:now_diff(erlang:timestamp(),Start3)/1000,
		util:logging('RuntimeIS.log', util:to_String(Time3) ++ "    "),
		
		util:logging('RuntimeIS.log', "\n").
%----------------------------------------------------------------------------------------------------------------------
%%Selection Sort mit einer aufsteigend, absteigen und unsortierten Liste
%%Start: Listengroesse Startwert Bsp. 0
%%End: Listengroesse Endwert Bsp. 5000
%%Interval: Sprunginterval von Start
runSS(Start,End,Interval) -> 
		util:logging('RuntimeSSort.log', "Size  " ),
		util:logging('RuntimeSSort.log', "Ascending  " ),
		util:logging('RuntimeSSort.log', "Descending  " ),
		util:logging('RuntimeSSort.log', "Random" ),
		util:logging('RuntimeSSort.log', "\n"),
		runSS1(Start,End,Interval).


runSS1(Start,End,Interval) when Start =< End -> runSS2(Start), runSS1(Start+Interval,End,Interval);
runSS1(_S,_E,_I) -> util:logging('RuntimeSSort.log', "\n").

runSS2(Size) ->
		SortedAsc = util:sortliste(Size),
		SortedDsc = util:resortliste(Size),
		RandList = util:randomliste(Size),
		util:logging('RuntimeSSort.log', util:to_String(Size) ++ "    "),
		
		Start1 = erlang:timestamp(),
    	ssort:selectionS(SortedAsc),
    	Time1 = timer:now_diff(erlang:timestamp(), Start1)/1000,
		util:logging('RuntimeSSort.log', util:to_String(Time1) ++ "    "),
					
		Start2 = erlang:timestamp(),
    	ssort:selectionS(SortedDsc),
    	Time2 = timer:now_diff(erlang:timestamp(), Start2)/1000,
		util:logging('RuntimeSSort.log', util:to_String(Time2) ++ "    "),
					
		Start3 = erlang:timestamp(),
    	ssort:selectionS(RandList),
    	Time3 = timer:now_diff(erlang:timestamp(),Start3)/1000,
		util:logging('RuntimeSSort.log', util:to_String(Time3) ++ "    "),
		
		util:logging('RuntimeSSort.log', "\n").
%-------------------------------------------------------------------------------
%%Merge Sort mit einer aufsteigend, absteigen und unsortierten Liste
%%Start: Listengroesse Startwert Bsp. 0
%%End: Listengroesse Endwert Bsp. 5000
%%Interval: Sprunginterval von Start
runMS(Start,End,Interval) -> 
		util:logging('RuntimeMSort.log', "Size  " ),
		util:logging('RuntimeMSort.log', "Ascending  " ),
		util:logging('RuntimeMSort.log', "Descending  " ),
		util:logging('RuntimeMSort.log', "Random" ),
		util:logging('RuntimeMSort.log', "\n"),
		runMS1(Start,End,Interval).


runMS1(Start,End,Interval) when Start =< End -> runMS2(Start), runMS1(Start+Interval,End,Interval);
runMS1(_S,_E,_I) -> util:logging('RuntimeMSort.log', "\n").

runMS2(Size) ->
		SortedAsc = util:sortliste(Size),
		SortedDsc = util:resortliste(Size),
		RandList = util:randomliste(Size),
		util:logging('RuntimeMSort.log', util:to_String(Size) ++ "    "),
		
		Start1 = erlang:timestamp(),
    	ksort:msort(SortedAsc),
    	Time1 = timer:now_diff(erlang:timestamp(), Start1)/1000,
		util:logging('RuntimeMSort.log', util:to_String(Time1) ++ "    "),
					
		Start2 = erlang:timestamp(),
    	ksort:msort(SortedDsc),
    	Time2 = timer:now_diff(erlang:timestamp(), Start2)/1000,
		util:logging('RuntimeMSort.log', util:to_String(Time2) ++ "    "),
					
		Start3 = erlang:timestamp(),
    	ksort:msort(RandList),
    	Time3 = timer:now_diff(erlang:timestamp(),Start3)/1000,
		util:logging('RuntimeMSort.log', util:to_String(Time3) ++ "    "),
		
		util:logging('RuntimeMSort.log', "\n").
		
	
%-------------------------------------------------------------------------------
%% Quick Sort vs Insertion Sort
%%Start: Listengroesse Startwert Bsp. 0
%%End: Listengroesse Endwert Bsp. 5000
%%Interval: Sprunginterval von Start
%%PM: Pivot-Methode -> left,right,middle,median,random
%%Sn: Switch-Number
runQS_IS(Start,End,Interval,PM,SN) ->
		util:logging('RuntimeQS_IS.log', "Size  " ),
		util:logging('RuntimeQS_IS.log', "Insertion  " ),
		util:logging('RuntimeQS_IS.log', "Quick" ),
		util:logging('RuntimeQS_IS.log', "\n"),
		runQS_IS1(Start,End,Interval,PM,SN).

runQS_IS1(Start,End,Interval,PM,SN) when Start =< End -> runQS_IS(PM,Start,SN), runQS_IS1(Start+Interval,End,Interval,PM,SN);
runQS_IS1(_S,_E,_I,_,_) -> util:logging('RuntimeQS_IS.log', "\n").
		

runQS_IS(PM,Size,SN) ->
		RandList = util:randomliste(Size),
		util:logging('RuntimeQS_IS.log', util:to_String(Size) ++ "    "),
		
		Start1 = erlang:timestamp(),
    	ssort:insertionS(RandList),
    	Time1 = timer:now_diff(erlang:timestamp(), Start1),
		util:logging('RuntimeQS_IS.log', util:to_String(Time1) ++ "    "),
					
		Start2 = erlang:timestamp(),
    	ksort:qsort(PM,RandList,SN),
    	Time2 = timer:now_diff(erlang:timestamp(), Start2),
		util:logging('RuntimeQS_IS.log', util:to_String(Time2) ++ "    "),
	
		util:logging('RuntimeQS_IS.log', "\n").
		


















	
	
	
	