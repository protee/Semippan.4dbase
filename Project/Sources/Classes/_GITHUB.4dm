
property t_owner; t_token : Text

Class constructor
	var $vT_owner; $vT_token : Text
	var $c4Fi_github : 4D:C1709.File
	var $vJ_github : Object
	$cE_ZEN_DASHBOARD:=ds:C1482.ZEN_DASHBOARD.all().first()
	$vJ_biz:=$cE_ZEN_DASHBOARD.j_biz
	$vT_owner:=$vJ_biz.t_github
	
	//$c4Fi_github:=Folder(fk data folder).file("github.json")
	//If ($c4Fi_github.exists)
	//$vJ_github:=JSON Parse($c4Fi_github.getText())
	//$vT_owner:=$vJ_github.owner
	//$vT_token:=$vJ_github.token
	//End if 
	
	$vT_system:=System folder:C487(User preferences_user:K41:4)
	$c4Fo_prefs4D:=Folder:C1567($vT_system; fk platform path:K87:2).folder("4D")
	$c4Fi_github:=$c4Fo_prefs4D.file("github.json")
	If ($c4Fi_github.exists)
		$vJ_github:=JSON Parse:C1218($c4Fi_github.getText())
		$vT_token:=$vJ_github.token
	End if 
	
	This:C1470.t_owner:=$vT_owner
	This:C1470.t_token:=$vT_token
	// *
	// *****
	
	
	// *****
	// *
