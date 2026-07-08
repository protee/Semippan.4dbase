
// Remove k_relations, z_@_clic

Class constructor($is_record : Boolean)
	var $vC_menu; $vC_at_answer; $vC_found : Collection
	var $vJ_menu_answer; $vJ_prefs : Object
	var $vT_subPath_icon; $vT_title : Text
	var $vT_prefix; $vT_refMenu; $vT_answerMenu; $vT_action; $vT_param; $vT_param3 : Text
	var $isOk : Boolean
	
	$vJ_prefs:=app__storage_prefs()
	$vT_title:=$vJ_prefs.t_name+" "+$vJ_prefs.t_version
	$vT_prefix:="home"
	$vT_subPath_icon:="icons/icn_home_"
	$vC_menu:=This:C1470._get_menu_vC($is_record)
	$vT_refMenu:=This:C1470._menu_create($vT_prefix; $vT_subPath_icon; $vC_menu; $vT_title)
	$vT_answerMenu:=Dynamic pop up menu:C1006($vT_refMenu)
	RELEASE MENU:C978($vT_refMenu)
	$isOk:=(""#$vT_answerMenu)
	If ($isOk)
		$vC_at_answer:=Split string:C1554($vT_answerMenu; ".")
		$vT_action:=$vC_at_answer.shift()
		$vT_param:=$vC_at_answer[0]
		Case of 
			: ($vT_action=$vT_prefix) && ($vT_param="xxx")  // home.xxx.sem.
				$vT_param3:=$vC_at_answer[2]
				Case of 
					: ($vT_param3="releases")
						This:C1470._do_releases()
						
					: ($vT_param3="license")
						This:C1470._do_license()
				End case 
				
			: ($vT_action="ogToolsSuite")
				This:C1470._ogDevTools($vC_at_answer)
				//: ($vT_action="4DPop")
				//This._ogDevTools($vC_at_answer)
				
			: ($vT_action="tables")
				This:C1470._tables($vT_param)
				
			Else 
				$vC_found:=$vC_menu.query("t_menu = :1"; $vT_param)
				If ($vC_found.length>0)
					$vJ_menu_answer:=$vC_found[0]
					$vJ_menu_answer.fu_method()
				End if 
		End case 
	End if 
	
	
	
Function _get_menu_vC($is_record : Boolean)->$vC_menu : Collection
	var $vJ_this; $vJ_prefs : Object
	var $vT_base_name : Text
	$vJ_this:=This:C1470
	$vC_menu:=New collection:C1472()
	$vJ_prefs:=app__storage_prefs()
	$vT_base_name:=$vJ_prefs.t_name
	$vC_menu.push(This:C1470._menu_item(True:C214; "Tables"; "tables"; Formula:C1597($vJ_this._tables($1)); Formula:C1597($vJ_this._tables_menu($1; $2))))
	$vC_menu.push(This:C1470._menu_item(True:C214; "Relations"; "relations"; Formula:C1597($vJ_this._relations())))
	$vC_menu.push(This:C1470._menu_item())
	$vC_menu.push(This:C1470._menu_item(True:C214; "About "+$vT_base_name; "about"; Formula:C1597($vJ_this._z_about())))
	$vC_menu.push(This:C1470._menu_item(True:C214; "Documentation"; "doc"; Formula:C1597($vJ_this._z_help())))
	$vC_menu.push(This:C1470._menu_item())
	$vC_menu.push(This:C1470._menu_item(True:C214; "ogToolsSuite©"; "ogToolsSuite"; Formula:C1597($vJ_this._ogDevTools($1)); Formula:C1597($vJ_this._ogDevTools_menu($1; $2))))
	
	// *****
	// *
Function _ogDevTools_menu($vT_refMenu : Text; $vJ_menu : Object)
	var $vT_prefix : Text
	$vT_prefix:=$vJ_menu.t_menu
	wox_4dPop_menu($vT_prefix; $vT_refMenu)
	
	
Function _ogDevTools($vC_at_answer : Collection)
	wox_4Dpop_execute($vC_at_answer)
	
	
Function _tables_menu($vT_refMenu : Text; $vJ_menu : Object)
	var $vT_prefix : Text
	var $cs_ZENH_HOME : cs:C1710.ZENH_HOME
	$vT_prefix:=$vJ_menu.t_menu
	//wox_4dPop_menu($vT_prefix; $vT_refMenu)
	$cs_ZENH_HOME:=cs:C1710.ZENH_HOME.new()
	$cs_ZENH_HOME._menu_module($vT_prefix; False:C215; $vT_refMenu; True:C214)
	//APPEND MENU ITEM($vT_refMenu; "-")
	//$cs_ZENH_HOME._menu_module($vT_prefix; True; $vT_refMenu; True)
	
	
Function _tables($vT_param : Text)
	zen_table_open($vT_param)
	// *
	// *****
	
	
	// *****
	// *
Function _menu_create($vT_prefix : Text; $vT_subPath_icon : Text; $vC_menu : Collection; $vT_title : Text)->$vT_refMenu_answer : Text
	var $c4Fu_subMenu : 4D:C1709.Function
	var $is_valid; $is_separator : Boolean
	var $idx : Integer
	var $vT_label; $vT_menu : Text
	var $vT_path_icons : Text
	var $vJ_menu; $vJ_prefs : Object
	
	$vT_path_icons:="path:/RESOURCES/"+$vT_subPath_icon
	//$vT_value:=$vP_value->
	
	$vT_refMenu_answer:=Create menu:C408
	
	// *****
	// *
	$vT_prefix+="."
	$vJ_prefs:=app__storage_prefs()
	wox_4dPop_menu_header($vT_prefix; $vJ_prefs; $vT_refMenu_answer)
	// *
	// *****
	
	$idx:=0
	For each ($vJ_menu; $vC_menu)
		$vT_label:=$vJ_menu.t_label
		$vT_menu:=$vJ_menu.t_menu
		$is_separator:=($vT_label="")
		$vT_label:=$is_separator ? "-" : $vT_label
		If ($is_separator)
			APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_label)
			
		Else 
			$is_valid:=$vJ_menu.is_valid
			$c4Fu_subMenu:=$vJ_menu.fu_subMenu
			If ($c4Fu_subMenu#Null:C1517)
				$c4Fu_subMenu.call(Null:C1517; $vT_refMenu_answer; $vJ_menu)
			Else 
				APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_label; *)
				SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; $vT_prefix+$vT_menu)
				SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+$vT_menu+k_png_ext)
				//If ($vT_value=$vT_menu)
				//SET MENU ITEM MARK($vT_refMenu_answer; -1; Char(18))
				//End if
				If (Not:C34($is_valid))
					DISABLE MENU ITEM:C150($vT_refMenu_answer; -1)
				End if 
			End if 
		End if 
	End for each 
	
	
	
