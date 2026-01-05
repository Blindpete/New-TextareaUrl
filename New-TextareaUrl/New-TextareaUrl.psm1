function New-TextareaUrl {
    <#
    .SYNOPSIS
        Creates a textarea.my URL from the given text.

    .DESCRIPTION
        Compresses the input string using raw deflate compression and encodes it
        as base64url to generate a shareable textarea.my URL. The text is stored
        entirely in the URL hash, requiring no server-side storage.

    .PARAMETER Text
        The text content to encode into the URL.

    .PARAMETER Format
        The URL format to generate:
        - "default" - Standard textarea editor (https://textarea.my/#...)
        - "qr" - QR code page (https://textarea.my/qr#...)
        - "md" - Markdown rendered page (https://textarea.my/md#...)

    .PARAMETER Open
        Opens the generated URL in the default browser.

    .PARAMETER Domain
        Custom domain to use instead of textarea.my.
        Falls back to $env:TEXTAREA_DOMAIN if not specified.
        Defaults to "textarea.my" if neither is set.

    .EXAMPLE
        New-TextareaUrl "Hello, World!"
        Returns a shareable textarea.my URL.

    .EXAMPLE
        New-TextareaUrl "# My Notes`nSome content here"
        Creates a URL with a title (lines starting with # become the page title).

    .EXAMPLE
        New-TextareaUrl "Hello" -Format qr
        Creates a QR code URL for the text.

    .EXAMPLE
        New-TextareaUrl "# Heading`nSome **bold** text" -Format md
        Creates a Markdown rendered page URL.

    .EXAMPLE
        New-TextareaUrl "Hello" -Open
        Creates the URL and opens it in the default browser.

    .EXAMPLE
        New-TextareaUrl "Hello" -Domain "mytextarea.example.com"
        Uses a custom domain for the URL.

    .EXAMPLE
        $env:TEXTAREA_DOMAIN = "mytextarea.example.com"
        New-TextareaUrl "Hello"
        Uses the domain from the environment variable.

    .EXAMPLE
        Get-Content myfile.txt -Raw | New-TextareaUrl
        Creates a URL from a file's contents.

    .LINK
        https://textarea.my

    .LINK
        https://github.com/antonmedv/textarea

    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 0)]
        [string]$Text,

        [Parameter()]
        [ValidateSet("default", "qr", "md")]
        [string]$Format = "default",

        [Parameter()]
        [switch]$Open,

        [Parameter()]
        [string]$Domain
    )
    
    # Convert string to UTF-8 bytes
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)

    # Compress using raw deflate (no headers)
    $memoryStream = New-Object System.IO.MemoryStream
    $deflateStream = New-Object System.IO.Compression.DeflateStream(
        $memoryStream,
        [System.IO.Compression.CompressionLevel]::Optimal
    )

    $deflateStream.Write($bytes, 0, $bytes.Length)
    $deflateStream.Close()

    $compressedBytes = $memoryStream.ToArray()
    $memoryStream.Close()

    # Convert to base64
    $base64 = [Convert]::ToBase64String($compressedBytes)

    # Convert to base64url (URL-safe variant)
    $base64url = $base64 -replace '\+', '-' -replace '/', '_' -replace '=+$', ''

    # Build the URL based on format
    $path = switch ($Format) {
        "qr"  { "/qr" }
        "md"  { "/md" }
        default { "/" }
    }

    # Determine the domain (parameter > env var > default)
    $baseDomain = if ($Domain) {
        $Domain
    } elseif ($env:TEXTAREA_DOMAIN) {
        $env:TEXTAREA_DOMAIN
    } else {
        "textarea.my"
    }

    # Build the full URL
    $url = "https://$baseDomain$path#$base64url"

    # Open in browser if requested
    if ($Open) {
        Start-Process $url
    }

    # Return the URL
    $url
}

# Export the function with global scope as requested
Export-ModuleMember -Function New-TextareaUrl -Cmdlet * -Variable * -Alias *
