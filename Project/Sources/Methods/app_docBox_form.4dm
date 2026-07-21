//%attributes = {}

var $vJ_params; $vJ_prefs : Object
var $vT_title : Text
$vJ_prefs:=app__storage_prefs()
$vT_title:=$vJ_prefs.t_name+" "+$vJ_prefs.t_version
$vJ_params:=New object:C1471
$vJ_params.t_root_path:="/RESOURCES/_HELP"
//$vJ_params.t_root_path:=h_server_get_resources+"_HELP"+Folder separator
$vJ_params.t_sub_path:=""
$vJ_params.t_root:="HELP : "+$vT_title
$vJ_params.t_title:=$vT_title+" ogBox - integrated help"
$vJ_params.t_process:="HELP"
$vJ_params.t_pref_name:="help"
$vJ_params.is_editing:=False:C215
$vJ_params.r_font_size_coef:=0.9
wob_open($vJ_params)

