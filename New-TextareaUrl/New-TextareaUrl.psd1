@{
    # Script module or binary module file associated with this manifest
    RootModule = 'New-TextareaUrl.psm1'
    
    # Version number of this module
    ModuleVersion = '1.0.0'
    
    # ID used to uniquely identify this module
    GUID = 'd13f0ac3-5f4f-41ae-91fd-58f5838a8eae'
    
    # Author of this module
    Author = 'Pete Cook'
    
    # Company or vendor of this module
    CompanyName = ''
    
    # Copyright statement for this module
    Copyright = ''
    
    # Description of the functionality provided by this module
    Description = 'Creates shareable textarea.my URLs from text input. Compresses text using raw deflate compression and encodes it as base64url to generate URLs where content is stored entirely in the URL hash.'
    
    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '5.1'
    
    # Functions to export from this module
    FunctionsToExport = @('New-TextareaUrl')
    
    # Cmdlets to export from this module
    CmdletsToExport = @()
    
    # Variables to export from this module
    VariablesToExport = @()
    
    # Aliases to export from this module
    AliasesToExport = @()
    
    # Private data to pass to the module specified in RootModule/ModuleToProcess
    PrivateData = @{
        PSData = @{
            # Tags applied to this module
            Tags = @('textarea', 'url', 'compression', 'share', 'text', 'qr', 'markdown')
            
            # A URL to the license for this module
            LicenseUri = 'https://opensource.org/licenses/MIT'
            
            # A URL to the main website for this project
            ProjectUri = 'https://github.com/blindpete/New-TextareaUrl'
            
            # A URL to an icon representing this module
            IconUri = ''
            
            # ReleaseNotes of this module
            ReleaseNotes = @'
Initial release with support for:
- Text compression and URL generation for textarea.my
- QR code and Markdown format options
- Custom domain support via parameter or environment variable
- Browser launch option
'@
        }
    }
}
