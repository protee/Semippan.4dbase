//%attributes = {"lang":"en"}

#DECLARE($vL_width : Integer; $vL_height : Integer; $vL_value : Integer; $vC_aj_cards : Collection; $vL_mouseX : Integer; $vR_coef : Real; $vJ_widget : Object)->$vO_canvas : Picture
var $vL_opacity; $vL_svg_scale; $tt_cards; $vL_rxy; $vL_padding; $vL_x_left; $vL_cards_width; $vL_card_height; $vL_card_width; $vL_card_width_D2; $vL_radius; $vL_size; $vL_pattern; $vL_colors; $idx; $x; $vL_distance; $vL_w; $vL_h; $x1; $y1; $vL_offset; $x2; $y2 : Integer
var $vL_curve; $vL_cards_curve : Integer
var $vL_padding_x; $vL_padding_y; $vL_padding_x2; $vL_padding_y2; $vL_size_D2; $vL_type : Integer
var $vL_stroke; $vL_stroke_D2; $vL_card_top; $vL_size_txt; $vL_size_D4; $vL_size_D8 : Integer
var $vJ_pattern; $vJ_card : Object
var $vR_scale; $vR_radius; $vR_card_scale; $vR_ratio; $vR_card_coef : Real
var $vT_font_face; $vT_svg_root; $vT_patt_stroke; $vT_patt_fill; $vT_dot_stroke; $vT_dot_fill; $vT_svg_group; $vT_object; $vT_idText : Text
var $vT_patt_name; $vT_sel_stroke; $vT_sel_fill : Text
var $is_selected; $is_inverse : Boolean
var $vO_icon : Picture


// ***** Parameters
// *
$vJ_widget:=$vJ_widget#Null:C1517 ? $vJ_widget : sem__storage_widgets().j_cards
$vR_ratio:=$vJ_widget.r_ratio  // w/h
$vR_scale:=$vJ_widget.r_scale
$vR_radius:=$vJ_widget.r_radius
$vL_curve:=$vJ_widget.l_curve  //6
$vL_cards_curve:=$vJ_widget.l_cards_curve  //10
$vL_type:=$vJ_widget.l_type
$vT_font_face:=wox_font_face_get($vJ_widget)

$vJ_pattern:=$vJ_widget.j_pattern
$vL_opacity:=$vJ_pattern.l_opacity
$vL_pattern:=$vJ_pattern.l_pattern
$vL_stroke:=$vJ_pattern.l_stroke
$vL_rxy:=$vJ_pattern.l_rxy
// *
// *****

$vL_svg_scale:=waz__storage_prefs.l_svg_scale
$vL_stroke*=$vL_svg_scale
$vL_rxy*=$vL_svg_scale
$vL_stroke_D2:=$vL_stroke/2

// *****
// *
$vT_svg_root:=SVG_New($vL_width; $vL_height)  // Vrai -> viewbox de même taille que le document
SVG_SET_TRANSFORM_SCALE($vT_svg_root; 1; 1)
SVG_SET_ID($vT_svg_root; "root")  // afin d'avoir accès à la viewBox pour la modifier plus tard
//woc_sp_colors_to_svg($vL_wheel_colors; ->$vT_wheel_stroke; ->$vT_wheel_fill)
//$vL_stroke_D2:=$vL_stroke/2
//$vT_svg_object:=SVG_New_rect($vT_svg_root; $vL_stroke_D2; $vL_stroke_D2; $vL_width-$vL_stroke; $vL_height-$vL_stroke; 0; 0; $vT_wheel_stroke; $vT_wheel_fill; 0)
// *
// *****

