# zed-nextflow

Nextflow language support for [Zed](https://zed.dev/), built on the
[Nextflow tree-sitter grammar](https://github.com/nextflow-io/tree-sitter-nextflow)
and the [Nextflow language server](https://github.com/nextflow-io/language-server).

<img width="1092" alt="Screenshot" src="assets/img.png">

## Features

- Syntax highlighting for `.nf` scripts and `.config` files
- Bash highlighting inside `script`, `shell`, and `stub` blocks
- Diagnostics, go-to-definition, completion, hover, and formatting from the language server
- Outline view for processes, workflows, and functions
- Automatic download of the language server JAR, pinned to a Nextflow version

## Requirements

Java 17 or later, to run the language server. Installing as a dev extension
also needs [Rust](https://www.rust-lang.org/tools/install).

## Install

The extension is not yet in the Zed extension registry. Until then, install it
from source.

```bash
git clone https://github.com/nextflow-io/zed-nextflow.git
```

In Zed, open the command palette and run `zed: install dev extension`, then
pick the cloned directory. Zed builds and installs it. Open a `.nf` file to
start the language server, which downloads its JAR on first use.

## Configuration

Settings go under the `lsp` key in your global Zed `settings.json`, or in a
project's `.zed/settings.json`.

```json
{
  "lsp": {
    "nextflow-language-server": {
      "settings": {
        "nextflow": {
          "languageVersion": "26.04",
          "java": {
            "home": "/path/to/jdk-17-or-later"
          },
          "languageServer": {
            "path": "/absolute/path/to/language-server-all.jar"
          },
          "errorReportingMode": "warnings",
          "files": {
            "exclude": [".git", ".lineage", ".nf-test", ".pixi", ".venv", "work"]
          }
        }
      }
    }
  }
}
```

The extension sends the same language server defaults as the
[VS Code extension](https://github.com/nextflow-io/vscode-language-nextflow#configuration):

| Setting | Default |
| --- | --- |
| `nextflow.completion.extended` | `false` |
| `nextflow.completion.maxItems` | `100` |
| `nextflow.debug` | `false` |
| `nextflow.errorReportingMode` | `"warnings"` |
| `nextflow.files.exclude` | `.git`, `.lineage`, `.nf-test`, `.pixi`, `.venv`, `work` |
| `nextflow.formatting.harshilAlignment` | `false` |
| `nextflow.formatting.maheshForm` | `false` |
| `nextflow.formatting.sortDeclarations` | `false` |

Anything you set in `settings.json` overrides these. See
[Configuring language servers](https://zed.dev/docs/configuring-languages#configuring-language-servers).

Two settings are extension-specific rather than language server settings:

- `nextflow.java.home` points at a JDK. Without it the extension looks at
  `JAVA_HOME`, then `PATH`.
- `nextflow.languageServer.path` points at a JAR you built yourself, which
  skips the download. Useful when working on the language server.

`nextflow.languageVersion` picks which language server release to download.
Supported values are `26.04` (the default), `25.10`, `25.04`, and `24.10`. The
extension downloads the newest patch release for that version. Restart the
language server after changing the version, the JDK, or the JAR path.

## Development

```bash
cargo build --release --target wasm32-wasip2
```

Query files live in `languages/nextflow/`. After editing one, run
`zed: reload extensions` to see the change. To check a query against the
grammar:

```bash
tree-sitter query languages/nextflow/highlights.scm path/to/script.nf
```

The grammar revision is pinned in `extension.toml`. Bump it when
`tree-sitter-nextflow` cuts a release, and re-run the queries against the new
revision, since node names can change.

## Credits

This extension began as community work in
[nextflow-io/language-server#122](https://github.com/nextflow-io/language-server/issues/122).
The Rust extension code, queries, and configuration come from
[Sam-Sims/nextflow-zed](https://github.com/Sam-Sims/nextflow-zed), which in
turn built on:

- [ctuni/zed-nextflow](https://github.com/ctuni/zed-nextflow), the first
  version that loaded the language server and highlighted Nextflow
- [DLBPointon/zed_nextflow](https://github.com/DLBPointon/zed_nextflow), the
  first attempt and the source of much of the original highlight query
- [valentinegb/zed-groovy](https://github.com/valentinegb/zed-groovy)
- [nextflow-io/vscode-language-nextflow](https://github.com/nextflow-io/vscode-language-nextflow)

