
Class extends ZEN__TABLES_LIST

Class constructor($vT_LB : Text)
	Super:C1705($vT_LB)  // Init LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)
	Super:C1706.lb_initialize($vJ_data; $is_local)  // Init LB
	var $vT_LB : Text
	$vT_LB:=This:C1470.t_LB
	If ($vT_LB#"")
		This:C1470.lb_meta_info_set()
	End if 
	
Function lb_meta_info($c4E_entity : 4D:C1709.Entity)->$vJ_meta : Object
	var $vL_colors : Integer
	var $vJ_meta_cell : Object
	var $vT_column : Text
	$vJ_meta:=New object:C1471
	$vL_colors:=$c4E_entity.colors
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta.stroke:=$vT_color_stroke
	//$vJ_meta.fill:=$vT_color_fill
	
	// For cells
	$vJ_meta_cell:=New object:C1471
	$vJ_meta.cell:=$vJ_meta_cell
	$vT_column:=This:C1470.get_column("label")
	This:C1470.meta_colors($vJ_meta_cell; $vL_colors; $vT_column)
	
	
Function lb_colors_img($cE_combinations : cs:C1710.COMBINATIONSEntity)->$vO_img : Picture
	var $vC_al_colors : Collection
	var $vL_stroke; $vL_width; $vL_height : Integer
	var $vJ_value : Object
	$vJ_value:=$cE_combinations.j_cmb
	$vL_stroke:=$vJ_value.l_stroke
	$vC_al_colors:=$vJ_value.al_colors
	$vL_width:=400
	$vL_height:=50
	$vO_img:=woc_svg_al_colors($vC_al_colors; $vL_width; $vL_height; $vL_stroke)  //; 100; 12)
	
	