//%attributes = {"preemptive":"incapable"}

#DECLARE($vJ_params : Object)->$isOk : Boolean

READ ONLY:C145(*)

var $vT_form : Text
$vT_form:=$vJ_params.t_form
var $vP_table : Pointer
var $vL_table : Integer
$vL_table:=$vJ_params.l_table
$vP_table:=Table:C252($vL_table)

var $vT_table : Text
$vT_table:=$vJ_params.t_table
$vJ_params.c4E:=zen__ds[$vT_table].query("UID=:1"; $vJ_params.UID).first()

var $vL_bottom; $vL_left; $vL_right; $vL_top; $vL_winRef : Integer
$vL_winRef:=$vJ_params.l_winRef
GET WINDOW RECT:C443($vL_left; $vL_top; $vL_right; $vL_bottom; $vL_winRef)

If ($vP_table=Null:C1517)
	var $vL_height; $vL_winRefQV; $vL_width : Integer
	FORM GET PROPERTIES:C674($vT_form; $vL_width; $vL_height)
Else 
	FORM GET PROPERTIES:C674($vP_table->; $vT_form; $vL_width; $vL_height)
End if 
wox_form_xy_resize($vL_width; $vL_height; ->$vL_right; ->$vL_top)
var $vL_form : Integer
$vL_form:=$vJ_params.l_form
$vL_form:=$vL_form#0 ? $vL_form : Palette form window:K39:9

$vL_winRefQV:=Open form window:C675($vP_table->; $vT_form; $vL_form; $vL_right; $vL_top)
var $vT_title : Text
$vT_title:=zenh_localized(k_rsct_table; $vT_table)
$vT_title+=" : "+Localized string:C991("bt_quickView")
SET WINDOW TITLE:C213($vT_title; $vL_winRefQV)
CALL FORM:C1391($vL_winRef; Formula:C1597(Form:C1466.l_winRefQV:=$1); $vL_winRefQV)  // Call back to set winref

DIALOG:C40($vP_table->; $vT_form; $vJ_params)
CLOSE WINDOW:C154($vL_winRefQV)
CALL FORM:C1391($vL_winRef; Formula:C1597(Form:C1466.l_winRefQV:=0))  // Call back off
KILL WORKER:C1390(Current process:C322)

