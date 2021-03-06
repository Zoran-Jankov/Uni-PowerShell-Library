<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER AzureADUser
Parameter description

.PARAMETER Employee
Parameter description

.EXAMPLE
An example

.NOTES
Version:        1.1
Author:         Zoran Jankov
#>
#>
function Compare-AzureADUserInfo {
    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(Position = 0, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Microsoft.Open.AzureAD.Model.DirectoryObject]
        $AzureADUser,

        [Parameter(Position = 1, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [System.Object[]]
        $Employee
    )

    begin {
        $UserAttributes = @(
        'JobTitle',
        'Department',
        'StreetAddress',
        'City',
        'PostalCode'
        )
        $Differences = $false
    }

    process {
        foreach ($UserAttribute in $UserAttributes) {
            $AzureADUserAttributeValue = $AzureADUser | Select-Object -Property $UserAttribute
            $UserAttributeValue = $Employee | Select-Object -Property $UserAttribute
            if ($AzureADUserAttributeValue.$UserAttribute -ne $UserAttributeValue.$UserAttribute) {
                Write-Verbose -Message $UserAttribute -Verbose
                Write-Verbose -Message "Old value: $AzureADUserAttributeValue.$UserAttribute" -Verbose
                Write-Verbose -Message "New value: $UserAttributeValue.$UserAttribute `n" -Verbose
                $Differences = $true
            }
        }
    }

    end {
        return $Differences
    }
}