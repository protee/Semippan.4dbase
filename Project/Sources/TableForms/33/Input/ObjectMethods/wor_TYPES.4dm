
var $vL_event_code : Integer
$vL_event_code:=Form event code:C388

var $vJ_widget : Object
var $vT_table : Text
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vT_table:=Table name:C256(->[TYPES_R:32])
		$vJ_widget.t_label:=$vT_table
		$vJ_widget.t_table:=$vT_table
		$vJ_widget.j_menu:=app__storage_menuBtns().m_4d_types
		
		$vJ_widget.bind_to_c4E("UIDtype")
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
		//: ($vL_event_code=k_OnDataChange)
		//$vJ_widget:=Self->
		//$c4E:=Form.c4E
		
End case 

