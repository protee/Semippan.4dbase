//%attributes = {}

#DECLARE($vP_table : Pointer; $vT_form : Text; $vT_title : Text; $vJ_form : Object)->$isOk : Boolean
var $vL_winRef : Integer
var $vL_form; $vL_width; $vL_height; $vL_duration : Integer
var $vJ_form_params; $vJ_screen_form; $vJ_settings : Object
var $is_moveAtStart : Boolean
var $vT_screen_form : Text

$vJ_settings:=zen__storage_prefs().j_settings
$vL_duration:=$vJ_settings.l_tempo
$is_moveAtStart:=$vL_duration<10

$vJ_form:=$vJ_form#Null:C1517 ? $vJ_form : New object:C1471()

$vT_screen_form:=$vP_table#Null:C1517 ? Table name:C256($vP_table)+"_"+$vT_form : $vT_form
$vJ_screen_form:=wox_window_form_vJ($vT_screen_form)
$vJ_form._j_form:=$vJ_screen_form
x_get_form_wh($vP_table; $vT_form; ->$vL_width; ->$vL_height)
$vJ_form_params:=wox_window_form_pull_wh($vJ_screen_form; $vL_width; $vL_height)
$vJ_form._j_params:=$vJ_form_params
//wox_vJ_overload($vJ_form_prefs; $vJ_params.j_prefs)
$vL_winRef:=x_window_open($vP_table; $vT_form; $vL_form; $vJ_form_params; $is_moveAtStart)
wox_window_lock($vL_winRef)
cs:C1710.wox.TUNES.me.play_list_open()
SET WINDOW TITLE:C213($vT_title; $vL_winRef)

If ($vP_table#Null:C1517)
	DIALOG:C40($vP_table->; $vT_form; $vJ_form)
Else 
	DIALOG:C40($vT_form; $vJ_form)
End if 
$isOk:=(OK=1)
x_get_window_wh($vL_winRef; ->$vL_width; ->$vL_height)  //; $vJ_params)
wox_window_form_push_wh($vJ_screen_form; $vL_width; $vL_height)
CLOSE WINDOW:C154($vL_winRef)
wox_window_release($vL_winRef)
cs:C1710.wox.TUNES.me.play_list_close()

