
property aj_extra_btns : Collection
property t_path : Text
property l_label; l_winRef : Integer

Class constructor($vL_winRef : Integer)
	This:C1470.l_winRef:=$vL_winRef
	
	// For search class - and keep values in it
	//This.cs_search:=Null
	//This.cs_search1:=Null
	
	
Function get_extras_btns()->$vC_aj_extra_btns : Collection
	$vC_aj_extra_btns:=This:C1470.aj_extra_btns  // Lazy load
	If ($vC_aj_extra_btns=Null:C1517)
		$vC_aj_extra_btns:=New collection:C1472()  // [j_extra_btns]
		This:C1470.aj_extra_btns:=$vC_aj_extra_btns
		This:C1470.get_aj_extra_btns($vC_aj_extra_btns)
	End if 
	
	
	// *****
	// *
	// aj_extra_btns [j_extra_btn, ...]
	//  j_extra_btn : { t_label; l_label ; t_path ; t_tag ;
	//             and t_menu | fu_method | aj_items } 
	//  aj_items[]  : { t_label ; l_label ; t_path ; t_tag ; t_menu ; l_style }
	//
	// For both, if t_menu not given, use t_tag
	
Function extra_btn_new($vC_aj_extra_btns : Collection; $vT_label : Text; $vL_label : Integer; $vT_tag : Text; $vV_action : Variant)->$vJ_extra_btn : Object
	var $vL_type : Integer
	var $vT_path : Text
	$vJ_extra_btn:=New object:C1471()
	$vC_aj_extra_btns.push($vJ_extra_btn)
	$vT_path:=This:C1470.t_path
	$vJ_extra_btn.t_label:=$vT_label
	$vJ_extra_btn.l_label:=$vL_label
	$vJ_extra_btn.t_path:=$vT_path
	$vJ_extra_btn.t_tag:=$vT_tag
	If ($vV_action#Null:C1517)
		$vL_type:=Value type:C1509($vV_action)
		Case of 
			: $vL_type=Is text:K8:3
				$vJ_extra_btn.t_menu:=$vV_action
				
			: $vL_type=Is collection:K8:32
				$vJ_extra_btn.aj_items:=$vV_action  // new
				
			: $vL_type=Is object:K8:27
				$vJ_extra_btn.fu_method:=$vV_action
				
		End case 
	End if 
	
	
Function extra_item_new($vC_aj_items : Collection; $vT_label : Text; $vL_label : Integer; $vT_tag : Text; $vT_menu : Text; $vL_style : Integer)->$vJ_item : Object
	var $vT_path : Text
	$vJ_item:=New object:C1471
	$vC_aj_items.push($vJ_item)
	If ($vT_label#"")  // Else empty line separator
		$vT_path:=This:C1470.t_path
		$vJ_item.t_label:=$vT_label
		$vJ_item.l_label:=$vL_label
		$vJ_item.t_path:=$vT_path
		$vJ_item.t_tag:=$vT_tag
		//$vJ_item.t_tag:=$vt_assets_path+"icn_"+$vT_tag
		If ($vT_menu#"")
			$vJ_item.t_menu:=$vT_menu
		End if 
		If ($vL_style#0)
			$vJ_item.l_style:=$vL_style
		End if 
	End if 
	