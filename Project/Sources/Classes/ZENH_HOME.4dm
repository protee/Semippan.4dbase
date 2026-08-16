
Class constructor
	
	
Function do()->$isOk : Boolean
	var $cs_ZENH_INFOS : cs:C1710.ZENH_INFOS
	var $vJ_prefs : Object
	var $vT_prefix_home; $vT_prefix_tables; $vT_refMenu; $vT_answerMenu : Text
	
	If (False:C215)
		$cs_ZENH_INFOS:=cs:C1710.ZENH_INFOS.new()
		$isOk:=$cs_ZENH_INFOS.do_menu()
		
	Else 
		//$vT_refMenu:=This._menu_module(Right click)
		$vT_prefix_home:="home"
		$vT_prefix_tables:="table"
		$vT_refMenu:=Create menu:C408
		$vJ_prefs:=sem__storage_prefs()
		wox_4dPop_menu_header($vT_prefix_home; $vJ_prefs; $vT_refMenu)
		This:C1470._menu_module($vT_prefix_tables; False:C215; $vT_refMenu; True:C214)
		APPEND MENU ITEM:C411($vT_refMenu; "-")
		This:C1470._menu_module($vT_prefix_tables; True:C214; $vT_refMenu; True:C214)
		
		$vT_answerMenu:=Dynamic pop up menu:C1006($vT_refMenu)
		RELEASE MENU:C978($vT_refMenu)
		$isOk:=$vT_answerMenu#""
		If ($isOk)
			This:C1470._answer($vT_answerMenu)
		End if 
	End if 
	
	
	
Function _menu_module($vT_prefix : Text; $is_local : Boolean; $vT_refMenu : Text; $is_inline : Boolean)->$vT_refMenu_answer : Text  //  #GUESSED: $vT_refMenu_local
	var $is_toAttach : Boolean
	var $vC_aj_TablesClass; $vC_aj_tables : Collection
	var $idx; $vL_color : Integer
	var $vJ_prefs; $vJ_module : Object
	var $vT_path_icons; $vT_module; $vT_refMenu_sub : Text
	
	$is_toAttach:=($vT_refMenu#"")
	
	$vJ_prefs:=zen__storage_prefs
	$vC_aj_TablesClass:=$is_local ? $vJ_prefs.aj_TablesClass_local : $vJ_prefs.aj_TablesClass
	
	$vT_path_icons:="path:/RESOURCES/tables/icn_"
	
	If ($is_toAttach) && ($is_inline)
		$vT_refMenu_answer:=$vT_refMenu
	Else 
		$vT_refMenu_answer:=Create menu:C408
		APPEND MENU ITEM:C411($vT_refMenu_answer; "Modules"; *)
		SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+"modules"+k_png_ext)
		DISABLE MENU ITEM:C150($vT_refMenu_answer; -1)
		//APPEND MENU ITEM($vT_refMenu_answer; "-")
	End if 
	
	$idx:=0
	For each ($vJ_module; $vC_aj_TablesClass)
		$vT_module:=$vJ_module.t_label
		$vL_color:=woc_sp_colors_to_s($vJ_module.l_colors)
		$vC_aj_tables:=$vJ_module.aj_tables
		$vT_refMenu_sub:=This:C1470._menu_tables($vT_prefix; $vC_aj_tables; $is_local)
		APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_module; $vT_refMenu_sub; *)
		woc_SET_MENU_ITEM_icnm($vT_refMenu_answer; -1; $vL_color)
		$idx+=1
	End for each 
	
	If (($is_toAttach) && Not:C34($is_inline))
		APPEND MENU ITEM:C411($vT_refMenu; "Modules"; $vT_refMenu_answer)
		RELEASE MENU:C978($vT_refMenu_answer)
	End if 
	
	
