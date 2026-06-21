$file = Get-Content "app\src\main\java\com\example\ui\screens\ViverMainScreen.kt"
$depth = 0
$lineNum = 0
foreach ($line in $file) {
    $lineNum++
    # Skip string contents for brace counting
    $cleaned = $line -replace '"[^"]*"', '""'
    $cleaned = $cleaned -replace "'[^']*'", "''"
    $opens = ([regex]::Matches($cleaned, '\{')).Count
    $closes = ([regex]::Matches($cleaned, '\}')).Count
    $prevDepth = $depth
    $depth = $depth + $opens - $closes
    if ($opens -gt 0 -or $closes -gt 0) {
        Write-Host ("{0,4}: depth {1,3} -> {2,3}  ({3}+{4}-)  {5}" -f $lineNum, $prevDepth, $depth, $opens, $closes, $line.Trim().Substring(0, [Math]::Min(80, $line.Trim().Length)))
    }
}
Write-Host ""
Write-Host "Final depth: $depth (should be 0)"
