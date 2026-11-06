param([Parameter(Mandatory)][string]$Server, [int]$Port = 5000, [string]$Name = $env:USERNAME)
$tcp = [Net.Sockets.TcpClient]::new($Server, $Port)
$s = $tcp.GetStream()
$r = [IO.StreamReader]::new($s)
$w = [IO.StreamWriter]::new($s); $w.AutoFlush = $true
$w.WriteLine("* $Name joined")
$buf = ""
Write-Host "Connected. Type /q to quit.`n"
Write-Host "> " -NoNewline

while ($true) {
  while ($s.DataAvailable) {
    $line = $r.ReadLine()
    Write-Host ("`r" + " " * ($buf.Length + 3) + "`r") -NoNewline
    Write-Host $line
    Write-Host "> $buf" -NoNewline
  }
  while ([Console]::KeyAvailable) {
    $k = [Console]::ReadKey($true)
    switch ($k.Key) {
      'Enter' {
        if ($buf -eq '/q') { $w.WriteLine("* $Name left"); $tcp.Close(); return }
        if ($buf) { $w.WriteLine("${Name}: $buf") }
        Write-Host ("`r" + " " * ($buf.Length + 3) + "`r> ") -NoNewline
        $buf = ""
      }
      'Backspace' {
        if ($buf.Length) { $buf = $buf.Substring(0, $buf.Length - 1); Write-Host "`b `b" -NoNewline }
      }
      default { $buf += $k.KeyChar; Write-Host $k.KeyChar -NoNewline }
    }
  }
  Start-Sleep -Milliseconds 30
}