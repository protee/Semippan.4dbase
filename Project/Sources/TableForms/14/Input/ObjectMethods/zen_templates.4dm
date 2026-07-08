

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.t_table:="TEMPLATES"
		$vJ_widget.bind_to_c4E("UIDtemplate")
		//$vJ_widget.t_tip:="TEMPLATES record"
		$vJ_widget.t_colors:=""
		
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466.fc._template_chgt()
		
End case 


