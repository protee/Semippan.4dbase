property _is_table_color; _is_infos; _is_dots : Boolean


Class constructor
	This:C1470._is_table_color:=False:C215
	This:C1470._is_infos:=True:C214
	This:C1470._is_dots:=True:C214
	
	
Function palette_do($is_record : Boolean)->$isOk : Boolean
	var $cs_ZENH_INFOS : cs:C1710.ZENH_INFOS
	If (Windows Ctrl down:C562) || (Macintosh control down:C544) || (Macintosh command down:C546) || (Right click:C712)
		$cs_ZENH_INFOS:=cs:C1710.ZENH_INFOS.new($is_record)
	Else 
		$vJ_palette:=This:C1470.palette_get($is_record)
		$isOk:=waz_io_palette($vJ_palette)
	End if 
	
	
Function _actions($vJ_palette_item : Object; $vT_item : Text)->$isOk : Boolean
	// ***** Actions
	// *
	var $cs_ZENH_INFOS : cs:C1710.ZENH_INFOS
	var $vT_table : Text
	$isOk:=True:C214
	
	Case of 
		: ($vT_item="infos")
			$cs_ZENH_INFOS:=cs:C1710.ZENH_INFOS.new()
			
		: ($vT_item="zenPop")
			zen_4DPop()
			
		Else 
			$vT_table:=Uppercase:C13($vT_item)
			zen_table_open($vT_table)
			
	End case 
	
	
Function _modules($vJ_palette_item : Object; $vT_item : Text)->$isOk : Boolean
	$isOk:=True:C214
	wox_sounds_play_confirm()
	// *
	// *****
	
	
Function palette_get($is_record : Boolean)->$vJ_palette : Object
	var $vJ_pattern : Object
	$vJ_palette:=New object:C1471
	$vJ_palette.is_icn:=True:C214  // Mode icons
	$vJ_palette.l_btn_wh:=30
	$vJ_palette.l_padding:=10
	$vJ_palette.r_dot_coef:=0.25
	
	//$vJ_palette.t_font_face:="Arial"
	$vJ_palette.l_font_color:=k_MD_white
	$vJ_palette.l_font_size:=12
	$vJ_palette.l_font_style:=Bold:K14:2
	$vJ_palette.l_centered:=0
	
	$vJ_palette.r_angle_start:=-Pi:K30:1  ///3*2
	$vJ_palette.r_angle_end:=Pi:K30:1/2
	//$vJ_palette.r_angle_start:=0
	//$vJ_palette.r_angle_end:=-Pi/2
	
	$vJ_palette.r_scale:=1.8  //1.8
	//$vJ_palette.l_centered:=-1  //
	$vJ_palette.l_timer:=1
	$vJ_palette.r_increment:=0.06
	$vJ_palette.l_curve:=11  // Default 4
	//$vJ_palette.is_close:=False
	// *
	// *****
	
	// ***** Pattern object
	// *
	$vJ_pattern:=New object:C1471
	$vJ_palette.j_pattern:=$vJ_pattern
	$vJ_pattern.l_pattern:=23
	$vJ_pattern.l_colors:=0x3E3C  // 0x44136138  //0x908E
	$vJ_pattern.l_rxy:=18
	$vJ_pattern.l_stroke:=5
	$vJ_pattern.l_opacity:=50
	This:C1470.palette_build($vJ_palette)
	// *
	// *****
	
	