Function _menu_tables($vT_prefix : Text; $vC_aj_tables : Collection; $is_local : Boolean; $vT_refMenu : Text)->$vT_refMenu_answer : Text
	var $c4Fi_icon : 4D:C1709.File
	var $is_toAttach : Boolean
	var $vL_table : Integer
	var $vJ_tableClass : Object
	var $vT_path_icons; $vT_table; $vT_icon : Text
	$is_toAttach:=($vT_refMenu#"")
	
	$vT_refMenu_answer:=Create menu:C408
	//$vT_path_icons:="path:/RESOURCES/pictures/icn_product"
	//APPEND MENU ITEM($vT_refMenu_answer; "Tables"; *)
	//If ($is_local)
	//zen_SET_MENU_ITEM_ICON($vT_refMenu_answer; -1; $vT_path_icons+k_png_ext)
	//Else
	//SET MENU ITEM ICON($vT_refMenu_answer; -1; $vT_path_icons+k_png_ext)
	//End if
	//DISABLE MENU ITEM($vT_refMenu_answer; -1)
	//APPEND MENU ITEM($vT_refMenu_answer; "-")
	
	If ($is_local)
		$vT_path_icons:="path:/RESOURCES/d4Pop/icn_"
	Else 
		//$vT_path_icons:="path:/RESOURCES/tables"+($is_local ? "_local" : "")+"/icn_"
		$vT_path_icons:="path:/RESOURCES/tables/icn_"
	End if 
	$vT_prefix:=$vT_prefix+"."
	
	For each ($vJ_tableClass; $vC_aj_tables)
		$vT_table:=$vJ_tableClass.t_table
		$vL_table:=zen_get_tableNumber($vT_table)
		If ($vL_table>0)
			$vT_icon:=Lowercase:C14($vT_table)
			APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_table; *)
			SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; $vT_prefix+$vT_table)
			If ($is_local)
				zen_SET_MENU_ITEM_ICON($vT_refMenu_answer; -1; $vT_path_icons+$vT_icon+k_png_ext)
			Else 
				$c4Fi_icon:=Folder:C1567(fk resources folder:K87:11).file("tables/icn_"+$vT_icon+k_png_ext)
				If (Not:C34($c4Fi_icon.exists))
					$vT_icon:="tables"
				End if 
				SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_icons+$vT_icon+k_png_ext)
			End if 
		End if 
	End for each 
	
	If ($is_toAttach)
		APPEND MENU ITEM:C411($vT_refMenu; "Tables"; $vT_refMenu_answer)
		RELEASE MENU:C978($vT_refMenu_answer)
	End if 
	
	
Function _answer($vT_answerMenu : Text)
	var $vC_answer : Collection
	var $vT_action; $vT_param; $vT_prefix_home; $vT_prefix_tables : Text
	If ($vT_answerMenu#"")
		$vC_answer:=Split string:C1554($vT_answerMenu; ".")
		$vT_action:=$vC_answer[0]
		$vT_param:=$vC_answer[1]
		$vT_prefix_home:="home"
		$vT_prefix_tables:="table"
		
		Case of 
			: ($vT_action=$vT_prefix_home)
				Case of 
					: ($vT_param="releases_notes")
						This:C1470._release_notes()
						
					: ($vT_param="agreement")
						This:C1470._agreement()
				End case 
				
			: ($vT_action=$vT_prefix_tables)
				zen_table_open($vT_param)
		End case 
	End if 
	
	
Function _release_notes()
	var $is_edit : Boolean
	var $cE_zen_dashboard : cs:C1710.ZEN_DASHBOARDEntity
	var $vJ_prefs; $vJ_wox_prefs : Object
	var $vT_version_last : Text
	$vJ_prefs:=sem__storage_prefs()
	$is_edit:=Not:C34(Is compiled mode:C492) && Not:C34(Shift down:C543)
	$cE_zen_dashboard:=ds:C1482.ZEN_DASHBOARD.all().first()
	$vT_version_last:=$cE_zen_dashboard.version_previous
	$vJ_wox_prefs:=wox__storage_prefs()
	$vJ_wox_prefs.fu_release_notes($vJ_prefs; $is_edit; $vT_version_last)
	
Function _agreement()
	var $is_edit : Boolean
	var $vJ_prefs; $vJ_wox_prefs : Object
	var $vT_version_last : Text
	var $cE_zen_dashboard : cs:C1710.ZEN_DASHBOARDEntity
	$vJ_prefs:=sem__storage_prefs()
	$is_edit:=Not:C34(Is compiled mode:C492) && Not:C34(Shift down:C543)
	$cE_zen_dashboard:=ds:C1482.ZEN_DASHBOARD.all().first()
	$vT_version_last:=$cE_zen_dashboard.version_previous
	$vJ_wox_prefs:=wox__storage_prefs
	$vJ_wox_prefs.fu_agreement($vJ_prefs; $is_edit; $vT_version_last)
	
	