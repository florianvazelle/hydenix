# Troubleshooting

## Nix errors

Bix errors can be tricky to diagnose, but the below might assist in diagnosing the issue.

> [!TIP]
> Rerun the command with `-v` to get more verbose output.
> You can also rerun the command with `--show-trace` to get a more detailed traceback.
> If the nix error is not clear, often the correct error message is somewhere in the *middle* of the error message.

## System errors

The following information is required when creating an issue, please provide as much as possible.
It's also possible to diagnose issues yourself with the information below.

1. **System logs**

   ```bash
   journalctl -b                                          # System logs
   sudo systemctl status home-manager-$HOSTNAME.service   # Home-manager status
   ```

2. **System information**

   ```bash
   nix-shell -p nix-info --run "nix-info -m"
   ```
