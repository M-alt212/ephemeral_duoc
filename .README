# Chat efímero en PowerShell

Un chat mínimo para terminal, hecho en PowerShell puro y sin dependencias. Es un proyecto simple y rápido de armar, pensado para probar la comunicación entre PCs de una misma red local. Nada se guarda en disco: cuando se cierra el servidor, el chat desaparece.

## Archivos

- `server.ps1`: el servidor. Se ejecuta en un solo PC.
- `client.ps1`: el cliente. Se ejecuta en cada PC que quiera participar.

## Uso

1. En el PC que hará de servidor, averigua su IP con `ipconfig` (dirección IPv4) y ejecuta:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\server.ps1
   ```

2. En los demás PCs, conéctate con:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\client.ps1 -Server 192.168.x.x -Name tunombre
   ```

3. Escribe y presiona Enter para enviar. Usa `/q` para salir.

Por defecto usa el puerto 5000. Se puede cambiar con `-Port` en ambos lados.

## Si no conecta

- Revisa que el firewall de Windows del servidor permita el puerto.
- Algunas redes aíslan los equipos entre sí y no dejan que se vean. Puedes probarlo con `Test-NetConnection IP-DEL-SERVIDOR -Port 5000`.

## Advertencia

Los mensajes viajan en texto plano y no hay autenticación: cualquiera que alcance el servidor puede leer y participar. Úsalo solo para pruebas y con permiso en la red donde lo ejecutes. No envíes información privada.

## Licencia

MIT
