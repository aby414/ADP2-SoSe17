%% @author Punneliparambil & Seemann
%% @doc Entwurfsbeschreibung: ADP2_Entwurf2_Punneliparambil_Seemann


-module(ssort).
-export([insertionS/1,findMin/1,selectionS/1]).

%----------------------------------------------------------------------------------------------------------------------
% In den Kommentaren wird gezeigt welcher Codebereich die Punkte des allgemeinen Algorithmus(Entwurf) erfuellt.
%%Insertion Sort
insertionS([]) -> [];						
insertionS([H|T]) -> insertionS([H],T).      % Punkt 1(AllgALg): Trivialer Fall, das Erste Element ist immer sortiert

insertionS(SList,[]) -> SList;					%unsortierte Liste ist leer			
insertionS(SList,[H|T]) -> insertionS(insert(H,SList),T).   %Punkt 2(AllgALg): Wir nehmen das naechste Element aus der unsortierten Sequenz und fuegen
															% es an die richitge Positon in der sortierten Sequenz ein.
															% Punkt 3(AllgALg): Solange wir unsortierte Elemente haben werden Elemente entnommen
															% Abbruch ist: insertionS(SList,[]) -> SList;

% Punkt2(AllgALg): Das einfuegen an die richtige Positon wird von dieser Funktion uebernommen.
insert(Elem,[]) -> [Elem];			
insert(Elem,[H|T]) when H >= Elem -> [Elem,H|T]; 
insert(Elem,[H|T]) -> [H| insert(Elem,T)].      


%----------------------------------------------------------------------------------------------------------------------
% In den Kommentaren wird gezeigt welcher Codebereich die Punkte des allgemeinen Algorithmus(Entwurf) erfuellt.
%% Selection Sort

selectionS([]) -> [];		% Basisfall
selectionS([H]) -> [H];		% Bedingung: Sonage die Liste mehr als ein unsortiertes Element hat
selectionS(List) -> Min = findMin(List), 					% Punkt a. Suche das kleinste Element
					[Min] ++ selectionS(remove(Min, List)).	% Punkt b. Nehme das kleinste unsortierte Element und verschiebe es an das Ende der sortierten Liste; 
															% remove(Min,List) entfernt hier das Min-Element aus der unsortierten Liste. Duplikate bleiben erhalten

															% Dies stimmt mit dem Kernkonzept ueberein, 
															% da das Kernkonzept das minimale Element an das Ende der sortierten Liste schiebt 
															% und es so aus der unsortierten Liste entfernt.
															% Ein Tauschverfahren wie im Java-Algorithmus waere auch moeglich, waere aber sehr ineffizient
	
findMin([]) -> [];
findMin([H|T]) -> findMin(H,T).
findMin(Elem,[]) -> Elem;
findMin(Elem,[H|T]) when H < Elem -> findMin(H,T);
findMin(Elem,[_H|T]) -> findMin(Elem,T).


remove(_, []) -> [];
remove(Elem, [H|T]) when Elem == H -> T;
remove(Elem,[H|T]) -> [H]++remove(Elem,T).








   