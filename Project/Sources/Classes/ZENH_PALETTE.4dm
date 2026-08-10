property _is_table_color; _is_infos; _is_dots : Boolean


Class constructor
	This:C1470._is_table_color:=True:C214
	This:C1470._is_infos:=True:C214
	This:C1470._is_dots:=True:C214
	
Function palette_do($is_record : Boolean)->$isOk : Boolean
	var $cs_ZENH_INFOS : cs:C1710.ZENH_INFOS
	var $vJ_palette_menu : Object
	var $vV_answer : Variant
	If (Windows Ctrl down:C562) || (Macintosh control down:C544) || (Macintosh command down:C546) || (Right click:C712)
		$cs_ZENH_INFOS:=cs:C1710.ZENH_INFOS.new()
		$isOk:=$cs_ZENH_INFOS.do_menu($is_record)
	Else 
		$vJ_palette_menu:=This:C1470.palette_menu_get($is_record)
		//$isOk:=waz_io_palette($vJ_palette)
		wox_sounds_play("Glitch4")
		$vV_answer:=waz_io_palette($vJ_palette_menu)
		$isOk:=$vV_answer#Null:C1517
		If (Not:C34($isOk))
			wox_sounds_play("Drop")
		End if 
	End if 
	
	
Function _actions($vJ_palette_item : Object; $vT_item : Text)->$isOk : Boolean
	// ***** Actions
	// *
	var $cs_ZENH_INFOS : cs:C1710.ZENH_INFOS
	$isOk:=True:C214
	
	Case of 
		: ($vT_item="product")
			$cs_ZENH_INFOS:=cs:C1710.ZENH_INFOS.new()
			$isOk:=$cs_ZENH_INFOS.do_menu()
			
		: ($vT_item="relations")
			app_relations_form()
			
		: ($vT_item="about")
			BEEP:C151
			
		: ($vT_item="doc")
			app_docBox_form()
			
			//: ($vT_item="zen4DPop")
			//zen_4DPop()
			
			//: ($vT_item="ogts")
			//zen_4DPop()
			
			
		: ($vT_item="ogToolsSuite")
			var $vT_prefix; $vT_refMenu; $vT_answerMenu; $vT_action; $vT_param : Text
			var $vC_at_answer : Collection
			$vT_prefix:=$vT_item  //"ogToolsSuite"
			$vT_refMenu:=wox_4dPop_menu($vT_prefix)
			$vT_answerMenu:=Dynamic pop up menu:C1006($vT_refMenu)
			RELEASE MENU:C978($vT_refMenu)
			$isOk:=(""#$vT_answerMenu)
			If ($isOk)
				$vC_at_answer:=Split string:C1554($vT_answerMenu; ".")
				$vT_action:=$vC_at_answer.shift()
				$vT_param:=$vC_at_answer[0]
				Case of 
					: ($vT_action=$vT_prefix)  //"ogToolsSuite")
						wox_4Dpop_execute($vC_at_answer)
						//: ($vT_action="4DPop")
						//This._ogDevTools($vC_at_answer)
						
						//: ($vT_action=$vT_prefix) && ($vT_param="xxx")  // home.xxx.sem.
						//$vT_param3:=$vC_at_answer[2]
						//Case of 
						//: ($vT_param3="releases")
						//This._do_releases()
						
						//: ($vT_param3="license")
						//This._do_license()
						//End case 
						
				End case 
			End if 
	End case 
	
	
Function _tables($vJ_palette_item : Object; $vT_item : Text)->$isOk : Boolean
	var $vT_table : Text
	$isOk:=True:C214
	$vT_table:=Uppercase:C13($vT_item)
	zen_table_open($vT_table)
	
	
Function _modules($vJ_palette_item : Object; $vT_item : Text)->$isOk : Boolean
	$isOk:=True:C214
	wox_sounds_play_confirm()
	// *
	// *****
	
	
Function io_palette_get()->$vJ_io_palette : Object
	var $vJ_pattern : Object
	var $vL_curve : Integer
	$vJ_io_palette:=New object:C1471
	$vJ_io_palette.r_scale:=1.3
	$vJ_io_palette.l_padding:=20
	$vJ_io_palette.r_angle_start:=-Pi:K30:1  ///3*2
	$vJ_io_palette.r_angle_end:=0  //Pi/2
	
	$vJ_io_palette.t_font_face:=wox_font_face_default("Calibri")
	$vJ_io_palette.l_font_color:=0x0A00000A
	$vJ_io_palette.l_font_size:=14
	$vJ_io_palette.r_font_wh_ratio:=0.55
	$vJ_io_palette.l_font_style:=0  //Bold
	$vJ_io_palette.l_centered:=0
	$vJ_io_palette.r_dot_coef:=0.4
	
	$vJ_io_palette.r_increment:=0.08
	$vJ_io_palette.l_timer:=1
	$vL_curve:=wox_math_curve_idFromName("Expo")
	$vJ_io_palette.l_curve:=$vL_curve
	$vJ_io_palette.is_close:=True:C214
	
	// ***** Pattern object
	// *
	$vJ_pattern:=New object:C1471
	$vJ_io_palette.j_pattern:=$vJ_pattern
	$vJ_pattern.l_pattern:=23
	$vJ_pattern.l_colors:=0xAA004005  // [swo:4] – [swo:5]
	$vJ_pattern.l_rxy:=18
	$vJ_pattern.l_stroke:=4
	$vJ_pattern.l_opacity:=85
	// *
	// *****
	
	
Function palette_menu_get($is_record : Boolean)->$vJ_palette_menu : Object
	// j_extra_btn{t_label; t_btn_path ; t_menu ; fu_method ; {aj_menus[]}}
	// aj_menus[] : { t_label ; t_pict ; t_menu }
	// if no aj_menus -> .fu_method at root
	var $vC_aj_items : Collection
	var $vJ_prefs : Object
	var $vt_path_product; $vT_path_icons; $vt_path_tables; $vT_base_name : Text
	
	$vJ_palette_menu:=New object:C1471()
	$vJ_palette_menu.j_io_palette:=This:C1470.io_palette_get()
	
	//$vJ_palette_menu.fu_icon:=Formula(zen_SET_MENU_ITEM_ICON)
	$vJ_palette_menu.fo_rsc:=Folder:C1567(fk resources folder:K87:11)
	$vJ_palette_menu.l_icn_wh:=24
	
	$vC_aj_items:=New collection:C1472
	$vJ_palette_menu.aj_items:=$vC_aj_items
	
	$vt_path_product:="pictures/icn_"
	$vT_path_icons:="icons/icn_home_"
	$vt_path_tables:="tables/icn_"
	
	// ***** Infos & zen_4DPop
	// *
	If (This:C1470._is_infos)
		//This._menu_xxx($vC_aj_palette; $vt_path_tables; "Infos"; "infos")
		//This._menu_xxx($vC_aj_palette; $vt_path_tables; "zenPop"; "zen4DPop")
		$vJ_prefs:=app__storage_prefs()
		$vT_base_name:=$vJ_prefs.t_name+"© "+$vJ_prefs.t_version
		$vC_aj_items.push(This:C1470._menu_item($vT_base_name; "product"; $vt_path_product; 2))
		//$vC_aj_palette.push(This._menu_item("zenPop"; "zen4DPop"; $vt_path_tables))
		$vC_aj_items.push(This:C1470._menu_item("Relations"; "relations"; $vT_path_icons))
		$vC_aj_items.push(This:C1470._menu_item("About"; "about"; $vT_path_icons))
		$vC_aj_items.push(This:C1470._menu_item("Documentation"; "doc"; $vT_path_icons))
		$vC_aj_items.push(This:C1470._menu_item("ogToolsSuite ©"; "ogToolsSuite"; $vT_path_icons))
	End if 
	
	// ***** Modules & Tables
	This:C1470._menu_modules($vC_aj_items; $vt_path_tables)
	// *
	// *****
	
Function _menu_item($vT_label : Text; $vT_menu : Text; $vt_path_icn : Text; $vR_font_coef : Real)->$vJ_item : Object
	var $vJ_this : Object
	$vJ_this:=This:C1470
	$vJ_item:=New object:C1471()
	$vJ_item.t_label:=$vT_label
	$vJ_item.t_menu:=$vT_menu
	$vJ_item.t_icn_path:=$vt_path_icn+$vT_menu
	If ($vR_font_coef#0)
		$vJ_item.r_font_size:=$vR_font_coef
		$vJ_item.r_width:=1/$vR_font_coef
	End if 
	$vJ_item.fu_method:=Formula:C1597($vJ_this._actions($1; $2))
	
	
	//Function _menu_xxx($vC_aj_palette : Collection; $vt_path_icn : Text; $vT_label; $vT_menu)
	//$vJ_this:=This
	//$vJ_palette:=New object()
	//$vC_aj_palette.push($vJ_palette)
	//$vJ_palette.t_label:=$vT_label
	//$vJ_palette.t_menu:=$vT_menu
	//$vJ_palette.t_icn_path:=$vt_path_icn+$vT_menu
	//$vJ_palette.fu_method:=Formula($vJ_this._actions($1; $2))
	
	
	
Function _menu_modules($vC_aj_items : Collection; $vt_path_icn : Text)
	var $vC_aj_TablesClass; $vC_aj_tables : Collection
	var $idx; $vL_colors; $vL_color; $vL_table_colors : Integer
	var $vJ_prefs; $vJ_module; $vJ_item; $vJ_this : Object
	var $vT_refMenu_sub; $vT_label : Text
	var $is_noDots : Boolean
	
	$is_noDots:=Not:C34(This:C1470._is_dots)
	$vJ_prefs:=zen__storage_prefs
	$vC_aj_TablesClass:=$vJ_prefs.aj_TablesClass
	$vJ_this:=This:C1470
	$idx:=0
	For each ($vJ_module; $vC_aj_TablesClass)
		//$vT_module:=$vJ_module.t_label
		//$vL_color:=woc_sp_colors_to_s($vJ_module.l_colors)
		$vJ_item:=New object:C1471()
		$vC_aj_items.push($vJ_item)
		$vT_label:=$vJ_module.t_label
		$vJ_item.t_label:=$vT_label
		$vL_colors:=$vJ_module.l_colors
		If ($is_noDots)
			$vL_color:=woc_sp_colors_to_s($vJ_module.l_colors)
			$vL_colors:=woc_sp_colors_from_sf($vL_color; 0)
		End if 
		$vJ_item.l_colors:=$vL_colors  // -> add circle and line
		$vJ_item.r_font_size:=1.5
		$vJ_item.l_font_style:=Bold:K14:2+Italic:K14:3
		$vJ_item.t_menu:=$vT_label
		$vJ_item.fu_method:=Formula:C1597($vJ_this._modules($1; $2))
		$vL_table_colors:=This:C1470._is_table_color ? $vL_colors : 0
		$vC_aj_tables:=$vJ_module.aj_tables
		$vT_refMenu_sub:=This:C1470._menu_tables($vC_aj_items; $vC_aj_tables; $vt_path_icn; $vL_table_colors)
		$idx+=1
	End for each 
	
	
Function _menu_tables($vC_aj_items : Collection; $vC_aj_tables : Collection; $vt_path_icn : Text; $vL_colors : Integer)
	var $vL_table : Integer
	var $vJ_this; $vJ_tableClass; $vJ_item : Object
	var $vT_table; $vT_menu : Text
	$vJ_this:=This:C1470
	For each ($vJ_tableClass; $vC_aj_tables)
		$vT_table:=$vJ_tableClass.t_table
		$vL_table:=zen_get_tableNumber($vT_table)
		If ($vL_table>0)
			$vT_menu:=Lowercase:C14($vT_table)
			$vJ_item:=New object:C1471
			$vC_aj_items.push($vJ_item)
			$vJ_item.t_label:=$vT_table
			$vJ_item.l_colors:=$vL_colors  // -> add circle and line
			$vJ_item.t_menu:=$vT_menu
			$vJ_item.t_icn_path:=$vt_path_icn+$vT_menu
			$vJ_item.fu_method:=Formula:C1597($vJ_this._tables($1; $2))
		End if 
	End for each 
	
	