//%attributes = {"lang":"en"}

#DECLARE($vL_width : Integer; $vL_height : Integer; $vO_picture : Picture; $vL_type : Integer)->$vO_answer : Picture
var $vL_centerX; $vL_centerY; $vL_img_width; $vL_img_height; $vL_offset_x; $vL_offset_y : Integer
var $vL_pattern; $vL_colors; $vL_svg_scale; $vL_color : Integer
var $vR_coef_width; $vR_coef_height; $vR_coef_img : Real
var $vT_svg_id; $vT_idImg : Text
var $vT_pattern_stroke; $vT_pattern_fill; $vT_pattern_name; $vT_object : Text

$vL_svg_scale:=2
$vL_width:=$vL_width*$vL_svg_scale
$vL_height:=$vL_height*$vL_svg_scale


$vT_svg_id:=SVG_New($vL_width; $vL_height)
$vL_centerX:=$vL_width/2
$vL_centerY:=$vL_height/2

// Type -> Bkg : 0 Transparent ; 1 White ; 2 black
// NEW added 3 grey ; 4 monocolor

If ($vL_type=4)
	$vL_pattern:=1
	$vL_colors:=0x331EB1CF
	woc_sp_colors_to_svg($vL_colors; ->$vT_pattern_stroke; ->$vT_pattern_fill)
	$vT_pattern_name:="pattern"
	woc_svg_patterns($vT_svg_id; $vT_pattern_name; $vL_pattern; $vT_pattern_stroke; $vT_pattern_fill)
	$vT_object:=SVG_New_rect($vT_svg_id; 0; 0; $vL_width; $vL_height; 0; 0; "none"; "url(#"+$vT_pattern_name+")"; 0)
Else 
	$vL_color:=$vL_type=0 ? 0x00F3 : 0x00F4
	$vT_pattern_fill:=woc_sp_color_to_svg($vL_color)
	$vT_object:=SVG_New_rect($vT_svg_id; 0; 0; $vL_width; $vL_height; 0; 0; "none"; $vT_pattern_fill; 0)
End if 


PICTURE PROPERTIES:C457($vO_picture; $vL_img_width; $vL_img_height)
If ($vL_img_width#0) & ($vL_img_height#0)
	$vR_coef_width:=$vL_width/$vL_img_width
	$vR_coef_height:=$vL_height/$vL_img_height
	$vR_coef_img:=$vR_coef_width
	If ($vR_coef_width>$vR_coef_height)
		$vR_coef_img:=$vR_coef_height
	End if 
	If ($vR_coef_img<1)
		$vR_coef_width:=$vL_img_width*$vR_coef_img
		$vR_coef_height:=$vL_img_height*$vR_coef_img
		CREATE THUMBNAIL:C679($vO_picture; $vO_picture; $vR_coef_width; $vR_coef_height)
	Else 
		$vR_coef_width:=$vL_img_width
		$vR_coef_height:=$vL_img_height
	End if 
	$vL_offset_x:=$vL_centerX-($vR_coef_width/2)
	$vL_offset_y:=$vL_centerY-($vR_coef_height/2)
	$vT_idImg:=SVG_New_embedded_image($vT_svg_id; $vO_picture; $vL_offset_x; $vL_offset_y)
End if 

SVG EXPORT TO PICTURE:C1017($vT_svg_id; $vO_answer; Get XML data source:K45:16)
SVG_CLEAR($vT_svg_id)

//$vO_answer:=$vO_picture