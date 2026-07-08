
var $vL_event_code : Integer
var $vJ_widget : Object

$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		//woc_setWidget(app__storage_stuff.woc_colors_squares)
		$vJ_widget:=Self:C308->
		$vJ_widget.bind_to_c4E("shape"; 2)
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466.fc.redraw_pictures()
		
End case 

