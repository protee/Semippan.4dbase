//%attributes = {"lang":"en"}

var $vC_at_lbl : Collection
var $vJ_menu : Object
$vJ_menu:=wox__storage_m_curves()
$vC_at_lbl:=$vJ_menu.at_lbl

var $cs_wox_TUNES : cs:C1710.wox.TUNES
$cs_wox_TUNES:=cs:C1710.wox.SOUNDS.me
$cs_wox_TUNES.play_confirm()


$vJ_prefs:=app__storage_prefs()
$vJ_stuff:=app__storage_stuff()
$vJ_widgets:=app__storage_widgets()
