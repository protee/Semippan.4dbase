//%attributes = {"lang":"en"}

#DECLARE($vL_width : Integer; $vL_height : Integer; $vJ_widget : Object)->$vO_canvas : Picture
var $is_txt_direct; $is_links_color_stroke; $is_pro_app; $is_pro_color_stroke; $isOk; $is_selected : Boolean
var $is_horto_border; $is_last_product; $is_product; $is_break; $is_draw; $is_last : Boolean
var $is_links; $is_contract; $is_text_center : Boolean
var $vC_links : Collection
var $vL_modules_stroke; $vL_modules_opacity; $vL_links_dash; $vL_center_x; $vL_center_y; $vL_max_length; $vL_font_size; $vL_tampon1_hand_length; $vL_tampon_modules; $vL_tampon2_hand_length; $vL_aspects_lenght; $vL_tampon0_hand_length; $idx_slokas; $vL_wheel_stroke; $vL_font_style; $vL_wheel_colors; $vL_stroke; $x1; $x3; $vL_align; $vL_size; $vL_arrow_dimmed_size; $vL_arrow_size; $vL_name_size; $vL_offset : Integer
var $vL_align_left; $vL_align_right; $vL_align1; $vL_align2; $vL_wh1; $vL_wh1_D2; $vL_wh2_D2; $vL_wh2_D2_text : Integer
var $vL_angle_start; $vL_angle_end; $vL_wh_D4; $vL_wh2_D4 : Integer
var $vL_links_opacity; $vL_value; $vL_radius; $vL_horto_opacity; $vL_count; $idx_slokas_last : Integer
var $vL_tt_sargah1; $vL_w; $vL_h; $vL_wh; $vL_curve; $tt : Integer
var $vL_links_stroke; $vL_stroke_D2; $vL_tt_sargah; $vL_label_size; $vL_wh_D2; $vL_opacity : Integer
var $vL_svg_scale; $vL_icon_wh; $vL_tampon3_hand_length; $x4; $vL_colors; $idx : Integer
var $vJ_veda_prefs; $vJ_links : Object
var $vR_font_coef; $vR_arrow_dimmed_coef; $vR_arrow_coef; $vR_angle_global; $vR_angle_start; $vR_angle_end; $vR_angle_rotation; $vR_angle : Real
var $vR_angle_active; $vR_angle_1; $vR_angle_2 : Real
var $vR_angle_diff; $vR_angle_last; $vR_angle2; $vR_angle_diff2 : Real
var $vR_angle_step; $vR_img_coef; $vR_img_selected_coef; $vR_txt_selected_coef : Real
var $vR_icons_coef; $vR_angle_step_S2; $vR_wheel_coef; $vR_angle_range; $vR_progress; $vR_angle1 : Real
var $vT_base_name; $vT_font_face; $vT_svg_root; $vT_color_none; $vT_svg_object; $vT_svg_group; $vT_idText : Text
var $vT_product; $vT_product_stroke; $vT_product_fill; $vT_app; $vT_app1 : Text
var $vT_wheel_stroke; $vT_wheel_fill; $vT_KAVIYAM_stroke; $vT_KAVIYAM_fill; $vT_color; $vT_color_last : Text
var $cES_SLOKAS : cs:C1710.SLOKASSelection
var $cE_KAVIYAM : cs:C1710.KAVIYAMEntity
var $cE_SLOKAS; $cE_SLOKAS1 : cs:C1710.SLOKASEntity
var $cE_PRODUCTS; $cE_PRODUCTS1 : cs:C1710.PRODUCTSEntity
var $vO_product : Picture


// *****
// *
$vJ_veda_prefs:=$vJ_widget.j_prefs
$vJ_veda_prefs:=$vJ_veda_prefs#Null:C1517 ? $vJ_veda_prefs : app__storage_widgets().j_veda_prefs.j_value

