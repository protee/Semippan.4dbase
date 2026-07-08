
var $vL_event_code : Integer
var $vJ_widget : Object

$vL_event_code:=Form event code:C388

Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.bind_to_c4E("sourcePNG"; Background color none:K23:10)
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466.fc._media_chgt($vJ_widget)
		
End case 

