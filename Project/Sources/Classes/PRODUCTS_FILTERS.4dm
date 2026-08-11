
Class extends ZENH_TABLES_FILTERS

Class constructor($vT_table : Text; $vL_table : Integer; $is_local : Boolean)
	Super:C1705($vT_table; $vL_table; $is_local)
	
	//This.j_edit:=OB Copy($vJ_params)
	
	var $vJ_params : Object
	$vJ_params:=New object:C1471
	var $vC_aj_filters : Collection
	$vC_aj_filters:=This:C1470.init_search()
	$vJ_params.aj_search:=$vC_aj_filters
	This:C1470.j_params:=$vJ_params
	This:C1470.set_widgets()
	
	
Function _filters_events()
	
	
	// *****
	// *
Function init_search()->$vC_aj_filters : Collection  // Filter's description
	$vC_aj_filters:=New collection:C1472
	$vC_aj_filters.push(This:C1470._get_search_wor("wor_TYPES"; Table name:C256(->[TYPES:32])))
	$vC_aj_filters.push(This:C1470._get_search_switch("waz_isComponent"))
	$vC_aj_filters.push(This:C1470._get_search_switch("waz_isCorner"))
	$vC_aj_filters.push(This:C1470._get_search_switch("waz_isFree"))
	$vC_aj_filters.push(This:C1470._get_search_switch("waz_isSRC"))
	$vC_aj_filters.push(This:C1470._get_search_switch("waz_isActive"; True:C214))
	//This.clear_search($vC_aj_filters)
	
	
Function _filters()
	//cs.wox.TUNES.me.play_beep()
	This:C1470.get_widgets()
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
	
Function DO_filters($c4ES_selection_in : 4D:C1709.EntitySelection)->$c4ES_selection : 4D:C1709.EntitySelection
	var $vC_aj_filters : Collection
	var $vC_aj_filters_in : Collection
	$vC_aj_filters:=$vC_aj_filters_in=Null:C1517 ? This:C1470._get_aj_search() : $vC_aj_filters_in
	
	var $c4ES_selection_temp : 4D:C1709.EntitySelection
	$c4ES_selection_temp:=$c4ES_selection_in
	//$vC_query:=New collection()
	
	var $vT_AND : Text
	$vT_AND:=" AND "
	
	var $vJ_filter : Object
	var $is_filter; $is_filtered : Boolean
	var $vT_name : Text
	var $vL_value : Integer
	var $vV_UID : Variant
	var $cES_TYPES : cs:C1710.TYPESSelection
	$is_filtered:=False:C215
	For each ($vJ_filter; $vC_aj_filters)
		$vT_name:=$vJ_filter.t_name
		Case of 
			: ($vT_name="wor_TYPES")
				$vV_UID:=$vJ_filter.UID
				$is_filter:=($vV_UID#Null:C1517)
				If ($is_filter)
					$cES_TYPES:=ds:C1482.TYPES.newSelection()
					$cES_TYPES:=$cES_TYPES.add(ds:C1482.TYPES.get($vV_UID))
					$cES_TYPES:=wor_li_children_selection($cES_TYPES)
					$c4ES_selection_temp:=$c4ES_selection_temp.and($cES_TYPES.TYPES_PRODUCTS)
				End if 
				
				
			: ($vT_name="waz_isComponent")
				$vL_value:=$vJ_filter.v_value
				$is_filter:=($vL_value#2)
				If ($is_filter)
					$c4ES_selection_temp:=$c4ES_selection_temp.query("isComponent=:1"; ($vL_value=1))
				End if 
				
			: ($vT_name="waz_isCorner")
				$vL_value:=$vJ_filter.v_value
				$is_filter:=($vL_value#2)
				If ($is_filter)
					$c4ES_selection_temp:=$c4ES_selection_temp.query("isCorner=:1"; ($vL_value=1))
				End if 
				
			: ($vT_name="waz_isFree")
				$vL_value:=$vJ_filter.v_value
				$is_filter:=($vL_value#2)
				If ($is_filter)
					$c4ES_selection_temp:=$c4ES_selection_temp.query("isFree=:1"; ($vL_value=1))
				End if 
				
			: ($vT_name="waz_isSRC")
				$vL_value:=$vJ_filter.v_value
				$is_filter:=($vL_value#2)
				If ($is_filter)
					$c4ES_selection_temp:=$c4ES_selection_temp.query("isSRC=:1"; ($vL_value=1))
				End if 
				
			: ($vT_name="waz_isActive")
				$vL_value:=$vJ_filter.v_value
				$is_filter:=($vL_value#2)
				If ($is_filter)
					$c4ES_selection_temp:=$c4ES_selection_temp.query("isActive=:1"; ($vL_value=1))
				End if 
				
		End case 
		$is_filtered:=$is_filtered || $is_filter
	End for each 
	
	$c4ES_selection:=$is_filtered ? $c4ES_selection_temp : $c4ES_selection_in
	
	