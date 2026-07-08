

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.UID:="15439F31CD094C41BFA51AEBBA65E076"
		$vJ_widget.t_tip:="PICTURES record"
		$vJ_widget.t_table:="PICTURES"
		$vJ_widget.is_list:=True:C214
		$vJ_widget.t_view:="media"
		$vJ_widget.t_colors:=""
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466.fc._pict_chgt()
		
End case 


