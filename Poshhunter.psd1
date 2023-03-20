<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.160
	 Created on:   	4/13/2019 9:46 AM
	 Created by:   	whiggs
	 Organization: 	
	 Filename:     	Poshhunter.psd1
	 -------------------------------------------------------------------------
	 Module Manifest
	-------------------------------------------------------------------------
	 Module Name: Poshhunter
	===========================================================================
#>


@{
	
	# Script module or binary module file associated with this manifest
	ModuleToProcess = 'Poshhunter.psm1'
	
	# Version number of this module.
	ModuleVersion = '1.0.0.5'
	
	# ID used to uniquely identify this module
	GUID = 'ca30fab1-58f4-4ce1-b5e4-1c5bd887b7da'
	
	# Author of this module
	Author = 'William H'
	
	# Company or vendor of this module
	CompanyName = 'me'
	
	# Copyright statement for this module
	Copyright = '(c) 2019. All rights reserved.'
	
	# Description of the functionality provided by this module
	Description = 'This is a powershell module to interact with the hunter.io api'
	
	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '2.0'
	
	# Name of the Windows PowerShell host required by this module
	PowerShellHostName = ''
	
	# Minimum version of the Windows PowerShell host required by this module
	PowerShellHostVersion = ''
	
	# Minimum version of the .NET Framework required by this module
	DotNetFrameworkVersion = '2.0'
	
	# Minimum version of the common language runtime (CLR) required by this module
	CLRVersion = '2.0.50727'
	
	# Processor architecture (None, X86, Amd64, IA64) required by this module
	ProcessorArchitecture = 'None'
	
	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules = @()
	
	# Assemblies that must be loaded prior to importing this module
	RequiredAssemblies = @()
	
	# Script files (.ps1) that are run in the caller's environment prior to
	# importing this module
	ScriptsToProcess = @()
	
	# Type files (.ps1xml) to be loaded when importing this module
	TypesToProcess = @()
	
	# Format files (.ps1xml) to be loaded when importing this module
	FormatsToProcess = @()
	
	# Modules to import as nested modules of the module specified in
	# ModuleToProcess
	NestedModules = @()
	
	# Functions to export from this module
	FunctionsToExport = @(
		'import-apitoken',
		'find-domainemails',
		'find-likelyemail',
		'verify-email',
		'get-domainemailscount',
		'get-accountinfo'
	) #For performance, list functions explicitly
	
	# Cmdlets to export from this module
	CmdletsToExport = '*' 
	
	# Variables to export from this module
	VariablesToExport = '*'
	
	# Aliases to export from this module
	AliasesToExport = '*' #For performance, list alias explicitly
	
	# DSC class resources to export from this module.
	#DSCResourcesToExport = ''
	
	# List of all modules packaged with this module
	ModuleList = @()
	
	# List of all files packaged with this module
	FileList = @()
	
	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData = @{
		
		#Support for PowerShellGet galleries.
		PSData = @{
			
			# Tags applied to this module. These help with module discovery in online galleries.
			 Tags = @("hunter")
			
			# A URL to the license for this module.
			 LicenseUri = 'https://github.com/thelastofreed/Poshhunter/blob/master/LICENSE'
			
			# A URL to the main website for this project.
			 ProjectUri = 'https://github.com/thelastofreed/Poshhunter'
			
			# A URL to an icon representing this module.
			 IconUri = 'https://cdn.jsdelivr.net/gh/thelastofreed/Poshhunter/icon.png'
			
			# ReleaseNotes of this module
			 ReleaseNotes = 'A powershell module to interact with hunter.io api'
			
		} # End of PSData hashtable
		
	} # End of PrivateData hashtable
}







