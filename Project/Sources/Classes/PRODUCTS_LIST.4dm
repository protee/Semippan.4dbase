
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
	
Function lb_meta_info($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$vJ_meta : Object
	var $vL_colors : Integer
	$vJ_meta:=New object:C1471
	
	//$vL_colors:=$c4E_entity.colors
	//woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True)
	//$vJ_meta.stroke:=$vT_color_stroke
	//$vJ_meta.fill:=$vT_color_fill
	
	$vL_colors:=$cE_PRODUCTS.colors
	
	// For cells
	var $vJ_meta_cell : Object
	var $vT_column : Text
	$vJ_meta_cell:=New object:C1471
	$vJ_meta.cell:=$vJ_meta_cell
	$vT_column:=This:C1470.get_column("label")
	This:C1470.meta_cell_colors($vJ_meta_cell; $vT_column; $vL_colors)
	
	
Function lb_type_txt($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$vT_answer : Text
	var $vT_UID_type : Text
	$vT_UID_type:=$cE_PRODUCTS.UIDtype
	$vT_answer:=wor_menu_path_UIDs("TYPES"; $vT_UID_type; False:C215; True:C214)
	
	
Function lb_paths_count($cE_products : cs:C1710.PRODUCTSEntity)->$vL_count : Integer
	$vL_count:=$cE_products.PRODUCTS_PATHS.length
	
	