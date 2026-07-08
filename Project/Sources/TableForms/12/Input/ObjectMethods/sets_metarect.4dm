

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.l_colors:=wox_field_colors(Form:C1466.is_new; Form:C1466.is_editing)
		$vJ_widget.resize()
		
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466.fc._sets_chgt()
		
End case 


