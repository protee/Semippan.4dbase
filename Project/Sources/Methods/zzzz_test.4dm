//%attributes = {"lang":"en"}

var $vC_at_lbl : Collection
var $cC_wox_SOUNDS : cs:C1710.wox.SOUNDS
var $cC_wox_syntaxEN : cs:C1710.wox.syntaxEN
var $vJ_menu; $vJ_prefs; $vJ_stuff; $vJ_widgets : Object
$vJ_menu:=wox__storage_m_curves()
$vC_at_lbl:=$vJ_menu.at_lbl

$cC_wox_SOUNDS:=cs:C1710.wox.SOUNDS.me
$cC_wox_SOUNDS.play_confirm()


$vJ_prefs:=sem__storage_prefs()
$vJ_stuff:=sem__storage_stuff()
$vJ_widgets:=sem__storage_widgets()

$cC_wox_syntaxEN:=cs:C1710.wox.syntaxEN.new()
$cC_wox_syntaxEN:=cs:C1710.wox.syntaxEN.me

$vC_aj_dependencies:=$cC_wox_syntaxEN.get_dependencies()
$vJ_sem:=$vC_aj_dependencies.query("t_app = sem").first()

