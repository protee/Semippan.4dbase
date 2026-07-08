//%attributes = {"lang":"en"}

#DECLARE($cE_PATHS : cs:C1710.PATHSEntity)->$c4Fo_database : 4D:C1709.Folder
var $is_externalPath : Boolean
var $cE_PRODUCTS : cs:C1710.PRODUCTSEntity
var $vT_subPath : Text

If ($cE_PATHS#Null:C1517)
	$is_externalPath:=$cE_PATHS.isExternalPath
	If ($is_externalPath)
		If ($cE_PATHS.isMyPath)
			$c4Fo_database:=Folder:C1567(fk database folder:K87:14)
		Else 
			If ($cE_PATHS.path#"")
				$c4Fo_database:=Folder:C1567($cE_PATHS.path)
			End if 
		End if 
		
	Else 
		$cE_PRODUCTS:=$cE_PATHS.PATHS_PRODUCTS
		If ($cE_PRODUCTS.isMyPath)
			$c4Fo_database:=Folder:C1567(fk database folder:K87:14)
		Else 
			If ($cE_PRODUCTS.path#"")
				$c4Fo_database:=Folder:C1567($cE_PRODUCTS.path)
			End if 
		End if 
	End if 
End if 

If ($c4Fo_database#Null:C1517)
	$vT_subPath:=$cE_PATHS.subPath
	$c4Fo_database:=$vT_subPath#"" ? $c4Fo_database.folder($vT_subPath) : $c4Fo_database
End if 
