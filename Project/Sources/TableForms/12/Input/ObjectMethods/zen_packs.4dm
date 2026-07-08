

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.c4E_set("PACKS"; "UIDpack")
		//$vJ_widget.t_table:="PACKS"
		//$vJ_widget.bind_to_c4E("UIDpack")
		$vJ_widget.t_tip:="PACKS record"
		$vJ_widget.l_font_size:=16
		$vJ_widget.l_font_style:=Bold:K14:2
		//$vJ_widget.l_count:=0
		//$vJ_widget.is_list:=True
		//$vJ_widget.t_view:="banks"
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
		//: ($vL_event_code=k_OnDataChange)
		//Form.fc.isModeIcn()
		
End case 


