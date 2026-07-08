
var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.resize()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		//$vJ_value:=$vJ_widget.j_value
		Form:C1466.fc._sets_chgt()  // Do a redraw based on new data in sem_output
		
End case 


