# ChunkyIngress
[@ZephrFish](https://github.com/ZephrFish) Solving problems he didn't think he'd have on a Saturday with clipboard Copy&Paste limits with PowerShell. 

Essentially, this script will take an input file, copy it to the clipboard in chunks, and allow you to paste it into an environment that only allows copying of text, not files. He built it because he was hitting clipboard limits for pasting things into an env.

I noticed a few issues with the flags in the `README` and what actually was specified in the code, then i noted the outputfile didnt seem to be generating. SO, I made the following changes:

Fixes & Code Revisions:

- Corrected the `README` for usage
- Added Error handling
- Fixed output file creation
- Confirmation of output file path

---

## Usage
First, load the module. Then, the script will split the file supplied into the selected KBs and copy it to your clipboard. It will do this until the file is entirely copied and tell you to hit enter each time.

**Import:**

```
ipmo .\ChunkyIngress.ps1
```

**Encode:**
```
Invoke-ChunkyIngress -mode encode -inputpath "C:\Users\dev\ChunkyIngress.7z" -outputpath "C:\Users\dev\ChunkyIngress.7z"
```

**Decode (locally on the originating box)**
```
Invoke-ChunkyIngress -mode decode -inputPath "C:\Users\dev\encodedfile.txt" -outputPath "C:\Users\dev\decodedfile.7z"
```

**Decode (remote host)**

Once you've pasted the file into your env simply use the following PowerShell to rebuild the file:

```
$BuildMahFile = [Convert]::FromBase64String("")
[IO.File]::WriteAllBytes('ChunkyIngress.7z', $BuildMahFile)
```

## Example of Encoding
```
Invoke-ChunkyIngress -filePath "C:\Users\dev\ChunkyIngress.7z"
Full Base64 string saved to C:\Users\dev\output.txt.
Prepare for 6 blocks of data
Once you have pasted each into your environment, hit return to copy the next block
Chunk 0 copied to clipboard. Press Enter to copy the next chunk or Ctrl+C to exit.


Chunk 1 copied to clipboard. Press Enter to copy the next chunk or Ctrl+C to exit.


Chunk 2 copied to clipboard. Press Enter to copy the next chunk or Ctrl+C to exit.


Chunk 3 copied to clipboard. Press Enter to copy the next chunk or Ctrl+C to exit.


Chunk 4 copied to clipboard. Press Enter to copy the next chunk or Ctrl+C to exit.


Chunk 5 copied to clipboard. Press Enter to copy the next chunk or Ctrl+C to exit.


Chunk 6 copied to clipboard. Press Enter to copy the next chunk or Ctrl+C to exit.


Chunk 7 copied to clipboard. Press Enter to copy the next chunk or Ctrl+C to exit.


Chunk 8 copied to clipboard. Press Enter to copy the next chunk or Ctrl+C to exit.


Total chunks created: 9
```
