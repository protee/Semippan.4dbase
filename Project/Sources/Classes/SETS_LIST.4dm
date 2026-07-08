
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	Super:C1706.lb_initialize($vJ_data; $is_local)  // Init LB
	var $vT_LB : Text
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		//This.lb_meta_info_set()
	End if 
	
Function lb_meta_info($c4E_entity : 4D:C1709.Entity)->$vJ_meta : Object
	//var $vL_colors : Integer
	//var $vT_color_stroke; $vT_color_fill : Text
	//$vJ_meta:=New object
	////$is_active:=$c4E_entity.isActive
	////$vL_colors:=woc_sp_colors_from_row($is_active ? k_MDcolorsIdx_lime : k_MDcolorsIdx_grey)
	//$vL_colors:=$c4E_entity.colors
	//If ($vL_colors=0)
	//$vL_colors:=$c4E_entity.FRAGMENTS_ORWELLS.colors
	//End if 
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta.stroke:=$vT_color_stroke
	//$vJ_meta.fill:=$vT_color_fill
	
	
	//Function lb_label($cE_sets : cs.SETSEntity)->$vT_answer : Text
	//var $vT_subPath : Text
	//$vT_subPath:=$cE_sets.subPath
	//$vT_answer:=($vT_subPath#"" ? $vT_subPath+" • " : "")+$cE_sets.fileStart
	////$vT_answer+=" • wh: "+String($cE_sets.width)+" "+String($cE_sets.height)
	//$vT_answer+=" • "+String($cE_sets.width)+"×"+String($cE_sets.height)
	
Function lb_wh($cE_SETS : cs:C1710.SETSEntity)->$vT_answer : Text
	$vT_answer:=String:C10($cE_SETS.width)+"×"+String:C10($cE_SETS.height)
	
	
Function lb_default_icon($cE_SETS : cs:C1710.SETSEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_icon($cE_SETS; "default")
Function lb_click_icon($cE_SETS : cs:C1710.SETSEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_icon($cE_SETS; "click")
Function lb_over_icon($cE_SETS : cs:C1710.SETSEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_icon($cE_SETS; "over")
Function lb_disabled_icon($cE_SETS : cs:C1710.SETSEntity)->$vO_img : Picture
	$vO_img:=This:C1470.lb_dcox_icon($cE_SETS; "disabled")
	
Function lb_dcox_icon($cE_SETS : cs:C1710.SETSEntity; $vT_bind : Text)->$vO_img : Picture
	var $vL_colors_main; $vL_shape; $vL_size; $vL_enablers; $vL_colors_in : Integer
	var $vJ_dcox; $vJ_bind; $vJ_DTO : Object
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	
	$vJ_DTO:=Form:C1466.j_DTO
	$vL_colors_in:=$vJ_DTO.l_colors_in
	$cE_TEMPLATES:=$cE_SETS.SETS_TEMPLATES
	If ($cE_TEMPLATES#Null:C1517)
		$vJ_dcox:=$cE_TEMPLATES.j_dcox
		$vL_colors_main:=$vJ_dcox.l_main
		$vJ_bind:=$vJ_dcox["j_"+$vT_bind]
		$vL_colors_in:=woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind; $vL_colors_in)
	End if 
	$vJ_dcox:=$cE_SETS.j_dcox
	$vL_colors_main:=$vJ_dcox.l_main
	$vJ_bind:=$vJ_dcox["j_"+$vT_bind]
	$vL_colors_in:=woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind; $vL_colors_in)
	$vL_enablers:=3  //woc_dcoxWidget_get_enablers($vJ_bind)
	$vL_shape:=app__storage_prefs().l_display_shape
	$vL_size:=26
	$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors_in; $vL_shape; $vL_enablers)
	
	
Function lb_dcox_img($cE_SETS : cs:C1710.SETSEntity)->$vO_picture : Picture
	var $c4Fi_icon : 4D:C1709.File
	var $is_whiteFor : Boolean
	var $vC_at_bind : Collection
	var $vL_colors_main; $idx; $vL_colors_out; $vL_shape; $vL_stroke; $vL_size; $vL_rxy; $vL_color_fill : Integer
	var $vL_colors_in : Integer
	var $vJ_dcox; $vJ_bind; $vJ_DTO : Object
	var $vO_icon; $vO_pict : Picture
	var $vR_coef : Real
	var $vT_bind; $vT_wb : Text
	var $cE_TEMPLATES : cs:C1710.TEMPLATESEntity
	
	$vJ_DTO:=Form:C1466.j_DTO
	$vL_colors_in:=$vJ_DTO.l_colors_in
	$vJ_dcox:=$cE_SETS.j_dcox
	$vL_colors_main:=$vJ_dcox.l_main
	$vC_at_bind:=sem_get_at_dcox()
	$idx:=0
	For each ($vT_bind; $vC_at_bind)
		$cE_TEMPLATES:=$cE_SETS.SETS_TEMPLATES
		If ($cE_TEMPLATES#Null:C1517)
			$vJ_dcox:=$cE_TEMPLATES.j_dcox
			$vL_colors_main:=$vJ_dcox.l_main
			$vJ_bind:=$vJ_dcox["j_"+$vT_bind]
			$vL_colors_in:=woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind; $vL_colors_in)
		End if 
		$vJ_dcox:=$cE_SETS.j_dcox
		$vL_colors_main:=$vJ_dcox.l_main
		$vJ_bind:=$vJ_dcox["j_"+$vT_bind]
		$vL_colors_in:=woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind; $vL_colors_in)
		
		$vL_shape:=$cE_SETS.shape
		$vL_stroke:=$cE_SETS.stroke
		$vL_size:=40
		$vL_rxy:=5
		$vR_coef:=1  //0.9
		$vL_color_fill:=woc_sp_colors_to_f($vL_colors_in)
		$is_whiteFor:=woc_sp_color_isWhiteFor($vL_color_fill)
		$vT_wb:=$is_whiteFor ? "w" : "b"
		$c4Fi_icon:=Folder:C1567(fk resources folder:K87:11).file("icons/icn_gesture_"+$vT_wb+".png")
		READ PICTURE FILE:C678($c4Fi_icon.platformPath; $vO_icon)
		$vO_pict:=woc_picture_icon_img($vL_size; $vL_size; $vR_coef; $vL_rxy; $vL_rxy; $vL_rxy; $vL_rxy; $vL_stroke; $vL_shape; $vL_colors_out; $vO_icon)
		$vO_picture:=$idx=0 ? $vO_pict : $vO_picture+$vO_pict
		$idx+=1
	End for each 
	
	
	//Function lb_dcox($cE_sets : cs.SETSEntity)
	//var $vC_at_bind : Collection
	//var $vL_colors_main; $vL_colors_out; $idx : Integer
	//var $vJ_dcox; $vJ_bind; $vJ_widget : Object
	//var $vT_bind : Text
	//$vJ_dcox:=$cE_sets.j_dcox
	
	//$vL_colors_main:=$vJ_dcox.l_main
	//$vC_at_bind:=sem_get_at_dcox()
	//$idx:=0
	//For each ($vT_bind; $vC_at_bind)
	//$vJ_bind:=$vJ_dcox["j_"+$vT_bind]
	//$vL_colors_out:=woc_dcoxWidget_get_colors($vL_colors_main; $vJ_bind)
	//$vJ_widget:=OBJECT Get value("woc_"+$vT_bind)
	//$vJ_widget.is_editing:=False
	//$vJ_widget.l_colors:=$vL_colors_out
	//$vJ_widget.redraw()
	//$idx+=1
	//End for each 
	
	