
var $vL_event_code : Integer
var $vJ_widget : Object
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.aj_colors[1].l_back:=0xAA05905A  // [swo:89] – [swo:90]
		$vJ_widget.resize()
		//$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466._filters()
		
		
End case 

