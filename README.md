<div align="center">
<img src="media/New-TextareaUrl.png" alt="alt text" width="50%">
</div>
<br/>
<br/>

# New-TextareaUrl

A PowerShell script that generates shareable [textarea.my](https://textarea.my) URLs from text input.

## What is textarea.my?

[textarea.my](https://textarea.my) is a minimalist text sharing service that stores content entirely in the URL hash—no server-side storage required. This script compresses text using the same algorithm as the web app, producing compatible URLs.

## Installation

### From PowerShell Gallery

```powershell
Install-Script -Name New-TextareaUrl
```

### Manual Installation

Download `New-TextareaUrl.ps1` and place it in your preferred scripts directory.

## Usage

### Basic Usage

```powershell
# Generate a shareable URL
.\New-TextareaUrl.ps1 "Hello, World!"
# Output: https://textarea.my/#80jNycnXUQjPL8pJUQQA
```

### With Title

Lines starting with `#` become the page title:

```powershell
.\New-TextareaUrl.ps1 "# My Notes`nThis is the content"
```

### QR Code

Generate a URL that displays a QR code:

```powershell
.\New-TextareaUrl.ps1 "Hello" -Format qr
# Output: https://textarea.my/qr#80jNyckHAA
```

### Markdown Rendering

Generate a URL that renders Markdown:

```powershell
.\New-TextareaUrl.ps1 "# Heading`n**Bold** and *italic*" -Format md
# Output: https://textarea.my/md#...
```

### Open in Browser

Automatically open the URL in your default browser:

```powershell
.\New-TextareaUrl.ps1 "Hello" -Open
```

### Custom Domain

Use a self-hosted instance:

```powershell
# Via parameter
.\New-TextareaUrl.ps1 "Hello" -Domain "mytextarea.example.com"

# Via environment variable
$env:TEXTAREA_DOMAIN = "mytextarea.example.com"
.\New-TextareaUrl.ps1 "Hello"
```

### Pipeline Input

Read from a file:

```powershell
Get-Content myfile.txt -Raw | .\New-TextareaUrl.ps1
```

## Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `-Text` | String | The text content to encode (required, accepts pipeline input) |
| `-Format` | String | URL format: `default`, `qr`, or `md` |
| `-Open` | Switch | Open the URL in the default browser |
| `-Domain` | String | Custom domain (falls back to `$env:TEXTAREA_DOMAIN`) |

## How It Works

1. Text is encoded as UTF-8 bytes
2. Compressed using raw DEFLATE algorithm
3. Encoded as base64url (URL-safe base64)
4. Appended to the textarea.my URL as a hash fragment

Since all data is in the URL hash, it's never sent to the server—perfect for sharing.

## License

MIT License