If ($vC_aj_cards#Null:C1517)
	
	// ***** Dimensions
	// *
	$tt_cards:=$vC_aj_cards.length
	$vR_coef:=wox_math_curves($vR_coef; $vL_curve)  // 0-12
	
	//$vL_size:=$vL_height/2
	//$vL_size_D4:=$vL_size/4
	$vL_size_D8:=$vL_type#0 ? $vL_height/8 : 0
	
	$vL_padding_x:=$vL_width*0.002
	$vL_padding_y:=0
	$vL_padding_x2:=$vL_padding_x*2
	$vL_padding_y2:=$vL_size_D8
	$vL_card_height:=($vL_height-$vL_padding_y2)*$vR_coef
	$vL_cards_width:=$vL_width-$vL_padding_x2
	$vL_card_width:=$vL_cards_width/$tt_cards
	$vL_card_width:=wox_min($vL_card_width; $vL_card_height*$vR_ratio)
	$vL_card_height:=$vL_card_width/$vR_ratio
	$vL_cards_width:=($vL_card_width+$vL_padding_x)*$tt_cards
	$vL_x_left:=$vL_padding_x+(($vL_width-$vL_cards_width)/2)
	
	//$vL_card_height:=$vL_height*$vR_scale
	$vL_card_top:=$vL_height-$vL_card_height-$vL_padding_y2
	$vL_card_width_D2:=$vL_card_width/2
	$vL_radius:=$vL_width*$vR_radius
	// *
	// *****
	
	$idx:=0
	For each ($vJ_card; $vC_aj_cards)
		$is_selected:=$idx=$vL_value
		$x:=$vL_x_left+(($vL_cards_width)*$idx/$tt_cards)+$vL_card_width_D2
		//$vL_mouseX:=300
		$vR_card_scale:=$vR_scale
		If ($vL_mouseX>0)
			//$vL_distance:=Square root((($vL_mouseX-$x)^2)+(($vL_mouseY-$vL_card_height)^2))
			//$vL_distance:=Square root((($vL_mouseX-$x)^2))
			$vL_distance:=Abs:C99($vL_mouseX-$x)
			If ($vL_distance<$vL_radius)  // Coef $vR_scale to 1
				$vR_card_coef:=1-($vL_distance/$vL_radius)
				$vR_card_coef:=wox_math_curves($vR_card_coef; $vL_cards_curve)
				$vR_card_coef:=$vR_card_coef*$vR_coef
				$vR_card_scale:=$vR_scale+($vR_card_coef*(1-$vR_scale))
			End if 
		End if 
		
		// ***** Card
		// *
		$vL_colors:=$vJ_card.l_colors
		$is_inverse:=True:C214
		$vL_colors:=woc_sp_colors_inverse($vL_colors; $is_inverse)
		woc_sp_colors_to_svg($vL_colors; ->$vT_patt_stroke; ->$vT_patt_fill)
		$vT_patt_name:="card_patt"+String:C10($idx)
		woc_svg_patterns($vT_svg_root; $vT_patt_name; $vL_pattern; $vT_patt_stroke; $vT_patt_fill)
		woc_sp_colors_to_svg($vL_colors; ->$vT_dot_stroke; ->$vT_dot_fill)
		
		$vT_svg_group:=SVG_New_group($vT_svg_root)
		SVG_SET_ID($vT_svg_group; "card_"+String:C10($idx))
		$vL_w:=$vL_card_width*$vR_card_scale  //*$vR_card_scale
		$vL_h:=$vL_card_height*$vR_card_scale
		Case of 
			: ($vL_type=1)  // Circle
				$x1:=$x-($vL_w/2)  //-(($vL_w-$vL_card_width)/2)
				$y1:=$vL_height-($vL_h/2)  //-($vL_h-$vL_card_height)
				$vT_object:=SVG_New_circle($vT_svg_group; $x; $y1; $vL_w; $vT_dot_stroke; "url(#"+$vT_patt_name+")"; $vL_stroke)
				
			: ($vL_type=2)  // Rectangle
				$x1:=$x-($vL_w/2)  //-(($vL_w-$vL_card_width)/2)
				$y1:=$vL_height-$vL_h  //-($vL_h-$vL_card_height)
				$vT_object:=SVG_New_rect($vT_svg_group; $x1; $y1; $vL_w-$vL_padding; $vL_h-$vL_padding; $vL_rxy; $vL_rxy; $vT_dot_stroke; "url(#"+$vT_patt_name+")"; $vL_stroke)
				
			Else   // Icon
				$vO_icon:=$vJ_card.o_icon
				CREATE THUMBNAIL:C679($vO_icon; $vO_icon; $vL_w; $vL_h; Scaled to fit prop centered:K6:6)
				$x1:=$x-($vL_w/2)  //-(($vL_w-$vL_card_width)/2)
				$y1:=$vL_height-$vL_h  //-($vL_h-$vL_card_height)
				$vT_object:=SVG_New_embedded_image($vT_svg_group; $vO_icon; $x1; $y1)
				
		End case 
		
		// ***** Number dot
		// *
		$vL_size:=$vL_card_height/4*$vR_card_scale
		$vL_size_txt:=$vL_size*0.7
		$vL_size_D2:=$vL_size/2
		$vL_size_D4:=$vL_size/4
		$vL_offset:=$vL_size_txt*0.7
		If ($vL_type#0)
			If (False:C215)
				$x2:=$x1+$vL_size_D4
				$y2:=$y1+$vL_size_D4
				//$vL_size1:=$vL_size*$vR_card_scale
				$vT_object:=SVG_New_circle($vT_svg_group; $x2; $y2; $vL_size_D2; $vT_dot_stroke; $vT_dot_fill; $vL_svg_scale)
				$vT_idText:=SVG_New_text($vT_svg_group; String:C10($idx+1); $x2; $y2-$vL_offset; $vT_font_face; $vL_size_txt; Bold:K14:2; 3; $vT_dot_stroke)
				SVG_SET_TEXT_RENDERING($vT_idText; "geometricPrecision")
			Else 
				$vO_icon:=$vJ_card.o_icon
				CREATE THUMBNAIL:C679($vO_icon; $vO_icon; $vL_size; $vL_size; Scaled to fit prop centered:K6:6)
				$x2:=$x1-$vL_size_D4
				$y2:=$y1-$vL_size_D4
				$vT_object:=SVG_New_embedded_image($vT_svg_group; $vO_icon; $x2; $y2)
			End if 
		End if 
		
		// ***** Selected
		// *
		If ($is_selected)
			//$vL_size1*=0.8
			//$x2:=$x
			//$y2:=$y1+($vL_h/2)
			//$vL_size:=$vL_size/2
			//$vL_size_D2:=$vL_size/2
			$x2:=$x1+$vL_w-$vL_size_D2  //-(($vL_w-$vL_card_width)/2)
			$y2:=$vL_height-$vL_size_D2  //-($vL_h-$vL_card_height)
			
			$vL_colors:=0xF437  // [md:244] – [md:55]
			woc_sp_colors_to_svg($vL_colors; ->$vT_sel_stroke; ->$vT_sel_fill)
			$vT_object:=SVG_New_circle($vT_svg_group; $x2; $y2; $vL_size_D2; $vT_sel_stroke; $vT_sel_fill; 2*$vL_svg_scale)
			$vT_idText:=SVG_New_text($vT_svg_group; "✓"; $x2; $y2-$vL_offset; $vT_font_face; $vL_size_txt; Bold:K14:2; 3; $vT_sel_stroke)
			SVG_SET_TEXT_RENDERING($vT_idText; "geometricPrecision")
		End if 
		$idx+=1
	End for each 
	
End if 


// ***** OUTPUT
// *
$vO_canvas:=SVG_Export_to_picture($vT_svg_root; Get XML data source:K45:16)
SVG_CLEAR($vT_svg_root)

