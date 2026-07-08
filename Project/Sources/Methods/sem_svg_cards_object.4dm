//%attributes = {}

#DECLARE($vP_canvas : Pointer; $vL_value : Integer; $vC_aj_cards : Collection; $vL_mouseX : Integer; $vR_coef : Real; $vJ_widget : Object)->$vO_picture : Picture
var $vL_left; $vL_top; $vL_right; $vL_bottom; $vL_height; $vL_width : Integer
var $vL_svg_scale : Integer

OBJECT GET COORDINATES:C663($vP_canvas->; $vL_left; $vL_top; $vL_right; $vL_bottom)
$vL_height:=$vL_bottom-$vL_top
$vL_width:=$vL_right-$vL_left
$vL_svg_scale:=waz__storage_prefs.l_svg_scale
$vL_width*=$vL_svg_scale
$vL_height*=$vL_svg_scale

$vO_picture:=sem_svg_cards($vL_width; $vL_height; $vL_value; $vC_aj_cards; $vL_mouseX; $vR_coef; $vJ_widget)

