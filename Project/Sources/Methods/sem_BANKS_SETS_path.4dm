//%attributes = {}

#DECLARE($c4Fo_root : 4D:C1709.Folder; $cE_BANKS : cs:C1710.BANKSEntity; $cE_SETS : cs:C1710.SETSEntity)->$c4Fo_path : 4D:C1709.Folder
var $vT_subpath : Text
var $is_PATHS_external : Boolean

If ($c4Fo_root#Null:C1517)
	//$c4Fo_path:=$c4Fo_root
	//If ($cE_BANKS#Null)
	//$vT_subpath:=$cE_BANKS.subPath
	//$c4Fo_path:=$vT_subpath#"" ? $c4Fo_path.folder($vT_subpath) : $c4Fo_path
	//If ($cE_SETS#Null)
	//$vT_subpath:=$cE_SETS.subPath
	//$c4Fo_path:=$vT_subpath#"" ? $c4Fo_path.folder($vT_subpath) : $c4Fo_path
	//End if 
	//End if 
	
	$c4Fo_path:=$c4Fo_root
	If ($cE_BANKS#Null:C1517)
		If ($cE_SETS#Null:C1517)
			$is_PATHS_external:=$cE_SETS.j_options.isExternalPath
			If (Not:C34($is_PATHS_external))
				$vT_subpath:=$cE_BANKS.subPath
				$c4Fo_path:=$vT_subpath#"" ? $c4Fo_path.folder($vT_subpath) : $c4Fo_path
			End if 
			$vT_subpath:=$cE_SETS.subPath
			$c4Fo_path:=$vT_subpath#"" ? $c4Fo_path.folder($vT_subpath) : $c4Fo_path
		Else 
			$vT_subpath:=$cE_BANKS.subPath
			$c4Fo_path:=$vT_subpath#"" ? $c4Fo_path.folder($vT_subpath) : $c4Fo_path
		End if 
	End if 
End if 

