
property t_LB : Text
property j_data : Object
property is_local : Boolean

Class constructor($vT_LB : Text)
	This:C1470.t_LB:=$vT_LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)  // To avoid errors if not exist on main class
	This:C1470.j_data:=$vJ_data
	This:C1470.is_local:=$is_local
	
	
Function get_column($vT_ordaPath : Text)->$vT_column : Text
	var $vC_aj_columns; $vC_indices : Collection
	var $idx : Integer
	var $vJ_data : Object
	$vJ_data:=This:C1470.j_data
	$vC_aj_columns:=$vJ_data.aj_columns
	$vC_indices:=$vC_aj_columns.indices("t_ordaPath = :1"; $vT_ordaPath)
	If ($vC_indices.length>0)
		$idx:=$vC_indices[0]
		$vT_column:="Column"+String:C10($idx+1)
	End if 
	
	
Function get_columns($vT_ordaPath : Text)->$vC_indices : Collection
	var $vC_aj_columns : Collection
	var $vJ_data : Object
	$vJ_data:=This:C1470.j_data
	$vC_aj_columns:=$vJ_data.aj_columns
	$vC_indices:=$vC_aj_columns.indices("t_ordaPath = :1"; $vT_ordaPath)
	
	
Function lb_meta_info_set($vT_function : Text)
	$vT_function:=$vT_function="" ? "lb_meta_info" : $vT_function
	var $vT_formula : Text
	$vT_formula:="Form.fc."+$vT_function+"(This)"
	var $vT_LB : Text
	$vT_LB:=This:C1470.t_LB
	LISTBOX SET PROPERTY:C1440(*; $vT_LB; lk meta expression:K53:75; $vT_formula)
	// fill "#ff3322"
	// stroke "#335588"
	// fontStyle "normal";"italic"
	// fontWeight "normal";"bold"
	// textDecoration "normal";"underline"
	// unselectable boolean
	// disabled boolean
	// cell object
	
Function meta_line_colors($vJ_meta : Object; $vL_colors : Integer)
	var $vT_color_stroke; $vT_color_fill : Text
	woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True:C214)
	$vJ_meta.stroke:=$vT_color_stroke
	$vJ_meta.fill:=$vT_color_fill
	
Function meta_cell_colors($vJ_meta_cell : Object; $vT_column : Text; $vL_colors : Integer)
	var $vJ_meta_cell_values : Object
	var $vT_color_stroke; $vT_color_fill : Text
	$vJ_meta_cell_values:=New object:C1471
	$vJ_meta_cell[$vT_column]:=$vJ_meta_cell_values  // Issue => give the column name that can change
	woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True:C214)
	$vJ_meta_cell_values.stroke:=$vT_color_stroke
	$vJ_meta_cell_values.fill:=$vT_color_fill
	
	
	
Function lb_bkg_color($vT_function : Text)
	$vT_formula:="Form.fc."+$vT_function+"(This)"
	var $vT_LB; $vT_formula : Text
	$vT_LB:=This:C1470.t_LB
	LISTBOX SET PROPERTY:C1440(*; $vT_LB; lk background color expression:K53:47; $vT_formula)
	
	
Function lb_font_color($vT_function : Text)
	$vT_formula:="Form.fc."+$vT_function+"(This)"
	var $vT_LB; $vT_formula : Text
	$vT_LB:=This:C1470.t_LB
	LISTBOX SET PROPERTY:C1440(*; $vT_LB; lk font color expression:K53:48; $vT_formula)
	
	
Function lb_font_style($vT_function : Text)
	var $vT_LB; $vT_formula : Text
	$vT_formula:="Form.fc."+$vT_function+"(This)"
	$vT_LB:=This:C1470.t_LB
	LISTBOX SET PROPERTY:C1440(*; $vT_LB; lk font style expression:K53:49; $vT_formula)
	
	
Function lb_isNokOk_img($is_value : Boolean; $vL_colorsRow : Integer; $vL_shape : Integer; $vL_size : Integer)->$vO_img : Picture
	$vO_img:=woc_sp_shape_toggle($is_value; $vL_colorsRow; $vL_shape; $vL_size)  // Wrapper !
	
	
Function get_icon_img($is_value : Boolean; $vL_colorsRow : Integer; $vL_shape : Integer; $vL_size : Integer)->$vO_img : Picture
	var $vL_colors : Integer
	$vL_colorsRow:=$vL_colorsRow=0 ? k_MDcolorsIdx_lightGreen : $vL_colorsRow
	$vL_size:=$vL_size=0 ? 14 : $vL_size
	$vL_shape:=$vL_shape#0 ? $vL_shape : 2
	$vL_colors:=$is_value ? woc_sp_colors_from_row($vL_colorsRow; 7; 3) : woc_sp_colors_from_row(k_MDcolorsIdx_grey; 5; 1)
	$vO_img:=woc_sp_shape_get($vL_size; $vL_size; $vL_colors; $vL_shape)
	
	