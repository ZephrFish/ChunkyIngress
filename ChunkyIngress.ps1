function Invoke-ChunkyIngress {
    param (
        [Parameter(Mandatory=$true, HelpMessage="Specify 'encode' to convert file to Base64 or 'decode' for Base64 to file.")]
        [ValidateSet('encode', 'decode')]
        [string]$mode,

        [Parameter(Mandatory=$true, HelpMessage="Specify the path to input file.")]
        [string]$inputPath,

        [Parameter(Mandatory=$true, HelpMessage="Specify the path for the output.")]
        [string]$outputPath
    )

    if ($mode -eq 'encode') {
        $fileBytes = [IO.File]::ReadAllBytes($inputPath)
        $base64String = [Convert]::ToBase64String($fileBytes)
        $chunkSize = 68KB  # Modify chunk size as needed
        $chunkCount = [math]::Ceiling($base64String.Length / $chunkSize)
        
        Write-Output "Prepare for ${chunkCount} blocks of data"
        Write-Output "Once you have pasted each into your environment, hit return to copy the next block"

        for ($i = 0; $i -lt $chunkCount; $i++) {
            $startIndex = $i * $chunkSize
            $chunk = $base64String.Substring($startIndex, [math]::Min($chunkSize, $base64String.Length - $startIndex))
            Set-Clipboard -Value $chunk
            Write-Output "Chunk $i copied to clipboard. Press Enter to copy the next chunk or Ctrl+C to exit."
            Read-Host
        }

        Write-Output "Total chunks created: $chunkCount"
    } elseif ($mode -eq 'decode') {
        $fullBase64String = ''
        $currentChunk = 0
        Write-Output "Paste each chunk of Base64 data. After each paste, hit Enter. Type 'end' to finish."

        do {
            $input = Read-Host "Enter chunk $currentChunk or 'end' to finish"
            if ($input -ne 'end') {
                $fullBase64String += $input
                $currentChunk++
            }
        } while ($input -ne 'end')

        $fileBytes = [Convert]::FromBase64String($fullBase64String)
        [IO.File]::WriteAllBytes($outputPath, $fileBytes)
        Write-Output "File has been reconstructed and saved to $outputPath."
    }
}
