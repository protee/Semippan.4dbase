
property t_LB : Text
property j_data : Object
property is_local : Boolean

Class constructor($vT_LB : Text)
	This:C1470.t_LB:=$vT_LB
	
Function lb_initialize($vJ_data : Object; $is_local : Boolean)  // To avoid errors if not exist on main class
	This:C1470.j_data:=$vJ_data
	This:C1470.is_local:=$is_local
	
	
Function get_column($vT_ordaPath : Text)->$vT_column : Text
	// Search into t_ordaPath for $vT_ordaPath
	// Answer first found, column name: "Column"+String($idx+1)
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
	// Search into t_ordaPath for $vT_ordaPath
	// Answer $vC_indices
	var $vC_aj_columns : Collection
	var $vJ_data : Object
	$vJ_data:=This:C1470.j_data
	$vC_aj_columns:=$vJ_data.aj_columns
	$vC_indices:=$vC_aj_columns.indices("t_ordaPath = :1"; $vT_ordaPath)
	
	
Function lb_meta_info_set($vT_function : Text)
	// Set Formula meta to $vT_function or "lb_meta_info"
	// Listbox set to "Form.fc."+$vT_function+"(This)"
	var $vT_LB : Text
	var $vT_formula : Text
	$vT_function:=$vT_function="" ? "lb_meta_info" : $vT_function
	$vT_formula:="Form.fc."+$vT_function+"(This)"
	$vT_LB:=This:C1470.t_LB
	LISTBOX SET PROPERTY:C1440(*; $vT_LB; lk meta expression:K53:75; $vT_formula)
	
	
Function meta_row($vJ_meta : Object; $is_unselectable : Boolean; $is_disabled : Boolean)
	// Row option
	// unselectable boolean
	// disabled boolean
	$vJ_meta.unselectable:=$is_unselectable
	$vJ_meta.disabled:=$is_disabled
	
	
Function meta_colors($vJ_meta : Object; $vL_colors : Integer; $vT_column : Text)
	// no $vT_column -> $vJ_meta | for row
	// $vT_column -> $vJ_meta = $vJ_meta_cell | for cell
	// fill "#ff3322"
	// stroke "#335588"
	var $vT_color_stroke; $vT_color_fill : Text
	var $vJ_meta_values : Object
	If ($vT_column#"")
		$vJ_meta_values:=$vJ_meta[$vT_column]  // Issue => give the column name that can change
		If ($vJ_meta_values=Null:C1517)
			$vJ_meta_values:=New object:C1471
			$vJ_meta[$vT_column]:=$vJ_meta_values  // Issue => give the column name that can change
		End if 
	Else 
		$vJ_meta_values:=$vJ_meta
	End if 
	woc_sp_colors_to_html($vL_colors; ->$vT_color_stroke; ->$vT_color_fill; True:C214)
	$vJ_meta_values.stroke:=$vT_color_stroke
	$vJ_meta_values.fill:=$vT_color_fill
	
	
Function meta_style($vJ_meta : Object; $vL_style : Integer; $vT_column : Text)
	// no $vT_column -> $vJ_meta | for row
	// $vT_column -> $vJ_meta = $vJ_meta_cell | for cell
	// fontStyle "normal";"italic"
	// fontWeight "normal";"bold"
	// textDecoration "normal";"underline"
	var $vJ_meta_values : Object
	If ($vT_column#"")
		$vJ_meta_values:=$vJ_meta[$vT_column]  // Issue => give the column name that can change
		If ($vJ_meta_values=Null:C1517)
			$vJ_meta_values:=New object:C1471
			$vJ_meta[$vT_column]:=$vJ_meta_values  // Issue => give the column name that can change
		End if 
	Else 
		$vJ_meta_values:=$vJ_meta
	End if 
	$vJ_meta_values.fontWeight:=$vL_style ?? 0 ? "bold" : "normal"
	$vJ_meta_values.fontStyle:=$vL_style ?? 1 ? "italic" : "normal"
	$vJ_meta_values.textDecoration:=$vL_style ?? 2 ? "underline" : "normal"
	
	
Function lb_bkg_color($vT_function : Text)
	// Set Formula for bkg color to $vT_function
	// Listbox set to "Form.fc."+$vT_function+"(This)"
	var $vT_LB; $vT_formula : Text
	$vT_formula:="Form.fc."+$vT_function+"(This)"
	$vT_LB:=This:C1470.t_LB
	LISTBOX SET PROPERTY:C1440(*; $vT_LB; lk background color expression:K53:47; $vT_formula)
	
	
Function lb_font_color($vT_function : Text)
	// Set Formula for font color to $vT_function
	// Listbox set to "Form.fc."+$vT_function+"(This)"
	var $vT_LB; $vT_formula : Text
	$vT_formula:="Form.fc."+$vT_function+"(This)"
	$vT_LB:=This:C1470.t_LB
	LISTBOX SET PROPERTY:C1440(*; $vT_LB; lk font color expression:K53:48; $vT_formula)
	
	
Function lb_font_style($vT_function : Text)
	// Set Formula for font style to $vT_function
	// Listbox set to "Form.fc."+$vT_function+"(This)"
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
	
	