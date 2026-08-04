//%attributes = {"lang":"en"}

#DECLARE($cE_SETS : cs:C1710.SETSEntity; $cE_MEDIA : cs:C1710.MEDIAEntity; $vO_img_picture : Picture; $vL_colors : Integer; $vL_brightness : Integer; $is_grey_scale : Boolean; $is_img_offset : Boolean)->$vO_picture : Picture
var $is_MEDIA; $is_set_shape : Boolean
var $vL_text_color; $vL_index; $vL_space; $vL_shape; $vL_img_offset_x; $vL_img_offset_y; $vL_text_style; $vL_width; $vL_heigth; $vL_stroke; $vL_media_tl; $vL_media_tr; $vL_media_br; $vL_media_bl : Integer
var $vL_MEDIA_sourcePNG; $vL_MEDIA_targetPNG; $vL_target_rgb : Integer
var $vL_MEDIA_shape; $vL_MEDIA_size; $vL_MEDIA_angle; $vL_MEDIA_brightness; $vL_MEDIA_colorsSVG; $vL_angle : Integer
var $vJ_options; $vJ_metarect; $vJ_picture; $vJ_text; $vJ_MEDIA_metarect : Object
var $vR_text_coef; $vR_img_coef; $vR_size; $vR_img_brightness; $vR_radius_tl; $vR_radius_tr; $vR_radius_coef; $vR_radius_br; $vR_radius_bl; $vR_offset_x; $vR_offset_y : Real
var $vT_text_font; $vT_text; $vT_dom_picture; $vT_stroke_color; $vT_fill_color : Text

$vJ_metarect:=$cE_SETS.j_metarect
$vJ_picture:=$cE_SETS.j_picture
$vJ_text:=$cE_SETS.j_text
$vJ_options:=$cE_SETS.j_options
$is_set_shape:=$vJ_options.isSetShape

$is_MEDIA:=($cE_MEDIA#Null:C1517)
If ($is_MEDIA)
	$vT_text:=$cE_MEDIA.text
	If (Not:C34($is_set_shape))
		$vL_MEDIA_shape:=$cE_MEDIA.shape
	End if 
	$vL_MEDIA_size:=$cE_MEDIA.size
	$vL_MEDIA_angle:=$cE_MEDIA.angle
	$vL_MEDIA_brightness:=$cE_MEDIA.brightness
	$vL_MEDIA_colorsSVG:=$cE_MEDIA.colorsSVG
	$vL_MEDIA_sourcePNG:=$cE_MEDIA.sourcePNG
	$vL_MEDIA_targetPNG:=$cE_MEDIA.targetPNG
	
	$vJ_MEDIA_metarect:=$cE_MEDIA.j_metarect
	$vL_media_tl:=$vJ_MEDIA_metarect.l_tl
	$vL_media_tr:=$vJ_MEDIA_metarect.l_tr
	$vL_media_br:=$vJ_MEDIA_metarect.l_br
	$vL_media_bl:=$vJ_MEDIA_metarect.l_bl
Else 
	$vL_media_tl:=-1  // All off
	$vL_media_tr:=-1
	$vL_media_br:=-1
	$vL_media_bl:=-1
End if 

$vL_text_color:=$cE_MEDIA.colorText
$vL_index:=woc_sp_color_to_index($vL_text_color; ->$vL_space)
//If ($vL_txt_color=k_MDcolorTransparent) | ($vL_txt_color=0)
If (woc_sp_color_isTransparent($vL_text_color) || ($vL_text_color=0))
	$vL_text_color:=$vJ_text.l_color
End if 

If (woc_sp_color_isTransparent($vL_text_color))
	$vL_text_color:=woc_sp_colors_to_s($vL_colors)
End if 

$vL_shape:=$is_set_shape || ($vL_MEDIA_shape=0) ? $cE_SETS.shape : $vL_MEDIA_shape
$vL_img_offset_x:=Num:C11($is_img_offset)
$vL_img_offset_y:=$vL_img_offset_x

// TXT
$vT_text_font:=$vJ_text.t_face
$vR_text_coef:=$vJ_text.l_size/100

$vL_text_style:=$vJ_text.l_style
$vR_img_coef:=($vJ_picture.l_size+$vL_MEDIA_size)/100

$vL_width:=$cE_SETS.width
$vL_heigth:=$cE_SETS.height
$vR_size:=$cE_SETS.size/100
$vL_angle:=$vJ_picture.l_angle+$vL_MEDIA_angle
$vL_stroke:=$cE_SETS.stroke
$vR_img_brightness:=1+(($vL_brightness+$vL_MEDIA_brightness)/100)
$vR_radius_coef:=Square root:C539(($vL_width*$vL_width)+($vL_heigth*$vL_heigth))*$vR_size/50

$vR_radius_tl:=$is_set_shape || ($vL_media_tl<0) ? $vJ_metarect.l_tl : $vL_media_tl
$vR_radius_tr:=$is_set_shape || ($vL_media_tr<0) ? $vJ_metarect.l_tr : $vL_media_tr
$vR_radius_tl*=$vR_radius_coef
$vR_radius_tr*=$vR_radius_coef

If ($vL_shape=15)  // Metarect !
	$vR_radius_br:=$is_set_shape || ($vL_media_br<0) ? $vJ_metarect.l_br : $vL_media_br
	$vR_radius_bl:=$is_set_shape || ($vL_media_bl<0) ? $vJ_metarect.l_bl : $vL_media_bl
	$vR_radius_br*=$vR_radius_coef
	$vR_radius_bl*=$vR_radius_coef
End if 


$vR_offset_x:=$vJ_text.l_offsetX/100  // [0-1]
$vR_offset_y:=$vJ_text.l_offsetY/100



If (img_tools_isCodec($vO_img_picture))  // SVG Conversion colors
	If (($vL_MEDIA_colorsSVG#0) && ($vL_MEDIA_colorsSVG#0xFFFF))
		$vT_dom_picture:=SVG_Open_picture($vO_img_picture)
		If ($vT_dom_picture#"")  // SVG
			woc_sp_colors_to_svg($vL_MEDIA_colorsSVG; ->$vT_stroke_color; ->$vT_fill_color)
			woc_svg_domPicture_colors($vT_dom_picture; $vT_stroke_color; $vT_fill_color)
			SVG EXPORT TO PICTURE:C1017($vT_dom_picture; $vO_img_picture; Own XML data source:K45:18)
		End if 
	End if 
	
Else   // PNG
	If ($vL_MEDIA_sourcePNG#Background color none:K23:10)
		$vL_target_rgb:=woc_sp_color_to_rgb($vL_MEDIA_targetPNG)
		$vO_img_picture:=woc_picture_colorize($vO_img_picture; $vL_MEDIA_sourcePNG; $vL_target_rgb)
	End if 
End if 

$vO_picture:=woc_picture_icon(\
$vL_width; $vL_heigth; $vR_size; $vR_radius_tl; $vR_radius_tr; \
$vR_radius_br; $vR_radius_bl; $vL_stroke; $vL_shape; $vL_colors; \
$vT_text; $vL_angle; $vT_text_font; $vR_text_coef; $vL_text_color; \
$vL_text_style; $vR_offset_x; $vR_offset_y; $vO_img_picture; $vR_img_coef; \
$vL_img_offset_x; $vL_img_offset_y; $vR_img_brightness; $is_grey_scale)

