
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
	$vT_column:=This:C1470.get_column("key")
	This:C1470.meta_cell_colors($vJ_meta_cell; $vT_column; $vL_colors)
	
	
Function lb_picts_count($cE_categories : cs:C1710.CATEGORIESEntity)->$vL_count : Integer
	$vL_count:=$cE_categories.CATEGORIES_PICTURES.length
	
	
Function lb_colors_img($cE_categories : cs:C1710.CATEGORIESEntity)->$vO_img : Picture
	var $vL_colors; $vL_shape; $vL_size : Integer
	$vL_colors:=$cE_categories.colors
	$vL_shape:=-4
	$vL_size:=24
	$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors; $vL_shape; 3)
	
	
Function lb_active_img($cE_categories : cs:C1710.CATEGORIESEntity)->$vO_img : Picture  // Form.fc.lb_active_img(This)
	$vO_img:=This:C1470.get_icon_img($cE_categories.isActive)
	
	