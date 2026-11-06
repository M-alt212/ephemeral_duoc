param([int]$Port = 5000)
$listener = [Net.Sockets.TcpListener]::new([Net.IPAddress]::Any, $Port)
$listener.Start()
$clients = [Collections.Generic.List[object]]::new()
Write-Host "Chat server on port $Port (Ctrl+C to stop)"

while ($true) {
  while ($listener.Pending()) {
    $tcp = $listener.AcceptTcpClient()
    $s = $tcp.GetStream()
    $w = [IO.StreamWriter]::new($s); $w.AutoFlush = $true
    $clients.Add(@{ Stream = $s; Reader = [IO.StreamReader]::new($s); Writer = $w })
  }
  foreach ($c in @($clients)) {
    try {
      while ($c.Stream.DataAvailable) {
        $msg = $c.Reader.ReadLine()
        Write-Host $msg
        foreach ($o in @($clients)) {
          try { $o.Writer.WriteLine($msg) } catch { $clients.Remove($o) | Out-Null }
        }
      }
    } catch { $clients.Remove($c) | Out-Null }
  }
  Start-Sleep -Milliseconds 30
}