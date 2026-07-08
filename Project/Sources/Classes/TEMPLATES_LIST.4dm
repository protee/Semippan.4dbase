
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	// Init LB
	Super:C1705($vT_LB)
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	Super:C1706.lb_initialize($vJ_data; $is_local)  // Init LB
	var $vT_LB : Text
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		This:C1470.lb_meta_info_set()
	End if 
	
	
Function lb_meta_info($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vJ_meta : Object
	//$vJ_meta:=New object
	//var $vL_colors; $vL_color_lines; $vL_color_bkg : Integer
	//var $vJ_fields : Object
	//var $vT_color_stroke; $vT_color_fill : Text
	//$vJ_fields:=$cE_TEMPLATES.fields
	//$vL_color_lines:=$vJ_fields.l_lines
	//$vL_color_bkg:=$vJ_fields.l_bkg
	//$vL_colors:=woc_sp_colors_from_sf($vL_color_lines; $vL_color_bkg)
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta.stroke:=$vT_color_stroke
	//$vJ_meta.fill:=$vT_color_fill
	
	// For cell
	//var $vJ_meta_cell : Object
	//$vJ_meta_cell:=New object
	//$vJ_meta.cell:=$vJ_meta_cell
	
	//var $vJ_meta_cell_values : Object
	//$vJ_meta_cell_values:=New object
	//$vJ_meta_cell.Column13:=$vJ_meta_cell_values // Issue => give the column name that can change
	//$vL_colors:=($c4E_entity.Pseudo#"") ? k_MDcolorsAppSecondary : k_MDcolorsBW
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta_cell_values.stroke:=$vT_color_stroke
	//$vJ_meta_cell_values.fill:=$vT_color_fill
	
Function lb_shape_img($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_img : Picture
	var $vL_shape; $vL_size; $vL_colors : Integer
	$vL_shape:=$cE_TEMPLATES.shape
	$vL_size:=18
	$vL_colors:=0x3634  // Mode Shape
	$vO_img:=woc_sp_shape_icn($vL_size; $vL_size; $vL_colors; $vL_shape; 3)
	
	
Function lb_colors_in_img($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_img : Picture
	var $vL_colors; $vL_size : Integer
	var $vL_shape : Integer
	$vL_colors:=$cE_TEMPLATES.colors_in
	$vL_shape:=app__storage_prefs().l_display_shape
	$vL_size:=30
	$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors; $vL_shape; 3)
	
	
Function lb_colors_main_img($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_img : Picture
	var $vL_colors; $vL_size : Integer
	var $vL_shape : Integer
	$vL_colors:=$cE_TEMPLATES.j_dcox.l_main
	$vL_shape:=app__storage_prefs().l_display_shape
	$vL_size:=30
	$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors; $vL_shape; 3)
	
	
Function lb_default_icon($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_icon($cE_TEMPLATES; "default")
Function lb_click_icon($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_icon($cE_TEMPLATES; "click")
Function lb_over_icon($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_icon($cE_TEMPLATES; "over")
Function lb_disabled_icon($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_icon($cE_TEMPLATES; "disabled")
	
Function lb_dcox_icon($cE_TEMPLATES : cs:C1710.TEMPLATESEntity; $vT_bind : Text)->$vO_img : Picture
	var $vL_colors_in; $vL_colors_main; $vL_colors_out; $vL_shape; $vL_size; $vL_enablers : Integer
	var $vJ_dcox; $vJ_bind : Object
	$vL_colors_in:=$cE_TEMPLATES.colors_in
	$vJ_dcox:=$cE_TEMPLATES.j_dcox
	$vL_colors_main:=$vJ_dcox.l_main
	$vJ_bind:=$vJ_dcox["j_"+$vT_bind]
	$vL_colors_out:=woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind; $vL_colors_in)
	$vL_enablers:=woc_dcoxWidget_get_enablers($vJ_bind)
	$vL_shape:=app__storage_prefs().l_display_shape
	$vL_size:=26
	$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors_out; $vL_shape; $vL_enablers)
	
	
Function lb_default_img($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_x_img($cE_TEMPLATES; "default")
	
	
Function lb_click_img($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_x_img($cE_TEMPLATES; "click")
	
	
Function lb_over_img($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_x_img($cE_TEMPLATES; "over")
	
	
Function lb_disabled_img($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_x_img($cE_TEMPLATES; "disabled")
	
	
Function lb_dcox_x_img($cE_TEMPLATES : cs:C1710.TEMPLATESEntity; $vT_bind : Text)->$vO_img : Picture
	var $vL_colors_in; $vL_colors_main; $vL_colors_out; $vL_shape; $vL_size : Integer
	var $vL_rxy; $vL_color_fill; $vL_colors; $vL_stroke : Integer
	var $vJ_dcox; $vJ_bind : Object
	var $c4Fi_icon : 4D:C1709.File
	var $is_whiteFor : Boolean
	var $vO_icon : Picture
	var $vR_coef : Real
	var $vT_wb : Text
	$vL_colors_in:=$cE_TEMPLATES.colors_in
	$vJ_dcox:=$cE_TEMPLATES.j_dcox
	$vL_colors_main:=$vJ_dcox.l_main
	$vJ_bind:=$vJ_dcox["j_"+$vT_bind]
	$vL_colors_out:=woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind; $vL_colors_in)
	
	$vL_shape:=$cE_TEMPLATES.shape
	$vL_stroke:=$cE_TEMPLATES.stroke
	$vL_size:=30
	$vL_rxy:=5
	$vR_coef:=1  //0.9
	$vL_color_fill:=woc_sp_colors_to_f($vL_colors)
	$is_whiteFor:=woc_sp_color_isWhiteFor($vL_colors)
	$vT_wb:=$is_whiteFor ? "w" : "b"
	$c4Fi_icon:=Folder:C1567(fk resources folder:K87:11).file("icons/icn_gesture_"+$vT_wb+".png")
	READ PICTURE FILE:C678($c4Fi_icon.platformPath; $vO_icon)
	$vO_img:=woc_picture_icon_img($vL_size; $vL_size; $vR_coef; $vL_rxy; $vL_rxy; $vL_rxy; $vL_rxy; $vL_stroke; $vL_shape; $vL_colors_out; $vO_icon)
	
	
Function lb_dcox_img($cE_TEMPLATES : cs:C1710.TEMPLATESEntity)->$vO_picture : Picture
	var $c4Fi_icon : 4D:C1709.File
	var $is_whiteFor : Boolean
	var $vC_at_bind : Collection
	var $vL_colors_in; $vL_colors_main; $idx; $vL_colors_out; $vL_shape; $vL_stroke; $vL_size; $vL_rxy; $vL_color_fill : Integer
	var $vJ_dcox; $vJ_bind : Object
	var $vO_icon; $vO_pict : Picture
	var $vR_coef : Real
	var $vT_bind; $vT_wb : Text
	$vL_colors_in:=$cE_TEMPLATES.colors_in
	$vJ_dcox:=$cE_TEMPLATES.j_dcox
	$vL_colors_main:=$vJ_dcox.l_main
	$vC_at_bind:=sem_get_at_dcox()
	$idx:=0
	For each ($vT_bind; $vC_at_bind)
		$vJ_bind:=$vJ_dcox["j_"+$vT_bind]
		If ($vJ_bind.l_stroke<2) || ($vJ_bind.l_fill<2)
			$vL_colors_out:=woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind; $vL_colors_in)
			
			$vL_shape:=$cE_TEMPLATES.shape
			$vL_stroke:=$cE_TEMPLATES.stroke
			$vL_size:=30
			$vL_rxy:=5
			$vR_coef:=1  //0.9
			If ($idx=0)
				$vL_color_fill:=woc_sp_colors_to_f($vL_colors_out)
				$is_whiteFor:=woc_sp_color_isWhiteFor($vL_color_fill)
				$vT_wb:=$is_whiteFor ? "w" : "b"
				$c4Fi_icon:=Folder:C1567(fk resources folder:K87:11).file("icons/icn_gesture_"+$vT_wb+".png")
				READ PICTURE FILE:C678($c4Fi_icon.platformPath; $vO_icon)
			End if 
			$vO_pict:=woc_picture_icon_img($vL_size; $vL_size; $vR_coef; $vL_rxy; $vL_rxy; $vL_rxy; $vL_rxy; $vL_stroke; $vL_shape; $vL_colors_out; $vO_icon)
			$vO_picture:=$idx=0 ? $vO_pict : $vO_picture+$vO_pict
			$idx+=1
		End if 
	End for each 
	
	