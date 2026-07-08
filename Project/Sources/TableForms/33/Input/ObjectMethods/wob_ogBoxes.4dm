
var $vL_event_code; $vL_table : Integer
var $vJ_widget; $vJ_table; $vJ_empty; $vJ_count : Object
var $vP_table : Pointer
var $vT_table : Text
$vL_event_code:=Form event code:C388
Case of 
	: ($vL_event_code=On Load:K2:1)
		$vJ_widget:=Self:C308->
		$vJ_widget.fo_rsc:=Folder:C1567(fk resources folder:K87:11)
		$vJ_widget.t_value:="buttons/btn_ogBoxes"
		$vJ_widget.l_btn_wh:=24
		//$vJ_empty:=$vJ_widget.j_empty
		//$vJ_empty.l_colors:=0x331D01CF
		//$vJ_empty.l_font_color:=0x030001D2
		//$vJ_count:=$vJ_widget.j_count
		//$vJ_count.l_colors:=0x44334330
		//$vJ_count.l_font_color:=0x04000334
		
		$vJ_widget.tableOrRecord(Form:C1466.c4E)
		$vJ_widget.resize()
		$vJ_widget.redraw()
		
End case 

