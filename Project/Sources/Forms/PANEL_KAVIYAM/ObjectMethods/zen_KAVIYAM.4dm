

var $vL_event_code : Integer
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		var $vJ_widget; $vJ_prefs : Object
		$vJ_widget:=Self:C308->
		$vJ_widget.t_tip:="KAVIYAM record"
		$vJ_widget.t_table:="KAVIYAM"
		//$vJ_widget.l_count:=0
		//$vJ_widget.is_list:=True
		//$vJ_widget.t_view:="banks"
		$vJ_widget.cES_KAVIYAM:=ds:C1482.KAVIYAM.query("isActive = :1"; True:C214).orderBy("label")
		$vJ_prefs:=Form:C1466.j_prefs
		$vJ_widget.bind_to("UIDkaviyam"; $vJ_prefs)
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
		
	: ($vL_event_code=k_OnDataChange)
		Form:C1466.fc.record_load_upd()
		
End case 