$vL_wheel_colors:=$vJ_veda_prefs.l_wheel_colors
$vL_wheel_stroke:=$vJ_veda_prefs.l_wheel_stroke
$vL_links_stroke:=$vJ_veda_prefs.l_links_stroke
$vL_links_dash:=$vJ_veda_prefs.l_links_dash
$vL_links_opacity:=$vJ_veda_prefs.l_links_opacity
$vL_horto_opacity:=$vJ_veda_prefs.l_horto_opacity
$vR_wheel_coef:=$vJ_veda_prefs.r_wheel_coef
$vR_icons_coef:=$vJ_veda_prefs.r_icons_coef
$vL_curve:=$vJ_veda_prefs.l_curve
$is_horto_border:=$vJ_veda_prefs.is_border
$vL_angle_start:=$vJ_veda_prefs.l_angle_start
$vL_angle_end:=$vJ_veda_prefs.l_angle_end
$is_text_center:=$vJ_veda_prefs.is_text_center

$vL_modules_opacity:=70
$is_pro_app:=False:C215
$is_pro_color_stroke:=False:C215
$is_links_color_stroke:=False:C215

$is_links:=$vJ_widget.is_links
$vL_value:=$vJ_widget.l_value
$vR_progress:=$vJ_widget.r_progress
$is_contract:=$vJ_widget.is_contract
$vR_progress:=wox_math_curves($vR_progress; $vL_curve; $is_contract)

$vL_svg_scale:=waz__storage_prefs.l_svg_scale
$vL_wheel_stroke*=$vL_svg_scale
$vL_links_stroke*=$vL_svg_scale
$vL_links_dash*=$vL_svg_scale
//$vR_wheel_coef*=$vR_progress
$vR_icons_coef:=$vR_icons_coef*$vR_wheel_coef
$vR_font_coef:=1  //$vJ_widget.r_font_coef
$vR_arrow_coef:=1  //$vJ_widget.r_arrow_coef

// *
// *****


// *****
// *
woc_sp_colors_to_svg($vL_wheel_colors; ->$vT_wheel_stroke; ->$vT_wheel_fill)
$vL_stroke_D2:=$vL_stroke/2
$vT_svg_root:=SVG_New($vL_width; $vL_height)  // Vrai -> viewbox de même taille que le document
SVG_SET_TRANSFORM_SCALE($vT_svg_root; 1; 1)
SVG_SET_ID($vT_svg_root; "root")  // afin d'avoir accès à la viewBox pour la modifier plus tard
$vT_svg_object:=SVG_New_rect($vT_svg_root; $vL_stroke_D2; $vL_stroke_D2; $vL_width-$vL_stroke; $vL_height-$vL_stroke; 0; 0; $vT_wheel_stroke; $vT_wheel_fill; 0)
// *
// *****

