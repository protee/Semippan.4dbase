
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388

var $vJ_widget : Object
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		//$vJ_widget.is_debug:=True
		$vJ_widget.t_label:=""
		$vJ_widget.is_editing:=True:C214
		$vJ_widget.l_click_mode:=2
		$vJ_widget.t_table:=Table name:C256(->[TYPES:32])
		$vJ_widget.j_menu:=sem__storage_menuBtns().m_4d_types
		
		$vJ_widget.resize()
		//$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466._filters()
		
		
	: ($vL_event_code=On Unload:K2:2)
		$vJ_widget:=Self:C308->
		$vJ_widget.unload()
		
End case 

