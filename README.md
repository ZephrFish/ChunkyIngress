# ChunkyIngress
Solving problems I didn't think I'd have on a Saturday with clipboard copy pasta limits with powershell. 

Essentially this script will take an input file, copy it to the clipboard in chunks and allow you to paste into an environment that only allows copying of text but not files. I built it because I was hitting clipboard limits for pasting things into an env. 

## Usage
First load the module, then the script will split the file supplied into the select amount of KBs and copy to your clipboard. It will do this until the file is fully copied and tell you to hit enter each time.
```
ipmo .\ChunkyIngress.ps1
ChunkyIngress -filePath "C:\Users\dev\ChunkyIngress.7z"
```

Once you've pasted the file into your env simply use the following PowerShell to rebuild the file:

```
$BuildMahFile = [Convert]::FromBase64String("")
[IO.File]::WriteAllBytes('ChunkyIngress.7z', $BuildMahFile)
```

## Example
```
ChunkyIngress -filePath "C:\Users\dev\ChunkyIngress.7z"
Chunk 0 copied to clipboard. Press Enter to copy next chunk or Ctrl+C to exit.


Chunk 1 copied to clipboard. Press Enter to copy next chunk or Ctrl+C to exit.


Chunk 2 copied to clipboard. Press Enter to copy next chunk or Ctrl+C to exit.


Chunk 3 copied to clipboard. Press Enter to copy next chunk or Ctrl+C to exit.


Chunk 4 copied to clipboard. Press Enter to copy next chunk or Ctrl+C to exit.


Chunk 5 copied to clipboard. Press Enter to copy next chunk or Ctrl+C to exit.


Total chunks created: 6
```