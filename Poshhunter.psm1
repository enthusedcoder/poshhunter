﻿<#
    .NOTES
    --------------------------------------------------------------------------------
     Code generated by:  SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.167
     Generated on:       1/4/2020 7:34 PM
     Generated by:       whiggs
    --------------------------------------------------------------------------------
    .DESCRIPTION
        Script generated by PowerShell Studio 2019
#>


	<#	
		===========================================================================
		 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.160
		 Created on:   	4/13/2019 9:46 AM
		 Created by:   	whiggs
		 Organization: 	
		 Filename:     	Poshhunter.psm1
		-------------------------------------------------------------------------
		 Module Name: Poshhunter
		===========================================================================
	#>
	
	#.EXTERNALHELP en-US\Poshhunter-help.xml
	
	function import-apitoken
	{
		[CmdletBinding(DefaultParameterSetName = "none", SupportsShouldProcess = $true)]
		param (
			[Parameter(ParameterSetName = "passed", Mandatory = $true, Position = 0)]
			[ValidateNotNullOrEmpty()]
			[System.String]$apikey
		)
		If ($PSCmdlet.ParameterSetName -like "none")
		{
			$apikey = Read-Host -Prompt "Paste your hunter api key here."
		}
		If (!(Test-Path "HKCU:\Software\hunter"))
		{
			New-Item "HKCU:\software\hunter" -Force | Out-Null
		}
		Set-ItemProperty -Path "HKCU:\Software\hunter" -Name "apikey" -Value $apikey -Force | Out-Null
	}
	
	function find-domainemails
	{
		[CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = "domain")]
		param (
			[Parameter(ParameterSetName = 'domain', Mandatory = $true, Position = 0)]
			[ValidateNotNullOrEmpty()]
			[string]$domain,
			[Parameter(ParameterSetName = "company", Mandatory = $true, Position = 0)]
			[ValidateNotNullOrEmpty()]
			[String]$company,
			[Parameter(Mandatory = $false)]
			[ValidateSet("executive", "it", "finance", "management", "sales", "legal", "support", "hr", "marketing", "communication")]
			[String[]]$department,
			[Parameter(Mandatory = $false)]
			[ValidateSet("junior", "senior", "executive")]
			[String[]]$seniority,
			[Parameter(Mandatory = $false)]
			[ValidateSet("personal", "generic")]
			[String]$type,
			[Parameter(Mandatory = $false)]
			[String]$offset
		)
		Try
		{
			$apikey = (Get-ItemProperty -Path "HKCU:\Software\hunter" -Name "apikey" -ErrorAction Stop).apikey
		}
		Catch
		{
			Write-Error "Need to import api key.  Run import-apitoken command first"
			return
		}
		$url = "https://api.hunter.io/v2/domain-search?api_key=$apikey&limit=100"
		If ($PSCmdlet.ParameterSetName -like "domain")
		{
			$url = $url + "&domain=$domain"
			
		}
		Else
		{
			$url = $url + "&company=$company"
		}
		If ($PSBoundParameters.Keys -contains "department")
		{
			$url = $url + "&department="
			foreach ($item in $department)
			{
				$url = $url + "$item,"
			}
			$url = $url.Substring(0, $url.Length - 1)
		}
		If ($PSBoundParameters.Keys -contains "seniority")
		{
			$url = $url + "&seniority="
			foreach ($thing in $seniority)
			{
				$url = $url + "$thing,"
			}
			$url = $url.Substring(0, $url.Length - 1)
		}
		If ($PSBoundParameters.Keys -contains "type")
		{
			$url = $url + "&type=$type"
		}
		If ($PSBoundParameters.Keys -contains "offset")
		{
			$url = $url + "&offset=$offset"
			$request = Invoke-RestMethod -Method Get -Uri $url
			$psob = New-Object -TypeName System.Management.Automation.PSObject
			$psob | Add-Member -membertype NoteProperty -Name Data -Value $request.data
			$psob | Add-Member -MemberType NoteProperty -Name "totalfound" -Value $request.meta.results
			return $request.data
		}
		Else
		{
			$array = New-Object System.Collections.ArrayList
			$off = 0
			Do
			{
				$uri = $url + "&offset=$off"
				Try
				{
					$request = Invoke-RestMethod -Method Get -Uri $uri -ErrorAction Stop
					$psob = New-Object -TypeName System.Management.Automation.PSObject
					$psob | Add-Member -membertype NoteProperty -Name Data -Value $request.data
					$psob | Add-Member -MemberType NoteProperty -Name "totalfound" -Value $request.meta.results
					$array.Add($psob)
					[int]$off = [int]$off + 100
				}
				Catch
				{
					Write-Error $_
					Write-Host "The queries that the process already obtained will still be returned"
					Break
				}
			}
			Until ([int]$off -ge [int]$request.meta.results)
			return $array
		}
		
		
	}
	function find-likelyemail
	{
		[CmdletBinding(DefaultParameterSetName = "domain", SupportsShouldProcess = $true)]
		param (
			[Parameter(Mandatory = $true, ParameterSetName = 'domain', Position = 0)]
			[ValidateNotNullOrEmpty()]
			[String]$domain,
			[Parameter(Mandatory = $true, ParameterSetName = "company", Position = 0)]
			[ValidateNotNullOrEmpty()]
			[String]$company,
			[Parameter(Mandatory = $true)]
			[String]$firstname,
			[Parameter(Mandatory = $true)]
			[String]$lastname
		)
		Try
		{
			$apikey = (Get-ItemProperty -Path "HKCU:\Software\hunter" -Name "apikey" -ErrorAction Stop).apikey
		}
		Catch
		{
			Write-Error "Need to import api key.  Run import-apitoken command first"
			return
		}
		$uri = "https://api.hunter.io/v2/email-finder?api_key=$apikey&first_name=$firstname&last_name=$lastname"
		If ($PSCmdlet.ParameterSetName -like "domain")
		{
			$uri = $uri + "&domain=$domain"
		}
		Else
		{
			$uri = $uri + "&company=$company"
		}
		Try
		{
			$request = Invoke-RestMethod -Method Get -Uri $uri -ErrorAction Stop
			return $request.data
		}
		catch
		{
			Write-Error $_
			return
		}
		
	}
	
	function verify-email
	{
		[CmdletBinding(SupportsShouldProcess = $true)]
		param (
			[Parameter(Mandatory = $true)]
			[ValidateNotNullOrEmpty()]
			[ValidatePattern("^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$")]
			[String]$email
		)
		Try
		{
			$apikey = (Get-ItemProperty -Path "HKCU:\Software\hunter" -Name "apikey" -ErrorAction Stop).apikey
		}
		Catch
		{
			Write-Error "Need to import api key.  Run import-apitoken command first"
			return
		}
		$uri = "https://api.hunter.io/v2/email-verifier?api_key=$apikey&email=$email"
		Try
		{
			$request = Invoke-RestMethod -Method Get -Uri $uri -ErrorAction Stop
			Return $request.data
		}
		Catch
		{
			Write-Error $_
			return
		}
	}
	
	function get-domainemailscount
	{
		[CmdletBinding(DefaultParameterSetName = "domain", SupportsShouldProcess = $true)]
		param (
			[Parameter(Mandatory = $true, ParameterSetName = 'domain', Position = 0)]
			[ValidateNotNullOrEmpty()]
			[String]$domain,
			[Parameter(Mandatory = $true, ParameterSetName = "company", Position = 0)]
			[ValidateNotNullOrEmpty()]
			[String]$company,
			[Parameter(Mandatory = $false)]
			[ValidateSet("personal", "generic")]
			[String]$type
		)
		Try
		{
			$apikey = (Get-ItemProperty -Path "HKCU:\Software\hunter" -Name "apikey" -ErrorAction Stop).apikey
		}
		Catch
		{
			Write-Error "Need to import api key.  Run import-apitoken command first"
			return
		}
		$uri = "https://api.hunter.io/v2/email-count?"
		If ($PSCmdlet.ParameterSetName -like "domain")
		{
			$uri = $uri + "domain=$domain"
		}
		else
		{
			$uri = $uri + "company=$company"
		}
		If ($PSBoundParameters.Keys -contains "type")
		{
			$uri = $uri + "&type=$type"
		}
		Try
		{
			$request = Invoke-RestMethod -Method Get -Uri $uri -ErrorAction Stop
			Return $request.data
		}
		Catch
		{
			Write-Error $_
			return
		}
	}
	function get-accountinfo
	{
		Try
		{
			$apikey = (Get-ItemProperty -Path "HKCU:\Software\hunter" -Name "apikey" -ErrorAction Stop).apikey
		}
		Catch
		{
			Write-Error "Need to import api key.  Run import-apitoken command first"
			return
		}
		$uri = "https://api.hunter.io/v2/account?api_key=$apikey"
		Try
		{
			$request = Invoke-RestMethod -Method Get -Uri $uri -ErrorAction Stop
			Return $request.data
		}
		Catch
		{
			Write-Error $_
			return
		}
	}
	
	Export-ModuleMember -Function find-domainemails, find-likelyemail, get-accountinfo, get-domainemailscount, import-apitoken, verify-email