Function _menu_item($is_valid : Boolean; $vT_label : Text; $vT_menu : Text; $c4fu_method : 4D:C1709.Function; $c4fu_subMenu : 4D:C1709.Function)->$vJ_item : Object
	$vJ_item:=New object:C1471()
	$vJ_item.is_valid:=$is_valid
	$vJ_item.t_label:=$vT_label
	$vJ_item.t_menu:=$vT_menu
	$vJ_item.fu_method:=$c4fu_method
	$vJ_item.fu_subMenu:=$c4fu_subMenu
	// *
	// *****
	
	
	
	// *****
	// *
Function _z_about()
	BEEP:C151
	
Function _do_releases()
	var $is_edit : Boolean
	var $vJ_prefs; $vJ_wox_prefs : Object
	var $vT_version_last : Text
	var $cE_zen_dashboard : cs:C1710.ZEN_DASHBOARDEntity
	$vJ_prefs:=app__storage_prefs()
	$is_edit:=Not:C34(Is compiled mode:C492) && Shift down:C543
	$cE_zen_dashboard:=ds:C1482.ZEN_DASHBOARD.all().first()
	$vT_version_last:=$cE_zen_dashboard.version_previous
	$vJ_wox_prefs:=wox__storage_prefs
	$vJ_wox_prefs.fu_releases($vJ_prefs; $is_edit; $vT_version_last)
	
Function _do_license()
	var $is_edit : Boolean
	var $vJ_prefs; $vJ_wox_prefs : Object
	var $vT_version_last : Text
	var $cE_zen_dashboard : cs:C1710.ZEN_DASHBOARDEntity
	$vJ_prefs:=app__storage_prefs()
	$is_edit:=Not:C34(Is compiled mode:C492) && Shift down:C543
	$cE_zen_dashboard:=ds:C1482.ZEN_DASHBOARD.all().first()
	$vT_version_last:=$cE_zen_dashboard.version_previous
	$vJ_wox_prefs:=wox__storage_prefs()
	$vJ_wox_prefs.fu_license($vJ_prefs; $is_edit; $vT_version_last)
	
	
Function _z_help()
	var $vJ_params; $vJ_prefs : Object
	var $vT_title : Text
	$vJ_prefs:=app__storage_prefs()
	$vT_title:=$vJ_prefs.t_name+" "+$vJ_prefs.t_version
	$vJ_params:=New object:C1471
	$vJ_params.t_root_path:="/RESOURCES/_HELP"
	//$vJ_params.t_root_path:=h_server_get_resources+"_HELP"+Folder separator
	$vJ_params.t_sub_path:=""
	$vJ_params.t_root:="HELP : "+$vT_title
	$vJ_params.t_title:=$vT_title+" ogBox - integrated help"
	$vJ_params.t_process:="HELP"
	$vJ_params.t_pref_name:="help"
	$vJ_params.is_editing:=False:C215
	$vJ_params.r_font_size_coef:=0.9
	wob_open($vJ_params)
	
	
Function _relations()
	zenh_relations_form()
	// *
	// *****
	
	