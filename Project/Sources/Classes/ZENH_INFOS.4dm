
// Remove k_relations, z_@_clic

Class constructor()
	
Function do_menu($is_record : Boolean)->$isOk : Boolean
	var $vC_menu; $vC_at_answer; $vC_found : Collection
	var $vJ_menu_answer; $vJ_prefs : Object
	var $vT_subPath_icon; $vT_title : Text
	var $vT_prefix; $vT_refMenu; $vT_answerMenu; $vT_action; $vT_param; $vT_param3 : Text
	
	$vJ_prefs:=sem__storage_prefs()
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
				This:C1470._ogToolsSuite($vC_at_answer)
				
			: ($vT_action="syntaxEN")
				This:C1470._syntaxEN($vC_at_answer)
				
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
	$vJ_prefs:=sem__storage_prefs()
	$vT_base_name:=$vJ_prefs.t_name
	$vC_menu.push(This:C1470._menu_item(True:C214; "Tables"; "tables"; Formula:C1597($vJ_this._tables($1)); Formula:C1597($vJ_this._tables_menu($1; $2))))
	$vC_menu.push(This:C1470._menu_item(True:C214; "Relations"; "relations"; Formula:C1597($vJ_this._do_relations())))
	$vC_menu.push(This:C1470._menu_item())
	$vC_menu.push(This:C1470._menu_item(True:C214; "About "+$vT_base_name; "about"; Formula:C1597($vJ_this._do_about())))
	$vC_menu.push(This:C1470._menu_item(True:C214; "Documentation"; "doc"; Formula:C1597($vJ_this._do_doc())))
	$vC_menu.push(This:C1470._menu_item())
	$vC_menu.push(This:C1470._menu_item(True:C214; "ogToolsSuite©"; "ogToolsSuite"; Formula:C1597($vJ_this._ogToolsSuite($1)); Formula:C1597($vJ_this._ogToolsSuite_menu($1; $2))))
	//$vC_menu.push(This._menu_item(True; "syntaxEN"; "syntaxEN"; Formula($vJ_this._syntaxEN($1)); Formula($vJ_this._syntaxEN_menu($1; $2))))
	
	// *****
	// *
Function _ogToolsSuite_menu($vT_refMenu : Text; $vJ_menu : Object)
	var $vT_prefix : Text
	var $is_inline : Boolean
	$vT_prefix:=$vJ_menu.t_menu
	//wox_4dPop_menu($vT_prefix; $vT_refMenu)
	$is_inline:=False:C215
	wox_4dPop_apps_menu($vT_prefix+".xxx."; False:C215; $vT_prefix+" ©"; $vT_refMenu; $is_inline)  //; True)
	
Function _ogToolsSuite($vC_at_answer : Collection)
	wox_4Dpop_execute($vC_at_answer)
	
	
Function _syntaxEN_menu($vT_refMenu : Text; $vJ_menu : Object)
	var $is_inline : Boolean
	var $vT_prefix : Text
	$vT_prefix:=$vJ_menu.t_menu
	$is_inline:=False:C215
	cs:C1710.wox.syntaxEN.me.get_menu_apps($vT_prefix+"."; True:C214; $vT_prefix+" ©"; $vT_refMenu; $is_inline)
	
Function _syntaxEN($vC_at_answer : Collection)
	//wox_4Dpop_execute($vC_at_answer)
	var $vT_syntaxEN : Text
	$vT_app:=$vC_at_answer.shift()
	$vT_dummy:=$vC_at_answer.shift()
	$vT_syntaxEN:=$vC_at_answer.join(".")
	If ($vT_syntaxEN="")
		wox_syntaxEN_mng($vT_app)
	Else 
		SET TEXT TO PASTEBOARD:C523($vT_syntaxEN)
		cs:C1710.wox.SOUNDS.me.play_glop()
	End if 
	
	
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
	$vJ_prefs:=sem__storage_prefs()
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
	$vJ_prefs:=sem__storage_prefs()
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
	$vJ_prefs:=sem__storage_prefs()
	$is_edit:=Not:C34(Is compiled mode:C492) && Shift down:C543
	$cE_zen_dashboard:=ds:C1482.ZEN_DASHBOARD.all().first()
	$vT_version_last:=$cE_zen_dashboard.version_previous
	$vJ_wox_prefs:=wox__storage_prefs()
	$vJ_wox_prefs.fu_license($vJ_prefs; $is_edit; $vT_version_last)
	
	
Function _do_doc()
	app_docBox_form()
	
	
Function _do_relations()
	app_relations_form()
	// *
	// *****
	
	