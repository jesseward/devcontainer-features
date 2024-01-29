# Dev Container Features

This is a public repo that provides features for use within a devcontainer (GitHub Codespaces).

## List of Available Devcontainer Features

See [list of packages](https://github.com/jesseward?tab=packages&repo_name=devcontainer-features)

### Jellyfin

The [Jellyfin](https://github.com/jesseward/devcontainer-features/pkgs/container/devcontainer-features%2Fjellyfin) installs the target version of the Jellyfin media server as well as the Jellyfin WebUI.

This feature along with the `dotnet` feature are well suited for Jellyfin plugin development. This is used in the [jellyfin-plugin-lastfm](https://github.com/jesseward/jellyfin-plugin-lastfm) Codespace (example [devcontainer.json](https://github.com/jesseward/jellyfin-plugin-lastfm/blob/master/.devcontainer/devcontainer.json))

### [Toxiproxy](https://github.com/Shopify/toxiproxy)

Installs a Toxiproxy instance within the Codespace. Toxiproxy is a tool that provides application level network fault injection capabilities.