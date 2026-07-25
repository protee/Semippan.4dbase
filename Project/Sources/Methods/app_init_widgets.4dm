//%attributes = {"lang":"en"}

var $vJ_widgets; $vJ_widget; $vJ_value; $vJ_pattern : Object
$vJ_widgets:=New shared object:C1526
Use (Storage:C1525)
	Storage:C1525.j_widgets:=$vJ_widgets
End use 

Use ($vJ_widgets)
	
	// ***** sem_output – Output ; direct connexion to scalars
	// * scalars
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_output:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	$vJ_value:=New shared object:C1526()
	$vJ_widget.j_value:=$vJ_value  // No prefix as widget binded to record's fields
	$vJ_value.shape:=0  // l_shape
	$vJ_value.mime:=0  // l_mime
	$vJ_value.width:=30  // l_width
	$vJ_value.height:=30  // l_height
	$vJ_value.size:=100  // l_size %
	$vJ_value.stroke:=0  // l_stroke
	
	
	// ***** sem_picture – Picture properties
	// * j_value: value
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_picture:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	$vJ_value:=New shared object:C1526()
	$vJ_widget.j_value:=$vJ_value
	$vJ_value.l_size:=85  // %
	$vJ_value.l_br_default:=0  // Brightness
	$vJ_value.l_br_click:=0
	$vJ_value.l_br_over:=0
	$vJ_value.l_br_disabled:=0
	$vJ_value.is_greyDisabled:=True:C214
	$vJ_value.is_offsetClick:=True:C214
	$vJ_value.l_angle:=0
	
	
	// ***** sem_text – Text properties
	// * j_value: value
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_text:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	$vJ_value:=New shared object:C1526()
	$vJ_widget.j_value:=$vJ_value
	$vJ_value.t_face:=""
	$vJ_value.l_size:=70
	$vJ_value.l_color:=k_MD_black
	$vJ_value.l_style:=0
	$vJ_value.l_offsetX:=0
	$vJ_value.l_offsetY:=0
	
	
	// ***** sem_veda_prefs – Veda preferences
	// * j_value: value
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_veda_prefs:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	$vJ_widget.t_label:="Vēda prefs"
	
	$vJ_value:=New shared object:C1526()
	$vJ_widget.j_value:=$vJ_value
	$vJ_value.r_wheel_coef:=0.65  // Wheel coef
	$vJ_value.l_wheel_stroke:=6  // Wheel stroke
	$vJ_value.l_wheel_colors:=0x3306C1EA  // Wheel colors
	$vJ_value.l_angle_start:=-120  // Angle start
	$vJ_value.l_angle_end:=120  // Angle end
	$vJ_value.r_icons_coef:=1  // Icons coef
	$vJ_value.l_links_color:=0x00AB  // Links color
	$vJ_value.l_links_stroke:=2  // Links stroke
	$vJ_value.l_links_dash:=1  // Links dash
	$vJ_value.l_links_opacity:=60  // Links opacity
	$vJ_value.l_horto_opacity:=40  // Horto opacity
	$vJ_value.is_border:=False:C215  // Horto on border
	$vJ_value.l_curve:=4  // Curve for r_progress value
	
	
	// ***** sem_veda – Veda display 
	// * j_value: value
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_veda:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	$vJ_widget.t_label:="Vēda"  // Group
	$vJ_widget.r_progress:=1  // Progress coef
	$vJ_widget.is_links:=True:C214  // Display links
	
	$vJ_widget.j_prefs:=Null:C1517  // From sem_veda_prefs
	$vJ_widget.cE_KAVIYAM:=Null:C1517  // Record for Params
	$vJ_widget.cES_SLOKAS:=Null:C1517  // ES to Products
	
	
	// ***** sem_cards – Dock display 
	// * j_value: value
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_cards:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	$vJ_widget.r_ratio:=0.648  // CARD 59x91 mm
	$vJ_widget.r_scale:=0.6  // Scale coef
	$vJ_widget.r_radius:=0.25  // Radius based on width
	$vJ_widget.r_increment:=0.05  // Increment On Timer
	$vJ_widget.r_min:=0.7  // Coef [0.7-1]
	//$vL_curve:=wox_math_curve_idFromName("springPhysics")
	//$vL_curve:=wox_math_curve_idFromName("elasticOut")
	$vL_curve:=wox_math_curve_idFromName("expoIn")
	$vJ_widget.l_curve:=$vL_curve
	$vJ_widget.l_cards_curve:=$vL_curve
	$vJ_widget.l_type:=0  // Icons ; Circle ; Rect
	
	
	//$vJ_widget.l_opacity:=100  // Cards opacity
	//$vJ_widget.l_pattern:=12
	//$vJ_widget.l_stroke:=2
	
	$vJ_pattern:=New shared object:C1526()  // Default idle pattern
	$vJ_widget.j_pattern:=$vJ_pattern
	$vJ_pattern.l_pattern:=12
	$vJ_pattern.l_rxy:=4
	$vJ_pattern.l_stroke:=2
	$vJ_pattern.l_opacity:=85
	
	$vJ_widget.aj_cards:=Null:C1517  // Cards coll {t_text, l_colors, o_icon}
	
	
	// ***** sem_sloka – Sloka display 
	// * j_value: value
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_sloka:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	$vJ_pattern:=New shared object:C1526()  // Default idle pattern
	$vJ_widget.j_pattern:=$vJ_pattern
	$vJ_pattern.l_pattern:=12
	$vJ_pattern.l_rxy:=4
	$vJ_pattern.l_stroke:=2
	$vJ_pattern.l_opacity:=85
	
	// ***** sem_file – File chooser 
	// * j_value: value
	$vJ_widget:=New shared object:C1526
	$vJ_widgets.j_file:=$vJ_widget
	$vJ_widget.is_editing:=True:C214
	
	$vJ_widget.t_tip:=""
	
	
End use 