Function palette_build($vJ_palette : Object)
	// j_extra_btn{t_label; t_btn_path ; t_menu ; fu_method ; {aj_menus[]}}
	// aj_menus[] : { t_label ; t_pict ; t_menu }
	// if no aj_menus -> .fu_method at root
	var $vC_aj_palette : Collection
	var $vJ_this; $vJ_extra_btn : Object
	var $vt_path_btn; $vt_path_icn : Text
	
	$vt_path_btn:="tables/btn_"
	$vt_path_icn:="tables/icn_"
	
	$vC_aj_palette:=New collection:C1472
	$vJ_palette.aj_palette:=$vC_aj_palette
	
	// ***** Infos & zen_4DPop
	// *
	If (This:C1470._is_infos)
		$vJ_this:=This:C1470
		$vJ_extra_btn:=New object:C1471
		$vC_aj_palette.push($vJ_extra_btn)
		$vJ_extra_btn.t_label:="Infos"
		$vJ_extra_btn.t_menu:="infos"
		$vJ_extra_btn.t_icn_path:=$vt_path_icn+"infos"
		$vJ_extra_btn.fu_method:=Formula:C1597($vJ_this._actions($1; $2))
		
		//$vJ_extra_btn:=New object
		//$vC_aj_palette.push($vJ_extra_btn)
		//$vJ_extra_btn.t_label:="zenPop"
		//$vJ_extra_btn.t_menu:="zenPop"
		//$vJ_extra_btn.t_icn_path:=$vt_path_icn+"zen4DPop"
		//$vJ_extra_btn.fu_method:=Formula($vJ_this._actions($1; $2))
	End if 
	// *
	// *****
	
	
	// ***** Modules & Tables
	// *
	This:C1470._menu_modules($vC_aj_palette; $vt_path_icn)
	// *
	// *****
	
	
	
Function _menu_modules($vC_aj_palette : Collection; $vt_path_icn : Text)
	var $vC_aj_TablesClass; $vC_aj_tables : Collection
	var $idx; $vL_colors; $vL_color; $vL_table_colors : Integer
	var $vJ_prefs; $vJ_module; $vJ_extra_btn : Object
	var $vT_refMenu_sub : Text
	var $is_noDots : Boolean
	
	$is_noDots:=Not:C34(This:C1470._is_dots)
	$vJ_prefs:=zen__storage_prefs
	$vC_aj_TablesClass:=$vJ_prefs.aj_TablesClass
	$vJ_this:=This:C1470
	$idx:=0
	For each ($vJ_module; $vC_aj_TablesClass)
		//$vT_module:=$vJ_module.t_label
		//$vL_color:=woc_sp_colors_to_s($vJ_module.l_colors)
		$vJ_extra_btn:=New object:C1471()
		$vC_aj_palette.push($vJ_extra_btn)
		$vT_label:=$vJ_module.t_label
		$vJ_extra_btn.t_label:=$vT_label
		$vL_colors:=$vJ_module.l_colors
		If ($is_noDots)
			$vL_color:=woc_sp_colors_to_s($vJ_module.l_colors)
			$vL_colors:=woc_sp_colors_from_sf($vL_color; 0)
		End if 
		$vJ_extra_btn.l_colors:=$vL_colors  // -> add circle and line
		$vJ_extra_btn.r_font_size:=1.5
		$vJ_extra_btn.l_font_style:=Bold:K14:2+Italic:K14:3
		$vJ_extra_btn.t_menu:="MOD_"+$vT_label
		$vJ_extra_btn.fu_method:=Formula:C1597($vJ_this._modules($1; $2))
		$vL_table_colors:=This:C1470._is_table_color ? $vL_colors : 0
		$vC_aj_tables:=$vJ_module.aj_tables
		$vT_refMenu_sub:=This:C1470._menu_tables($vC_aj_palette; $vC_aj_tables; $vt_path_icn; $vL_table_colors)
		$idx+=1
	End for each 
	
	
Function _menu_tables($vC_aj_palette : Collection; $vC_aj_tables : Collection; $vt_path_icn : Text; $vL_colors : Integer)
	var $vL_table : Integer
	var $vJ_this; $vJ_tableClass; $vJ_extra_btn : Object
	var $vT_table; $vT_menu : Text
	$vJ_this:=This:C1470
	For each ($vJ_tableClass; $vC_aj_tables)
		$vT_table:=$vJ_tableClass.t_table
		$vL_table:=zen_get_tableNumber($vT_table)
		If ($vL_table>0)
			$vT_menu:=Lowercase:C14($vT_table)
			$vJ_extra_btn:=New object:C1471
			$vC_aj_palette.push($vJ_extra_btn)
			$vJ_extra_btn.t_label:=$vT_table
			$vJ_extra_btn.l_colors:=$vL_colors  // -> add circle and line
			$vJ_extra_btn.t_menu:=$vT_menu
			$vJ_extra_btn.t_icn_path:=$vt_path_icn+$vT_menu
			$vJ_extra_btn.fu_method:=Formula:C1597($vJ_this._actions($1; $2))
		End if 
	End for each 
	
	