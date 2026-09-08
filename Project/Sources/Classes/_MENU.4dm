
property t_path; t_path_attached : Text


Class constructor($vT_path : Text; $vT_path_attached : Text)
	This:C1470.t_path:=$vT_path  // "toto/"
	This:C1470.t_path_attached:=$vT_path_attached  // "toto/"
	
	
Function setPath($vT_path : Text)
	This:C1470.t_path:=$vT_path  // "toto/"
	
	
Function setPathAttached($vT_path_attached : Text)
	This:C1470.t_path_attached:=$vT_path_attached  // "toto/"
	// *
	// *****
	
	
	// *****
	// *
Function getTranslated($vT_label : Text; $vL_label : Integer)->$vT_answer : Text
	$vT_answer:=wox_localize_tag($vL_label; $vT_label)
	
	
Function pushMenuItem($vC_aj_items : Collection; $vT_label : Text; $vT_menu : Text; $vT_path_icn : Text)
	$vC_aj_items.push(This:C1470.getMenuItem($vT_label; $vT_menu; $vT_path_icn))
	
	
Function getMenuItem($vT_label : Text; $vT_menu : Text; $vT_subpath : Text)->$vJ_item : Object
	$vJ_item:=New object:C1471()
	$vJ_item.t_label:=$vT_label
	$vJ_item.t_menu:=$vT_menu
	$vJ_item.t_icn_path:=$vT_subpath+$vT_menu
	
	
	
Function headerMenu($vT_refMenu : Text; $vT_label : Text; $vT_path_menu : Text)
	APPEND MENU ITEM:C411($vT_refMenu; $vT_label; *)
	DISABLE MENU ITEM:C150($vT_refMenu; -1)
	If ($vT_path_menu#"none")
		If ($vT_path_menu="")
			$vT_path_menu:="path:/RESOURCES/icons/icn_infos"
		End if 
		SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_menu+k_png_ext)
	End if 
	APPEND MENU ITEM:C411($vT_refMenu; "-")
	// *
	// *****
	
	
	
	// *****
	// *
Function choiceMenu($vT_prefix : Text; $vT_header : Text; $vC_aj_menu_items : Collection; $vT_value : Text; $vT_refMenu : Text; $is_inline : Boolean)->$vT_refMenu_answer : Text
	var $is_toAttach : Boolean
	var $idx : Integer
	var $vJ_item : Object
	var $vT_label; $vT_path; $vT_path_menu; $vT_menu; $vT_parameter; $vT_icon; $vT_path_attached : Text
	If ($is_toAttach) && ($is_inline)
		$vT_refMenu_answer:=$vT_refMenu
	Else 
		$vT_refMenu_answer:=Create menu:C408()
		This:C1470.headerMenu($vT_refMenu_answer; $vT_label)
	End if 
	
	$vT_prefix:=$vT_prefix#"" ? $vT_prefix+"." : ""
	$vT_path:=This:C1470.t_path
	$vT_path_menu:="path:/RESOURCES/"+$vT_path
	
	$idx:=0
	For each ($vJ_item; $vC_aj_menu_items)
		$vT_label:=$vJ_item.t_label
		If ($vT_label="")
			APPEND MENU ITEM:C411($vT_refMenu_answer; "-")
		Else 
			$vT_menu:=$vJ_item.t_menu
			$vT_parameter:=$vT_prefix+$vT_menu
			$vT_icon:=$vJ_item.t_icn_path
			APPEND MENU ITEM:C411($vT_refMenu_answer; $vT_label; *)
			SET MENU ITEM PARAMETER:C1004($vT_refMenu_answer; -1; $vT_parameter)
			SET MENU ITEM ICON:C984($vT_refMenu_answer; -1; $vT_path_menu+$vT_icon+k_png_ext)
			If ($vT_menu=$vT_value)
				SET MENU ITEM MARK:C208($vT_refMenu_answer; -1; Char:C90(18))
			End if 
			$idx+=1
		End if 
	End for each 
	
	If ($is_toAttach) && (Not:C34($is_inline))
		APPEND MENU ITEM:C411($vT_refMenu; $vT_label; $vT_refMenu_answer; *)
		RELEASE MENU:C978($vT_refMenu_answer)
		$vT_path_attached:=This:C1470.t_path_attached
		SET MENU ITEM ICON:C984($vT_refMenu; -1; $vT_path_menu+$vT_path_attached+k_png_ext)
	End if 
	
	
Function choiceMenu_vL($vP_vL_value : Pointer; $vC_aj_menu_items : Collection; $vT_header : Text)->$isOk : Boolean
	var $vT_refMenu; $vT_answer; $vT_value; $vT_prefix : Text
	$vT_value:=String:C10($vP_vL_value->)
	$vT_refMenu:=This:C1470.choiceMenu($vT_prefix; $vT_header; $vC_aj_menu_items; $vT_value)
	$vT_answer:=Dynamic pop up menu:C1006($vT_refMenu)
	$isOk:=$vT_answer#""
	If ($isOk)
		// Remove prefix if needed
		$vP_vL_value->:=Num:C11($vT_answer)
	End if 
	
	
Function choiceMenu_vT($vC_aj_menu_items : Collection; $vT_header : Text; $vT_value : Text)->$vT_answer : Text
	var $vT_refMenu; $vT_prefix : Text
	var $isOk : Boolean
	$vT_refMenu:=This:C1470.choiceMenu($vT_prefix; $vT_header; $vC_aj_menu_items; $vT_value)
	$vT_answer:=Dynamic pop up menu:C1006($vT_refMenu)
	$isOk:=$vT_answer#""
	If ($isOk)
		// Remove prefix if needed
	End if 
	// *
	// *****
	
	