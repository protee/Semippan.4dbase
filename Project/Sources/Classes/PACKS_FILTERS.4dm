
Class extends ZENH_TABLES_FILTERS

Class constructor($vT_table : Text; $vL_table : Integer; $is_local : Boolean)
	var $vC_aj_filters : Collection
	var $vJ_params : Object
	Super:C1705($vT_table; $vL_table; $is_local)
	
	//This.j_edit:=OB Copy($vJ_params)
	
	$vJ_params:=New object:C1471
	$vC_aj_filters:=This:C1470.init_search()
	$vJ_params.aj_search:=$vC_aj_filters
	This:C1470.j_params:=$vJ_params
	This:C1470.set_widgets()
	
	
Function _filters_events()
	
	
	// *****
	// *
Function init_search()->$vC_aj_filters : Collection  // Filter's description
	$vC_aj_filters:=New collection:C1472
	$vC_aj_filters.push(This:C1470._get_search_c4ES("zen_products"; "PRODUCTS"))
	$vC_aj_filters.push(This:C1470._get_search_switch("waz_isActive"; True:C214))
	//This.clear_search($vC_aj_filters)
	
	
Function _filters()
	//cs.wox.TUNES.me.play_beep()
	This:C1470.get_widgets()
	CALL SUBFORM CONTAINER:C1086(k_OnDataChange)
	
	
Function DO_filters($c4ES_selection_in : 4D:C1709.EntitySelection)->$c4ES_selection : 4D:C1709.EntitySelection
	var $c4ES_selection_temp : 4D:C1709.EntitySelection
	var $is_filtered; $is_filter : Boolean
	var $vC_aj_filters; $vC_aj_filters_in : Collection
	var $cES_PACKS : cs:C1710.PACKSSelection
	var $cES_PRODUCTS : cs:C1710.PRODUCTSSelection
	var $vL_value : Integer
	var $vJ_filter : Object
	var $vT_name : Text
	$vC_aj_filters:=$vC_aj_filters_in=Null:C1517 ? This:C1470._get_aj_search() : $vC_aj_filters_in
	
	$c4ES_selection_temp:=$c4ES_selection_in
	//$vC_query:=New collection()
	
	$is_filtered:=False:C215
	For each ($vJ_filter; $vC_aj_filters)
		$vT_name:=$vJ_filter.t_name
		Case of 
			: ($vT_name="zen_products")
				$cES_PRODUCTS:=$vJ_filter.c4ES
				$is_filter:=($cES_PRODUCTS#Null:C1517) && ($cES_PRODUCTS.length#0)
				If ($is_filter)
					$cES_PACKS:=$cES_PRODUCTS.PRODUCTS_PATHS.PATHS_PACKS
					$c4ES_selection_temp:=$c4ES_selection_temp.and($cES_PACKS)
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
	
	