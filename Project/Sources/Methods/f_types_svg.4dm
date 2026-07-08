//%attributes = {"lang":"en"}
// Project Method: f_types_svg
//
// Parameter Type Description
//
//
// Description:
// 
//
// Date        Init  Description
// ===================================================================
// 13/04/2023   OG   Initial version.

#DECLARE($vP_canvas : Pointer; $vC_lbl : Collection; $vC_colors : Collection; $vL_value : Integer)
var $is_value : Boolean
$is_value:=(Count parameters:C259>=4)

var $vL_left; $vL_top; $vL_right; $vL_bottom : Integer
OBJECT GET COORDINATES:C663($vP_canvas->; $vL_left; $vL_top; $vL_right; $vL_bottom)
var $vL_svg_height; $vL_svg_width : Integer
$vL_svg_width:=$vL_right-$vL_left+1
$vL_svg_height:=$vL_bottom-$vL_top+1


// SVG CREATE

//SVG_SET_OPTIONS(SVG_Get_options ?+ 5)  // pour produire un code svg lisible
var $vT_svg_root : Text
$vT_svg_root:=SVG_New($vL_svg_width; $vL_svg_height; "products"; "Gnana Olee"; True:C214; Truncated non centered:K6:4)  // Vrai -> viewbox de même taille que le document
SVG_SET_TRANSFORM_SCALE($vT_svg_root; 1; 1)
SVG_SET_ID($vT_svg_root; "root")  // afin d'avoir accès à la viewBox pour la modifier plus tard

var $vL_tt; $i; $vL_app_width; $x; $vL_r; $vL_size; $y; $idx; $x1; $vL_stroke; $vL_strokeD2 : Integer
var $is_inverse; $is_selected; $is_bold : Boolean
var $vT_svg_group : Text
$vL_tt:=$vC_lbl.length
$vL_app_width:=$vL_svg_width/$vL_tt
$x:=0
$vL_r:=3
$vL_size:=$vL_svg_height/2
$y:=$vL_svg_height/2-($vL_size*k_fontOffset_coef)
$is_inverse:=False:C215
$vL_stroke:=0
For ($i; 1; $vL_tt)
	$idx:=$i-1
	If ($is_value)
		$is_selected:=($idx=$vL_value)
		$vL_stroke:=$is_selected ? 2 : 0
		$is_bold:=$is_selected
	End if 
	$vL_strokeD2:=$vL_stroke/2
	$x1:=$vL_svg_width*$i/$vL_tt
	var $vT_stroke_txt; $vT_fill_txt : Text
	woc_sp_colors_to_svg(woc_sp_colors_inverse($vC_colors[$idx]; $is_inverse); ->$vT_stroke_txt; ->$vT_fill_txt)
	$vT_svg_group:=SVG_New_group($vT_svg_root; "pro_"+String:C10($idx))
	SVG_New_rect($vT_svg_group; $x+$vL_strokeD2; $vL_strokeD2; $x1-$x-$vL_stroke; $vL_svg_height-$vL_stroke; $vL_r; $vL_r; $vT_stroke_txt; $vT_fill_txt; $vL_stroke)
	SVG_New_text($vT_svg_group; $vC_lbl[$idx]; ($x1-$x)/2+$x; $y; "Calibri"; $vL_size; Num:C11($is_bold); 3; $vT_stroke_txt)
	$x:=$x1
End for 

$vP_canvas->:=SVG_Export_to_picture($vT_svg_root; Get XML data source:K45:16)
SVG_CLEAR($vT_svg_root)

