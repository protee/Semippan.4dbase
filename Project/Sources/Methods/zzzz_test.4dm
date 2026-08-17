//%attributes = {"lang":"en"}

var $vC_at_lbl : Collection
var $vJ_menu; $vJ_prefs; $vJ_stuff; $vJ_widgets : Object
$vJ_menu:=wox__storage_m_curves()
$vC_at_lbl:=$vJ_menu.at_lbl

var $cC_wox_SOUNDS : cs:C1710.wox.SOUNDS
$cC_wox_SOUNDS:=cs:C1710.wox.SOUNDS.me
$cC_wox_SOUNDS.play_confirm()


$vJ_prefs:=sem__storage_prefs()
$vJ_stuff:=sem__storage_stuff()
$vJ_widgets:=sem__storage_widgets()

$cs_CORE:=cs:C1710.wox.syntaxEN.new()

