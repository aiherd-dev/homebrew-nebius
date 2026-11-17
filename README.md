# AIHerd for Nebius

This tap distributes a signed, notarized macOS app for testing AIHerd with a private relay. The first release uses the disposable leibo-asus Tailscale profile. [Download the public genesis](profiles/leibo-asus.json).

## Install

Connect to the test tailnet, then run

```sh
brew install --cask aiherd-dev/nebius/aiherd
```

The cask supports macOS Sonoma or newer on Apple Silicon and Intel. It installs `AIHerd.app` and the `aih` command. The Nebius and public casks share the app path and launchd service, so Homebrew declares them conflicting.

## Change the local relay address

Show the effective origin with `aih org-relay show`. The test profile initially uses `https://leibo-asus-aih-test.tail85b549.ts.net:8443`. When the relay moves, set its new HTTPS origin locally, for example

```sh
aih org-relay set https://new-relay.tail85b549.ts.net:8443
```

The new endpoint must belong to the configured tailnet and prove possession of a relay key pinned in the signed profile. To return to the bundled address, run `aih org-relay reset`.

Each release records the source commit and profile SHA-256. The signed app includes the public genesis at `AIHerd.app/Contents/Resources/org-swarm.json`.