Function newReleaseNewAsset($vT_repo : Text; $vT_tag : Text; $c4Fi_asset_zip : 4D:C1709.File; $is_silent : Boolean; $vT_releaseName : Text; $vT_releaseNotes : Text)->$isOk : Boolean
	var $vR_releaseID : Real
	var $vJ_releaseInfo : Object
	$vJ_releaseInfo:=This:C1470.newRelease($vT_repo; $vT_tag; $is_silent; $vT_releaseName; $vT_releaseNotes)
	$isOk:=($vJ_releaseInfo#Null:C1517)
	If ($isOk)
		$vR_releaseID:=$vJ_releaseInfo.id
		This:C1470.uploadAsset($vT_repo; $vR_releaseID; $c4Fi_asset_zip; $is_silent)
	End if 
	
	
Function uploadNewAsset($vT_repo : Text; $vT_tag : Text; $c4Fi_asset_zip : 4D:C1709.File; $is_silent : Boolean)->$isOk : Boolean
	var $vJ_releaseInfo : Object
	var $vR_releaseID : Real
	$vJ_releaseInfo:=This:C1470.getReleaseInfo($vT_repo; $vT_tag)
	$isOk:=($vJ_releaseInfo#Null:C1517)
	If ($isOk)
		$vR_releaseID:=$vJ_releaseInfo.id
		$isOk:=(This:C1470.findAndDeleteAsset($vT_repo; $vJ_releaseInfo; $c4Fi_asset_zip; $is_silent))
		If ($isOk)
			This:C1470.uploadAsset($vT_repo; $vR_releaseID; $c4Fi_asset_zip; $is_silent)
		End if 
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function errorMng($c4HR_request : 4D:C1709.HTTPRequest; $is_silent : Boolean; $vL_ok : Integer)->$isOk : Boolean
	var $vL_statut : Integer
	var $vJ_response : Object
	$vL_ok:=$vL_ok#0 ? $vL_ok : 200
	$vJ_response:=$c4HR_request.response
	$isOk:=($vJ_response#Null:C1517)
	If ($isOk)
		$vL_statut:=$vJ_response.status
		$isOk:=($vL_statut=$vL_ok)
		If (Not:C34($isOk))
			If (Not:C34($is_silent))
				waz_io_alert_popup("Error "+String:C10($vL_statut)+", "+$vJ_response.body.message+"!")
			End if 
		End if 
	Else 
		If (Not:C34($is_silent))
			waz_io_alert_popup("Error Null!")
		End if 
	End if 
	
	
	// *****
	// *
Function getReleaseInfo($vT_repo : Text; $vT_tag : Text)->$vJ_releaseInfo : Object
	var $c4HR_request : 4D:C1709.HTTPRequest
	var $vJ_options : Object
	var $vT_owner; $vT_token; $vT_url : Text
	
	$vT_owner:=This:C1470.t_owner
	$vT_token:=This:C1470.t_token
	
	$vJ_options:=New object:C1471()
	$vJ_options.method:="GET"
	$vJ_options.headers:=New object:C1471("Authorization"; "Bearer "+$vT_token; "Accept"; "application/vnd.github+json")
	$vT_url:="https://api.github.com/repos/"+$vT_owner+"/"+$vT_repo+"/releases/tags/"+$vT_tag
	$c4HR_request:=4D:C1709.HTTPRequest.new($vT_url; $vJ_options).wait()
	If (This:C1470.errorMng($c4HR_request))
		$vJ_releaseInfo:=$c4HR_request.response.body
	End if 
	
	
Function getRepoTags($vT_repo : Text; $is_silent : Boolean)->$vC_at_tags : Collection
	var $c4HR_request : 4D:C1709.HTTPRequest
	var $vJ_options : Object
	var $vT_owner; $vT_token; $vT_url : Text
	$vT_owner:=This:C1470.t_owner
	$vT_token:=This:C1470.t_token
	
	$vJ_options:=New object:C1471()
	$vJ_options.method:="GET"
	$vJ_options.headers:=New object:C1471("Authorization"; "Bearer "+$vT_token; "Accept"; "application/vnd.github+json")
	$vT_url:="https://api.github.com/repos/"+$vT_owner+"/"+$vT_repo+"/tags"
	$c4HR_request:=4D:C1709.HTTPRequest.new($vT_url; $vJ_options).wait()
	If (This:C1470.errorMng($c4HR_request; $is_silent))
		$vC_at_tags:=$c4HR_request.response.body.extract("name")  // array response should come back as a Collection
	End if 
	
	
	
Function newRelease($vT_repo : Text; $vT_tag : Text; $is_silent : Boolean; $vT_releaseName : Text; $vT_releaseNotes : Text)->$vJ_releaseInfo : Object
	$vT_owner:=This:C1470.t_owner
	$vT_token:=This:C1470.t_token
	
	$vT_releaseName:=$vT_releaseName#"" ? $vT_releaseName : $vT_tag
	$vT_releaseNotes:=$vT_releaseNotes#"" ? $vT_releaseNotes : "Release notes for "+$vT_tag
	
	var $vJ_body; $vJ_options : Object
	var $c4HR_request : 4D:C1709.HTTPRequest
	var $vT_owner; $vT_token; $vT_url : Text
	$vJ_body:=New object:C1471()
	$vJ_body.tag_name:=$vT_tag
	$vJ_body.name:=$vT_releaseName
	$vJ_body.body:=$vT_releaseNotes
	$vJ_body.draft:=False:C215
	$vJ_body.prerelease:=False:C215
	
	$vJ_options:=New object:C1471()
	$vJ_options.method:="POST"
	$vJ_options.headers:=New object:C1471("Authorization"; "Bearer "+$vT_token; "Accept"; "application/vnd.github+json")
	$vJ_options.body:=$vJ_body
	$vT_url:="https://api.github.com/repos/"+$vT_owner+"/"+$vT_repo+"/releases"
	$c4HR_request:=4D:C1709.HTTPRequest.new($vT_url; $vJ_options).wait()
	If (This:C1470.errorMng($c4HR_request; $is_silent; 201))
		$vJ_releaseInfo:=$c4HR_request.response.body
	End if 
	
	
Function findAndDeleteAsset($vT_repo : Text; $vJ_releaseInfo : Object; $c4Fi_asset_zip : 4D:C1709.File; $is_silent : Boolean)->$isOk : Boolean
	var $c4HR_request : 4D:C1709.HTTPRequest
	var $vJ_asset; $vJ_delOptions : Object
	var $vT_owner; $vT_token; $vT_filename; $vT_url : Text
	var $vR_assetID : Real
	
	$vT_owner:=This:C1470.t_owner
	$vT_token:=This:C1470.t_token
	$vT_filename:=$c4Fi_asset_zip.fullName
	For each ($vJ_asset; $vJ_releaseInfo.assets)
		If ($vJ_asset.name=($vT_filename))
			$vR_assetID:=$vJ_asset.id
			break
		End if 
	End for each 
	
	$isOk:=$vR_assetID=0  // Not found, ok
	If (Not:C34($isOk))
		$vJ_delOptions:=New object:C1471()
		$vJ_delOptions.method:="DELETE"
		$vJ_delOptions.headers:=New object:C1471("Authorization"; "Bearer "+$vT_token; "Accept"; "application/vnd.github+json")
		$vT_url:="https://api.github.com/repos/"+$vT_owner+"/"+$vT_repo+"/releases/assets/"+String:C10($vR_assetID)
		$c4HR_request:=4D:C1709.HTTPRequest.new($vT_url; $vJ_delOptions).wait()
		$isOk:=This:C1470.errorMng($c4HR_request; $is_silent; 204)
	End if 
	
	
Function uploadAsset($vT_repo : Text; $vR_releaseID : Real; $c4Fi_asset_zip : 4D:C1709.File; $is_silent : Boolean)
	var $vJ_uploadResult; $vJ_upOptions : Object
	var $vX_asset : Blob
	var $vT_owner; $vT_token; $vT_filename; $vT_url : Text
	var $c4HR_request : 4D:C1709.HTTPRequest
	$vT_owner:=This:C1470.t_owner
	$vT_token:=This:C1470.t_token
	
	$vT_filename:=$c4Fi_asset_zip.fullName
	$vX_asset:=$c4Fi_asset_zip.getContent()
	$vJ_upOptions:=New object:C1471()
	$vJ_upOptions.method:="POST"
	$vJ_upOptions.headers:=New object:C1471("Authorization"; "Bearer "+$vT_token; "Content-Type"; "application/zip")
	$vJ_upOptions.body:=$vX_asset
	$vT_url:="https://uploads.github.com/repos/"+$vT_owner+"/"+$vT_repo+"/releases/"+String:C10($vR_releaseID)+"/assets?name="+$vT_filename
	$c4HR_request:=4D:C1709.HTTPRequest.new($vT_url; $vJ_upOptions).wait()
	$vJ_uploadResult:=$c4HR_request.response.body
	// $uploadResult.browser_download_url now holds the public link
	// *
	// *****
	
	
	// *****
	// *
Function do_cleanup($cE_PRODUCTS : cs:C1710.PRODUCTSEntity; $is_silent : Boolean)
	var $c4Fi_gato; $c4Fi_SRC; $c4Fi_OLD_SRC : 4D:C1709.File
	var $c4Fo_root; $c4Fo_OLD; $c4Fo_build; $c4Fo_bundle; $c4Fo_gato; $c4Fo_gato_bundle : 4D:C1709.Folder
	var $c4Fo_database : 4D:C1709.Folder
	var $isOk : Boolean
	var $vC_fi_SRC : Collection
	var $vT_subtitle; $vT_bundle; $vT_name; $vT_repo : Text
	$c4Fo_database:=This:C1470.get_path($cE_PRODUCTS)
	If ($c4Fo_database.exists)
		$vT_repo:=$cE_PRODUCTS.label
		$vT_subtitle:=""
		// SRC into "*OLD"
		$c4Fo_root:=$c4Fo_database.folder("../")
		$c4Fo_OLD:=$c4Fo_root.folder("*OLD")
		If ($c4Fo_OLD.exists)
			$vC_fi_SRC:=$c4Fo_root.files()
			$vC_fi_SRC:=$vC_fi_SRC.query("fullName = :1"; "@"+$vT_repo+"@ SRC.zip")
			If ($vC_fi_SRC.length#0)
				$vT_subtitle+="SRC: "+$vC_fi_SRC.extract("fullName").join(", ")+Char:C90(Carriage return:K15:38)
			End if 
		End if 
		
		// Bundle into "4D v21 Gato"
		$c4Fo_build:=This:C1470.get_build_path($cE_PRODUCTS)
		$isOk:=($c4Fo_build#Null:C1517) && ($c4Fo_build.exists)
		If ($isOk)
			$vT_bundle:=$vT_repo+".4dbase"
			$c4Fo_bundle:=$c4Fo_build.folder($vT_bundle)
			$c4Fi_gato:=$c4Fo_build.file("4D v21 Gato")
			If ($c4Fi_gato.exists)
				$c4Fo_gato:=$c4Fi_gato.original
			End if 
			If ($c4Fo_bundle.exists) && ($c4Fo_gato.exists)
				$vT_subtitle+="Bundle: "+$c4Fo_bundle.fullName
			End if 
		End if 
		
		If ($vT_subtitle="")
			If (Not:C34($is_silent))
				waz_io_alert_popup($vT_repo+" is already cleaned!")
			End if 
		Else 
			$isOk:=True:C214
			If (Not:C34($is_silent))
				$isOk:=waz_io_confirm("Clean up all built files moving them?"; $vT_subtitle)
			End if 
			If ($isOk)
				// SRC into "*OLD"
				For each ($c4Fi_SRC; $vC_fi_SRC)
					$vT_name:=$c4Fi_SRC.fullName
					$c4Fi_OLD_SRC:=$c4Fo_OLD.file($vT_name)
					If ($c4Fi_OLD_SRC.exists)
						$c4Fi_OLD_SRC.delete()
					End if 
					$c4Fi_SRC.moveTo($c4Fo_OLD)
				End for each 
				
				// Bundle into "4D v21 Gato"
				$c4Fo_gato_bundle:=$c4Fo_gato.folder($vT_bundle)
				If ($c4Fo_gato_bundle.exists)
					$c4Fo_gato_bundle.delete(Delete with contents:K24:24)
				End if 
				$c4Fo_bundle.moveTo($c4Fo_gato)
			End if 
		End if 
	Else 
		BEEP:C151
	End if 
	
	
Function get_path($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$c4Fo_database : 4D:C1709.Folder
	If ($cE_PRODUCTS.isMyPath)
		$c4Fo_database:=Folder:C1567(fk database folder:K87:14)
	Else 
		If ($cE_PRODUCTS.path#"")
			$c4Fo_database:=Try(Folder:C1567($cE_PRODUCTS.path))
		End if 
	End if 
	
	
Function get_build_path($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$c4Fo_build : 4D:C1709.Folder
	var $c4Fo_database; $c4Fo_parent : 4D:C1709.Folder
	$c4Fo_database:=This:C1470.get_path($cE_PRODUCTS)
	If ($c4Fo_database.exists)
		$c4Fo_parent:=$c4Fo_database.parent
		$c4Fo_parent:=$c4Fo_parent#Null:C1517 ? $c4Fo_parent : Folder:C1567($c4Fo_database.platformPath; fk platform path:K87:2).parent
		$c4Fo_build:=$c4Fo_parent.folder($cE_PRODUCTS.label+"_Build/Components/")
	End if 
	
	
Function getInfoPlistVersion($cE_PRODUCTS : cs:C1710.PRODUCTSEntity)->$vT_bundle_tag : Text
	var $c4Fi_infoPlist : 4D:C1709.File
	var $isOk : Boolean
	var $vJ_info : Object
	var $vT_repo : Text
	var $c4Fo_build; $c4Fo_bundle : 4D:C1709.Folder
	$vT_repo:=$cE_PRODUCTS.label
	$c4Fo_build:=This:C1470.get_build_path($cE_PRODUCTS)
	$c4Fo_bundle:=$c4Fo_build.folder($vT_repo+".4dbase")
	$isOk:=$c4Fo_bundle.exists
	If ($isOk)
		$c4Fi_infoPlist:=$c4Fo_bundle.file("Contents/Info.plist")
		$isOk:=($c4Fi_infoPlist.exists)
		If ($isOk)
			$vJ_info:=$c4Fi_infoPlist.getAppInfo()
			$vT_bundle_tag:=$vJ_info.CFBundleVersion
		End if 
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function getBundleCacheTag_fo($cE_PRODUCTS : cs:C1710.PRODUCTSEntity; $vT_tag : Text)->$c4Fo_cache_tag : 4D:C1709.Folder
	var $c4Fo_cache; $c4Fo_cache_owner; $c4Fo_cache_repo : 4D:C1709.Folder
	var $vT_owner; $vT_repo : Text
	$vT_owner:=This:C1470.t_owner
	$vT_repo:=$cE_PRODUCTS.label
	$c4Fo_cache:=Folder:C1567(fk home folder:K87:24).folder((Is macOS:C1572 ? "Library/" : "AppData/")+"Caches/4D/Dependencies/.github")
	$c4Fo_cache_owner:=$c4Fo_cache.folder($vT_owner)
	$c4Fo_cache_repo:=$c4Fo_cache_owner.folder($vT_repo)
	$c4Fo_cache_tag:=$c4Fo_cache_repo.folder($vT_tag)
	
	
Function deleteBundleCacheTag($cE_PRODUCTS : cs:C1710.PRODUCTSEntity; $vT_tag : Text)
	var $c4Fo_cache_tag : 4D:C1709.Folder
	$c4Fo_cache_tag:=This:C1470.getBundleCacheTag_fo($cE_PRODUCTS; $vT_tag)
	If ($c4Fo_cache_tag.exists)
		$c4Fo_cache_tag.delete(Delete with contents:K24:24)
	End if 
	// *
	// *****
	
	