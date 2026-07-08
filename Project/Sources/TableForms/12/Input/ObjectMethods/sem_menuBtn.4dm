
var $vL_event_code : Integer
var $vJ_widget : Object

$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.is_editing:=Form:C1466.is_editing
		$vJ_widget.j_value:=Form:C1466.c4E.j_menuBtn
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466.fc._menuBtn_chgt($vJ_widget)
		
	: ($vL_event_code=k_OnDoubleClicked)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._menuBtn_click($vJ_widget)
		
		
End case 