$cE_KAVIYAM:=$vJ_widget.cE_KAVIYAM
$cES_SLOKAS:=$vJ_widget.cES_SLOKAS
If ($cE_KAVIYAM#Null:C1517) && ($cES_SLOKAS#Null:C1517)
	
	$vT_base_name:=$cE_KAVIYAM.tag
	$vT_font_face:="Calibri"  //x_get_font_face($vJ_widget)
	$vL_icon_wh:=64
	
	// ***** Dimensions
	// *
	$vL_center_x:=$vL_width/2
	$vL_center_y:=$vL_height/2
	$vL_max_length:=((wox_min($vL_width; $vL_height)/2))*95/100
	$vL_font_size:=$vL_max_length*0.06*$vR_font_coef
	
	$vL_tampon1_hand_length:=$vL_max_length*$vR_wheel_coef  // Aspects
	$vL_tampon2_hand_length:=$vL_max_length*($vR_wheel_coef+0.05)
	$vL_tampon3_hand_length:=$vL_tampon2_hand_length+$vL_icon_wh+($vL_icon_wh/4)  //+$vL_icon_wh_D2
	$vL_tampon_modules:=$vL_tampon1_hand_length+($vL_stroke/2)
	
	$vL_aspects_lenght:=$vL_tampon1_hand_length
	$vL_tampon0_hand_length:=$vL_tampon1_hand_length+($vL_modules_stroke/2)
	// *
	// *****
	
	
	// *****
	// *
	$vR_angle_start:=-$vL_angle_start*Degree:K30:2
	$vR_angle_end:=-$vL_angle_end*Degree:K30:2
	$vL_tt_sargah:=$cES_SLOKAS.length
	$vL_tt_sargah1:=$vL_tt_sargah-1
	//$vR_angle_step:=k_two_pi/$vL_tt_sargah1
	$vR_angle_global:=Pi:K30:1
	//$vR_angle_active:=Pi*3/2
	$vR_angle_active:=-($vR_angle_end-$vR_angle_start)
	$vR_angle_step:=$vR_angle_active/$vL_tt_sargah1
	$vR_angle_step_S2:=$vR_angle_step/2
	//$vR_angle_start:=$vR_angle_active/2  //-$vR_angle_step_S2
	
	//$vR_angle_range:=$vR_angle_step*$vL_tt_sargah*$vR_progress
	$vR_angle_range:=$vR_angle_step*$vL_tt_sargah*$vR_progress
	
	$vT_color_none:="none"
	
	// ***** MODULES
	// *
	$vR_angle:=Pi:K30:1/10
	$vR_angle_1:=90-(($vR_angle_global-$vR_angle)*Radian:K30:3)
	$vR_angle_2:=90-(($vR_angle_global+$vR_angle)*Radian:K30:3)+360
	$vT_svg_group:=SVG_New_arc($vT_svg_root; $vL_center_x; $vL_center_y; $vL_tampon0_hand_length; $vR_angle_1; $vR_angle_2; $vT_wheel_stroke; $vT_color_none; $vL_wheel_stroke)
	SVG_SET_OPACITY($vT_svg_group; $vL_modules_opacity; $vL_modules_opacity)
	
	// ***** TITLE
	// *
	woc_sp_colors_to_svg($cE_KAVIYAM.colors; ->$vT_KAVIYAM_stroke; ->$vT_KAVIYAM_fill)
	$vL_font_style:=1
	$vL_label_size:=$vL_font_size*4*$vR_wheel_coef
	$vL_offset:=$vL_label_size*k_fontOffset_coef
	
	$vR_angle_rotation:=($vR_angle_global*Radian:K30:3)+360%360
	$is_txt_direct:=($vR_angle_rotation<90) || ($vR_angle_rotation>270)
	If ($is_txt_direct)
		$x4:=$vL_center_x+$vL_tampon0_hand_length
	Else 
		$x4:=$vL_center_x-$vL_tampon0_hand_length
		$vR_angle_rotation:=180+$vR_angle_rotation
	End if 
	$vL_align:=3
	$vT_svg_group:=SVG_New_group($vT_svg_root)
	$vT_idText:=SVG_New_text($vT_svg_group; $vT_base_name; $x4; $vL_center_y-$vL_offset; $vT_font_face; $vL_label_size; $vL_font_style; $vL_align; $vT_KAVIYAM_stroke)
	SVG_SET_TEXT_RENDERING($vT_idText; "geometricPrecision")
	SVG_SET_TRANSFORM_ROTATE($vT_svg_group; $vR_angle_rotation; $vL_center_x; $vL_center_y)
	// *
	// *****
	
	
	// ***** PRESET VALUES
	// *
	$vL_size:=$vL_tampon1_hand_length/40
	$vL_arrow_dimmed_size:=$vL_size*$vR_arrow_dimmed_coef
	$vL_arrow_size:=$vL_size*$vR_arrow_coef
	// *
	// *****
	
	
	// ***** PRODUCTS HORTO DRAWING
	// *
	If ($is_links)
		$vL_stroke:=$vL_svg_scale  // 1
		$is_last_product:=False:C215
		$vL_count:=0
		$idx_slokas_last:=$cES_SLOKAS.length-1
		$idx_slokas:=0
		For each ($cE_SLOKAS; $cES_SLOKAS)
			//$is_selected:=$vL_value=$idx_slokas
			$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
			$vL_colors:=$cE_SLOKAS.colors
			$is_product:=$cE_PRODUCTS#Null:C1517
			$is_pro_color_stroke:=Not:C34($is_product)
			If ($is_product)
				$vL_colors:=$vL_colors#0 ? $vL_colors : $cE_PRODUCTS.colors
				$vL_count+=1
			Else 
				$is_break:=$vL_count=1
				$vL_count:=0
			End if 
			
			woc_sp_colors_to_svg($vL_colors; ->$vT_product_stroke; ->$vT_product_fill)
			$vT_color:=$is_pro_color_stroke ? $vT_product_stroke : $vT_product_fill
			// *****
			// *
			$vR_angle_diff:=$vR_angle_range*$idx_slokas/$vL_tt_sargah
			//$vR_angle:=$vR_angle_global-$vR_angle_step-$vR_angle_diff
			$vR_angle:=$vR_angle_start-$vR_angle_diff
			
			$is_draw:=($is_product && $is_last_product)
			If ($is_draw)
				//$is_draw:=False
				$vR_angle1:=$vR_angle_last
				$vR_angle2:=$vR_angle
			Else 
				$is_last:=$idx_slokas=$idx_slokas_last
				$is_draw:=(($vL_count=1) && $is_last_product) || ($is_last) || $is_break
				
				If ($is_draw)
					$vR_angle_diff2:=$vR_angle_step_S2*$vR_progress
					If ($is_last)
						$vT_color:=$vT_color
						$vR_angle1:=$vR_angle-$vR_angle_diff2
						$vR_angle2:=$vR_angle+$vR_angle_diff2
					Else 
						$vT_color:=$vT_color_last
						$vR_angle1:=$vR_angle_last-$vR_angle_diff2
						$vR_angle2:=$vR_angle_last+$vR_angle_diff2
					End if 
				End if 
			End if 
			
			If ($is_draw)
				$vT_color:=$is_links_color_stroke ? $vT_product_stroke : $vT_product_fill
				//$vT_svg_object:=woc_svg_circleArcTangent($vT_svg_root; $vL_center_x; $vL_center_y; $vL_aspects_lenght; $vR_angle1; $vR_angle; $vT_color; $vL_links_stroke; $vL_links_dash; $vL_arrow_size)
				$vT_svg_object:=woc_svg_circleFillHorto($vT_svg_root; $vL_center_x; $vL_center_y; $vL_aspects_lenght; $vR_angle1; $vR_angle2; $vT_color; $vT_color; $vL_links_stroke; $is_horto_border)
				SVG_SET_OPACITY($vT_svg_object; $vL_horto_opacity)
			End if 
			
			$vT_color_last:=$vT_color
			$is_last_product:=$is_product
			$vR_angle_last:=$vR_angle
			$idx_slokas+=1
		End for each 
	End if 
	
	
	// ***** LINKS ONE
	// *
	If ($vL_links_stroke#0) && ($is_links)
		$vJ_links:=$vJ_widget.j_links
		If ($vJ_links#Null:C1517)
			$tt:=$cES_SLOKAS.length
			$idx_slokas:=0
			For each ($cE_SLOKAS; $cES_SLOKAS)
				$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
				If ($cE_PRODUCTS#Null:C1517)
					$vT_app:=$cE_PRODUCTS.app
					$vC_links:=$vJ_links[$vT_app]
					$vR_angle:=$vR_angle_start-($vR_angle_range*$idx_slokas/$vL_tt_sargah)
					
					For ($idx; 0; $tt-1)  // $idx_slokas)
						$cE_SLOKAS1:=$cES_SLOKAS[$idx]
						$cE_PRODUCTS1:=$cE_SLOKAS1.SLOKAS_PRODUCTS
						$vT_app1:=$cE_PRODUCTS1.app
						$isOk:=$vC_links#Null:C1517
						If ($isOk)
							$isOk:=$vC_links.indexOf($vT_app1)>=0
							If ($isOk)
								// *****
								// *
								//$vR_angle1:=$vR_angle_global-$vR_angle_step-($vR_angle_range*$idx/$vL_tt_sargah)
								//$vR_angle:=$vR_angle_start-$vR_angle_diff
								$vR_angle1:=$vR_angle_start-($vR_angle_range*$idx/$vL_tt_sargah)
								//$vL_colors:=$cE_PRODUCTS1.colors
								$vL_colors:=$cE_SLOKAS1.colors
								$vL_colors:=$vL_colors#0 ? $vL_colors : $cE_PRODUCTS1.colors
								woc_sp_colors_to_svg($vL_colors; ->$vT_product_stroke; ->$vT_product_fill)
								$vT_color:=$is_links_color_stroke ? $vT_product_stroke : $vT_product_fill
								//$vT_svg_object:=woc_svg_circleArcTangent($vT_svg_root; $vL_center_x; $vL_center_y; $vL_aspects_lenght; $vR_angle1; $vR_angle; $vT_color; $vL_links_stroke; $vL_links_dash; $vL_arrow_size)
								$vT_svg_object:=woc_svg_circleArcHorto($vT_svg_root; $vL_center_x; $vL_center_y; $vL_aspects_lenght; $vR_angle; $vR_angle1; $vT_color; $vL_links_stroke; $vL_links_dash; $vL_arrow_size)
								SVG_SET_ID($vT_svg_object; "link_"+String:C10($idx_slokas; "00")+String:C10($idx; "00"))
								SVG_SET_OPACITY($vT_svg_object; $vL_links_opacity)
							End if 
						End if 
					End for 
				End if 
				$idx_slokas+=1
			End for each 
		End if 
	End if 
	
	
	// ***** PRODUCTS 
	// *
	$vR_img_selected_coef:=1.4  //1.8
	$vR_txt_selected_coef:=1.2
	$vL_stroke:=$vL_svg_scale  // 1
	
	//$vR_icons_coef*=2
	$vL_name_size:=$vL_font_size*2*$vR_icons_coef
	
	$vL_font_style:=0
	$idx_slokas:=0
	For each ($cE_SLOKAS; $cES_SLOKAS)
		//$is_selected:=$vL_value=$idx_slokas
		$vL_radius:=$vL_tampon1_hand_length*$vR_progress
		$is_selected:=$vL_value ?? $idx_slokas
		If ($is_selected)
			$vR_img_coef:=$vR_icons_coef*$vR_img_selected_coef
			$vL_label_size:=$vL_name_size*$vR_txt_selected_coef
		Else 
			$vR_img_coef:=$vR_icons_coef
			$vL_label_size:=$vL_name_size
		End if 
		$vL_offset:=$vL_label_size*k_fontOffset_coef
		$cE_PRODUCTS:=$cE_SLOKAS.SLOKAS_PRODUCTS
		$vL_colors:=$cE_SLOKAS.colors
		$is_product:=$cE_PRODUCTS#Null:C1517
		$is_pro_color_stroke:=Not:C34($is_product)
		If ($is_product)
			$vT_product:=$is_pro_app ? $cE_PRODUCTS.app : $cE_PRODUCTS.label
			$vL_colors:=$vL_colors#0 ? $vL_colors : $cE_PRODUCTS.colors
			$vO_product:=$cE_PRODUCTS.logo
			//$vL_font_style:=0
		Else 
			$vT_product:=$cE_SLOKAS.label
			//$vL_colors:=$cE_SLOKAS.colors
			$vO_product:=$cE_SLOKAS.logo
			//$vL_font_style:=Bold
			//$vR_img_coef:=$vR_img_coef*0.75
		End if 
		$vL_font_style:=Num:C11($is_selected)
		woc_sp_colors_to_svg($vL_colors; ->$vT_product_stroke; ->$vT_product_fill)
		$vT_color:=$is_pro_color_stroke ? $vT_product_stroke : $vT_product_fill
		PICTURE PROPERTIES:C457($vO_product; $vL_w; $vL_h)
		$vL_wh:=wox_min($vL_w; $vL_h)
		$vL_wh*=$vR_img_coef
		$vL_wh1:=$vL_wh
		$vL_wh_D2:=$vL_wh/2
		$vL_wh_D4:=$vL_wh/4
		CREATE THUMBNAIL:C679($vO_product; $vO_product; $vL_wh; $vL_wh; Scaled to fit prop centered:K6:6)
		// *****
		// *
		$vL_align_left:=2
		$vL_align_right:=4
		$vR_angle:=$vR_angle_start-($vR_angle_range*$idx_slokas/$vL_tt_sargah)
		$vR_angle_rotation:=$vR_angle*Radian:K30:3+360%360
		$is_txt_direct:=($vR_angle_rotation<90) || ($vR_angle_rotation>270)
		If ($is_txt_direct)
			$vL_align1:=$vL_align_right
			$vL_align2:=$vL_align_left
			$vL_wh1_D2:=$vL_wh1/2
		Else 
			$vR_angle_rotation:=180+$vR_angle_rotation
			$vL_align1:=$vL_align_left
			$vL_align2:=$vL_align_right
			$vL_radius:=-$vL_radius
			$vL_wh1:=-$vL_wh1
			$vL_wh1_D2:=0
		End if 
		$vL_wh2_D2:=$vL_wh1/2
		$vL_wh2_D4:=$vL_wh1/4
		$vL_wh2_D2_text:=$vL_wh2_D2*1.2
		//$vL_wh2_D4_text:=$vL_wh2_D2*1.2
		
		$x1:=$vL_center_x+$vL_radius
		$x3:=$x1-$vL_wh_D2
		If ($is_text_center)
			$vL_align:=$vL_align1
			$x4:=$x1-$vL_wh2_D2_text
			If ($is_selected)
				$x3:=$x3+$vL_wh2_D4
				$x4:=$x4+$vL_wh2_D4
			End if 
		Else 
			$vL_align:=$vL_align2
			$x4:=$x1+$vL_wh2_D2_text
			If ($is_selected)
				$x3:=$x3-$vL_wh2_D4
				$x4:=$x4-$vL_wh2_D4
			End if 
		End if 
		
		$vT_svg_group:=SVG_New_group($vT_svg_root)
		SVG_SET_ID($vT_svg_group; "idx_"+String:C10($idx_slokas))
		$vT_svg_object:=SVG_New_embedded_image($vT_svg_group; $vO_product; $x3; $vL_center_y-$vL_wh_D2)
		$vT_idText:=SVG_New_text($vT_svg_group; $vT_product; $x4; $vL_center_y-$vL_offset; $vT_font_face; $vL_label_size; $vL_font_style; $vL_align; $vT_color)
		$vL_opacity:=wox_math_max(0; $vR_progress*100)
		SVG_SET_OPACITY($vT_idText; $vL_opacity; $vL_opacity)
		
		SVG_SET_TEXT_RENDERING($vT_idText; "geometricPrecision")
		SVG_SET_TRANSFORM_ROTATE($vT_svg_group; $vR_angle_rotation; $vL_center_x; $vL_center_y)
		$idx_slokas+=1
	End for each 
	
End if 


// ***** OUTPUT
// *
$vO_canvas:=SVG_Export_to_picture($vT_svg_root; Get XML data source:K45:16)
SVG_CLEAR($vT_svg_root)

