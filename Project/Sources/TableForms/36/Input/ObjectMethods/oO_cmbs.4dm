
var $vL_left; $vL_right; $vL_bottom; $vL_width; $vL_height; $vL_top; $vL_stroke : Integer
var $vO_answer : Picture
var $vP_canvas : Pointer
var $vC_al_colors : Collection
var $vJ_woc_alColors; $vJ_value : Object
$vP_canvas:=Self:C308

$vJ_woc_alColors:=OBJECT Get value:C1743("woc_alColors")
$vJ_value:=$vJ_woc_alColors.j_value
$vC_al_colors:=$vJ_value.al_colors

OBJECT GET COORDINATES:C663($vP_canvas->; $vL_left; $vL_top; $vL_right; $vL_bottom)
$vL_width:=$vL_right-$vL_left
$vL_height:=$vL_bottom-$vL_top
$vL_stroke:=8
$vO_answer:=woc_svg_al_colors($vC_al_colors; $vL_width; $vL_height; $vL_stroke)
$vP_canvas->:=$vO_answer

