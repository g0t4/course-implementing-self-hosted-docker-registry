## Useful Commands:

```bash

# verify mirror configured
docker system info

# verify image removed
docker image rm node
docker image ls node

docker image pull node

# macOS / linux (bash) - time command
time docker image pull node
```

Windows specific commands (powershell):

```powershell
# Powershell - compute total time of last command (use after docker image pull)
$lastCommand=$(Get-History -count 1);
($lastCommand.EndExecutionTime - $lastCommand.StartExecutionTime).TotalSeconds
```
