
var $vL_event_code : Integer
var $vJ_widget : Object

$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.j_menu:=app__storage_menuBtns().m_pict_source
		$vJ_widget.bind_to_c4E("isLinkedPicture")
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466.fc._media_chgt()
		
		
End case 
