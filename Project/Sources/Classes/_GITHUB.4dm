
property t_owner; t_token : Text

Class constructor
	var $vT_owner; $vT_token : Text
	var $c4Fi_github : 4D:C1709.File
	var $vJ_github : Object
	$c4Fi_github:=Folder:C1567(fk data folder:K87:12).file("github.json")
	If ($c4Fi_github.exists)
		$vJ_github:=JSON Parse:C1218($c4Fi_github.getText())
		$vT_owner:=$vJ_github.owner
		$vT_token:=$vJ_github.token
	End if 
	This:C1470.t_owner:=$vT_owner
	This:C1470.t_token:=$vT_token
	// *
	// *****
	
	
	// *****
	// *
Function uploadNewAsset($vT_repo : Text; $vT_tag : Text; $c4Fi_asset_zip : 4D:C1709.File)->$isOk : Boolean
	var $vJ_releaseInfo : Object
	var $vR_releaseID : Real
	$vJ_releaseInfo:=This:C1470.getReleaseInfo($vT_repo; $vT_tag)
	$isOk:=($vJ_releaseInfo#Null:C1517)
	If ($isOk)
		$vR_releaseID:=$vJ_releaseInfo.id
		$isOk:=(This:C1470.FindAndDeleteAsset($vT_repo; $vJ_releaseInfo; $c4Fi_asset_zip))
		If ($isOk)
			This:C1470.uploadAsset($vT_repo; $c4Fi_asset_zip; $vR_releaseID)
		End if 
	End if 
	// *
	// *****
	
	
	// *****
	// *
Function errorMng($c4HR_request : 4D:C1709.HTTPRequest; $vL_ok : Integer)->$isOk : Boolean
	var $vL_statut : Integer
	var $vJ_response : Object
	$vL_ok:=$vL_ok#0 ? $vL_ok : 200
	$vJ_response:=$c4HR_request.response
	$isOk:=($vJ_response#Null:C1517)
	If ($isOk)
		$vL_statut:=$vJ_response.status
		$isOk:=($vL_statut=$vL_ok)
		If (Not:C34($isOk))
			waz_io_alert_popup("Error "+String:C10($vL_statut)+", "+$vJ_response.body.message+"!")
		End if 
	Else 
		waz_io_alert_popup("Error Null!")
	End if 
	
	
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
	
	
Function FindAndDeleteAsset($vT_repo : Text; $vJ_releaseInfo : Object; $c4Fi_asset_zip : 4D:C1709.File)->$isOk : Boolean
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
	
	If ($vR_assetID#0)
		$vJ_delOptions:=New object:C1471()
		$vJ_delOptions.method:="DELETE"
		$vJ_delOptions.headers:=New object:C1471("Authorization"; "Bearer "+$vT_token; "Accept"; "application/vnd.github+json")
		$vT_url:="https://api.github.com/repos/"+$vT_owner+"/"+$vT_repo+"/releases/assets/"+String:C10($vR_assetID)
		$c4HR_request:=4D:C1709.HTTPRequest.new($vT_url; $vJ_delOptions).wait()
		// $request.response.status should be 204
		$isOk:=This:C1470.errorMng($c4HR_request; 204)
	End if 
	
	
Function uploadAsset($vT_repo : Text; $c4Fi_asset_zip : 4D:C1709.File; $vR_releaseID : Real)
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
	
	var $vJ_uploadResult; $vJ_upOptions : Object
	var $vX_asset : Blob
	var $vT_owner; $vT_token; $vT_filename; $vT_url : Text
	var $c4HR_request : 4D:C1709.HTTPRequest
	$vJ_uploadResult:=$c4HR_request.response.body
	// $uploadResult.browser_download_url now holds the public link
	// *
	// *****
	
	// *****
	// *
	// *
	// *****
	
	