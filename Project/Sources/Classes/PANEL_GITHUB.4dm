
property j_repos : Object  // Cache for repos
property t_progress_uuid : Text
property t_github : Text

Class constructor
	zen_startup_screen_get_menuBar()
	wox_prefs_windows_load()
	This:C1470.form_init()
	
	
	// *****
	// *
Function form_events()
	var $vL_event_code : Integer
	var $vJ_formEvent : Object
	var $vT_objectName : Text
	var $cES_PRODUCTS_in; $cES_PRODUCTS : cs:C1710.PRODUCTSSelection
	
	$vL_event_code:=Form event code:C388
	$vJ_formEvent:=FORM Event:C1606
	$vT_objectName:=$vJ_formEvent.objectName
	
	Case of 
		: ($vL_event_code=On Unload:K2:2)
			wox_prefs_windows_save()
			
		: ($vL_event_code=On Close Box:K2:21)
			CANCEL:C270
			
		: ($vL_event_code=On Clicked:K2:4)
			Case of 
				: ($vT_objectName="bt_refresh")
					$cES_PRODUCTS_in:=Form:C1466.lb_selection
					$cES_PRODUCTS:=Form:C1466.lb_selected
					$cES_PRODUCTS:=zen_choice_selection($cES_PRODUCTS_in; $cES_PRODUCTS)
					If ($cES_PRODUCTS#Null:C1517)
						This:C1470.loadReposCache($cES_PRODUCTS; True:C214)
					End if 
					
				: ($vT_objectName="bt_github")
					This:C1470._do_github()
					
				: ($vT_objectName="bt_cleanup")
					This:C1470._do_cleanup()
					
					//: ($vT_objectName="bt_save")
					//This._do_settings_save()
					
					
			End case 
			
			
			//: ($vL_event_code=On Double Clicked)
			
		: ($vL_event_code=On Resize:K2:27)
			////SET TIMER(0)
			//This.D4corner_resize()
			
		: ($vL_event_code=On Timer:K2:25)
			This:C1470.progress_close()
			
	End case 
	// *
	// *****
	
	
Function form_init()
	// { "repo" : { o_logo, at_keys, t_key }
	This:C1470.j_repos:=New object:C1471()  // Cache for repos
	This:C1470.record_load_upd()
	
	
Function record_load_upd()
	var $cE_ZEN_DASHBOARD : cs:C1710.ZEN_DASHBOARDEntity
	var $vJ_biz : Object
	var $vT_github : Text
	var $cES_PRODUCTS : cs:C1710.PRODUCTSSelection
	
	$cE_ZEN_DASHBOARD:=ds:C1482.ZEN_DASHBOARD.all().first()
	$vJ_biz:=$cE_ZEN_DASHBOARD.j_biz
	$vT_github:=$vJ_biz.t_github
	This:C1470.t_github:=$vT_github
	
	$cES_PRODUCTS:=ds:C1482.PRODUCTS.query("isGithub = :1"; True:C214)
	$cES_PRODUCTS:=$cES_PRODUCTS.orderBy("label")
	This:C1470.loadReposCache($cES_PRODUCTS)
	Form:C1466.lb_selection:=$cES_PRODUCTS
	
	
Function loadReposCache($cES_PRODUCTS : cs:C1710.PRODUCTSSelection; $is_recache : Boolean)
	var $vC_at_tags : Collection
	var $cs__github : cs:C1710._GITHUB
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $idx; $vL_state : Integer
	var $vJ_repos; $vJ_repo : Object
	var $vO_logo : Picture
	var $vT_repo; $vT_tag; $vT_gtag : Text
	
	$cES_PRODUCTS:=$cES_PRODUCTS#Null:C1517 ? $cES_PRODUCTS : Form:C1466.lb_selection
	$cs__github:=cs:C1710._GITHUB.new()
	$vJ_repos:=This:C1470.j_repos  // Cache
	For each ($cE_PRODUCTS; $cES_PRODUCTS)
		$vT_repo:=$cE_PRODUCTS.label
		
		$vJ_repo:=$vJ_repos[$vT_repo]
		If ($vJ_repo=Null:C1517) || $is_recache
			This:C1470.progress_title($vT_repo; "Cache...")
			If ($vJ_repo=Null:C1517)
				$vJ_repo:=New object:C1471()
				$vJ_repos[$vT_repo]:=$vJ_repo
			End if 
			
			$vO_logo:=$cE_PRODUCTS.logo
			$vJ_repo.o_logo:=$vO_logo
			//If (Not($is_recache))
			//$vT_path_logo:="https://www.protee.org/images/"+$vT_repo+"/"+$vT_repo+".png"
			//$vL_httpStatus:=HTTP Get($vT_path_logo; $vO_logo)
			//If ($vL_httpStatus=200)
			//$vJ_repo.o_logo:=$vO_logo
			//End if 
			//End if 
			This:C1470.progress_logo($vO_logo)
			
			$vT_tag:=$cs__github.getInfoPlistVersion($cE_PRODUCTS)
			$vJ_repo.t_tag:=$vT_tag
			$vC_at_tags:=$cs__github.getRepoTags($vT_repo)
			$vJ_repo.at_tag:=$vC_at_tags
			
			If ($vC_at_tags#Null:C1517)
				$idx:=$vC_at_tags.indexOf($vT_tag)
				$vT_gtag:=$idx>=0 ? "->"+$vT_tag : "---"
			End if 
			$vJ_repo.t_gtag:=$vT_gtag
			
			Case of 
				: $vT_tag=""  // No bundle
					$vL_state:=0
					
				: $vC_at_tags=Null:C1517  // Error
					$vL_state:=1
					
				: $idx>=0  // Upload
					$vL_state:=2
					
				Else 
					$vL_state:=3  // New
			End case 
			$vJ_repo.l_state:=$vL_state
		End if 
	End for each 
	Form:C1466.lb_selection:=Form:C1466.lb_selection
	
	
	
Function lb_get_tag($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$vT_answer : Text
	var $vJ_repos; $vJ_repo : Object
	var $vT_repo : Text
	$vT_repo:=$cE_PRODUCTS.label
	$vJ_repos:=This:C1470.j_repos  // Cache
	$vJ_repo:=$vJ_repos[$vT_repo]
	If ($vJ_repo=Null:C1517)
		$vT_answer:="No cache"
	Else 
		$vT_answer:=$vJ_repo.t_tag  // Bundle
		If ($vT_answer="")
			$vT_answer:="No bundle"
		End if 
	End if 
	
	
Function lb_get_gtag($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$vT_gtag : Text
	var $vJ_repos; $vJ_repo : Object
	var $vT_repo : Text
	$vT_repo:=$cE_PRODUCTS.label
	$vJ_repos:=This:C1470.j_repos  // Cache
	$vJ_repo:=$vJ_repos[$vT_repo]
	If ($vJ_repo#Null:C1517)
		//$vC_at_tags:=$vJ_repo.at_tag
		//$vT_tag:=$vJ_repo.t_tag  // Bundle
		//$idx:=$vC_at_tags.indexOf($vT_tag)
		//$vT_answer:=$idx>=0 ? "->"+$vT_tag : ""
		
		$vT_gtag:=$vJ_repo.t_gtag
	End if 
	
	
	//Form.fc.lb_get_logo_icn(This)
Function lb_get_logo_icn($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$vO_logo : Picture
	var $vT_repo : Text
	var $vJ_repos; $vJ_repo : Object
	var $isOk : Boolean
	$vT_repo:=$cE_PRODUCTS.label
	$vJ_repos:=This:C1470.j_repos  // Cache
	$vJ_repo:=$vJ_repos[$vT_repo]
	$isOk:=($vJ_repo#Null:C1517)
	If ($isOk)
		$vO_logo:=$vJ_repo.o_logo
	End if 
	
	
Function lb_get_state_icn($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$vO_state : Picture
	var $vL_state : Integer
	var $c4Fi_icon : 4D:C1709.File
	var $vJ_repos; $vJ_repo : Object
	var $vT_repo : Text
	
	$vT_repo:=$cE_PRODUCTS.label
	$vJ_repos:=This:C1470.j_repos  // Cache
	$vJ_repo:=$vJ_repos[$vT_repo]
	$vL_state:=$vJ_repo.l_state
	$c4Fi_icon:=Folder:C1567(fk resources folder:K87:11).file("github/icn_state"+String:C10($vL_state)+k_png_ext)
	READ PICTURE FILE:C678($c4Fi_icon.platformPath; $vO_state)
	// *
	// *****
	
	
	
	// *****
	// *
Function progress_new()->$vT_progress_uuid : Text
	$vT_progress_uuid:=This:C1470.t_progress_uuid
	If ($vT_progress_uuid="")
		$vT_progress_uuid:=waz_progress_new()
		This:C1470.t_progress_uuid:=$vT_progress_uuid
		SET TIMER:C645(30)
	End if 
	
	
Function progress_title($vT_title : Text; $vT_subtitle : Text)
	var $vT_progress_uuid : Text
	$vT_progress_uuid:=This:C1470.progress_new()
	If ($vT_progress_uuid#"")
		//waz_progress_subtitle($vT_progress_uuid; $vT_label)
		waz_progress_title($vT_progress_uuid; $vT_title; $vT_subtitle)
	End if 
	
Function progress_logo($vO_logo : Picture)
	var $vT_progress_uuid : Text
	$vT_progress_uuid:=This:C1470.progress_new()
	If ($vT_progress_uuid#"")
		waz_progress_setIcon($vT_progress_uuid; $vO_logo)
	End if 
	
Function progress_close()
	var $vT_progress_uuid : Text
	$vT_progress_uuid:=This:C1470.t_progress_uuid
	If ($vT_progress_uuid#"")
		waz_progress_quit($vT_progress_uuid)
		This:C1470.t_progress_uuid:=""
		SET TIMER:C645(0)
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function _do_github()
	var $c4Fi_asset_zip : 4D:C1709.File
	var $c4Fo_build : 4D:C1709.Folder
	var $isOk : Boolean
	var $cs__github : cs:C1710._GITHUB
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $cES_PRODUCTS_in; $cES_PRODUCTS : cs:C1710.PRODUCTSSelection
	var $tt; $vL_state : Integer
	var $vJ_repos; $vJ_repo : Object
	var $vT_repo; $vT_tag; $vT_releaseName; $vT_releaseNotes : Text
	var $vO_logo : Picture
	$cES_PRODUCTS_in:=Form:C1466.lb_selection
	$cES_PRODUCTS:=Form:C1466.lb_selected
	$cES_PRODUCTS:=zen_choice_selection($cES_PRODUCTS_in; $cES_PRODUCTS)
	If ($cES_PRODUCTS#Null:C1517)
		$tt:=$cES_PRODUCTS.length
		$cs__github:=cs:C1710._GITHUB.new()
		$vJ_repos:=This:C1470.j_repos  // Cache
		For each ($cE_PRODUCTS; $cES_PRODUCTS)
			$vT_repo:=$cE_PRODUCTS.label
			$vJ_repo:=$vJ_repos[$vT_repo]
			If ($vJ_repo#Null:C1517)
				$vL_state:=$vJ_repo.l_state
				$vT_tag:=$vJ_repo.t_tag
				$isOk:=($vT_repo#"") && ($vT_tag#"")
				If ($isOk)
					$c4Fo_build:=$cs__github.get_build_path($cE_PRODUCTS)
					$isOk:=($c4Fo_build#Null:C1517) && ($c4Fo_build.exists)
					If ($isOk)
						Case of 
							: $vL_state=2  // Upload
								This:C1470.progress_title($vT_repo; "Upload zip asset bundle...")
								$vO_logo:=$cE_PRODUCTS.logo
								This:C1470.progress_logo($vO_logo)
								$c4Fi_asset_zip:=$c4Fo_build.folder("../"+$vT_repo).file($vT_repo+".zip")
								If ($c4Fi_asset_zip.exists)
									$isOk:=$cs__github.uploadNewAsset($vT_repo; $vT_tag; $c4Fi_asset_zip)
									If ($isOk)
										$vJ_repo.l_state:=4  // OK
										cs:C1710.wox.SOUNDS.me.play_glop()
									End if 
								Else 
									waz_io_alert_popup("No build file at: "+$c4Fi_asset_zip.path)
									cs:C1710.wox.SOUNDS.me.play_glop_no()
								End if 
								
							: $vL_state=3  // New Release
								This:C1470.progress_title($vT_repo; "Create release & Upload zip...")
								$vO_logo:=$cE_PRODUCTS.logo
								This:C1470.progress_logo($vO_logo)
								$c4Fi_asset_zip:=$c4Fo_build.folder("../"+$vT_repo).file($vT_repo+".zip")
								If ($c4Fi_asset_zip.exists)
									$isOk:=$cs__github.newReleaseNewAsset($vT_repo; $vT_tag; $vT_releaseName; $vT_releaseNotes; $c4Fi_asset_zip)
									If ($isOk)
										$vJ_repo.l_state:=4  // OK
										cs:C1710.wox.SOUNDS.me.play_glop()
									End if 
								Else 
									waz_io_alert_popup("No build file at: "+$c4Fi_asset_zip.path)
									cs:C1710.wox.SOUNDS.me.play_glop_no()
								End if 
						End case 
					End if 
				End if 
			End if 
		End for each 
		Form:C1466.lb_selection:=Form:C1466.lb_selection
	End if 
	
	
Function _do_cleanup()
	var $isOk : Boolean
	var $cs__github : cs:C1710._GITHUB
	var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
	var $cES_PRODUCTS_in; $cES_PRODUCTS : cs:C1710.PRODUCTSSelection
	var $tt; $vL_state : Integer
	var $vJ_repos; $vJ_repo : Object
	var $vT_repo; $vT_tag : Text
	var $vO_logo : Picture
	
	$cES_PRODUCTS_in:=Form:C1466.lb_selection
	$cES_PRODUCTS:=Form:C1466.lb_selected
	$cES_PRODUCTS:=zen_choice_selection($cES_PRODUCTS_in; $cES_PRODUCTS)
	If ($cES_PRODUCTS#Null:C1517)
		$tt:=$cES_PRODUCTS.length
		$cs__github:=cs:C1710._GITHUB.new()
		$vJ_repos:=This:C1470.j_repos  // Cache
		For each ($cE_PRODUCTS; $cES_PRODUCTS)
			$vT_repo:=$cE_PRODUCTS.label
			$vJ_repo:=$vJ_repos[$vT_repo]
			If ($vJ_repo#Null:C1517)
				$vL_state:=$vJ_repo.l_state
				$vT_tag:=$vJ_repo.t_tag
				$isOk:=($vT_repo#"") && ($vT_tag#"")
				If ($isOk)
					If ($vL_state=4)  // Done, ready to cleanup
						This:C1470.progress_title($vT_repo; "Clean up disk for "+$vT_repo+"...")
						$vO_logo:=$cE_PRODUCTS.logo
						This:C1470.progress_logo($vO_logo)
						$cs__github.do_cleanup($cE_PRODUCTS; True:C214)
						$cs__github.deleteBundleCacheTag($cE_PRODUCTS; $vT_tag)
						//$vJ_repo.l_state:=0 // No bundle
					End if 
				End if 
			End if 
		End for each 
		This:C1470.loadReposCache($cES_PRODUCTS; True:C214)
		Form:C1466.lb_selection:=Form:C1466.lb_selection
	End if 
	// *
	// *****
	
	