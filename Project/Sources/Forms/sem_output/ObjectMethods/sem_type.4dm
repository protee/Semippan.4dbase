
var $vL_event_code : Integer
var $vJ_widget : Object

$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.j_menu:=sem__storage_menuBtns().m_outputType
		$vJ_widget.is_palette:=True:C214
		$vJ_io_palette:=New object:C1471()
		$vJ_widget.j_io_palette:=$vJ_io_palette
		$vJ_io_palette.r_angle_start:=0
		$vJ_io_palette.r_angle_end:=0
		$vJ_widget.resize()
		
	: ($vL_event_code=k_OnDataChange)
		$vJ_widget:=Self:C308->
		Form:C1466._type_chgt($vJ_widget)
		
End case 
