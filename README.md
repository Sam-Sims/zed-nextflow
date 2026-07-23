# nextflow-zed
A WIP Zed extension for Nextflow. Heavily inspired by other works - see credits.

`nextflow-zed` adds Nextflow language support to [Zed](https://zed.dev/), using the official [Nextflow Tree-sitter grammar](https://github.com/nextflow-io/tree-sitter-nextflow) and [language server](https://github.com/nextflow-io/language-server).

## Contents

- [Features](#features)
- [Requirements](#requirements)
- [Install as a dev extension](#install-as-a-dev-extension)
- [Configuration](#configuration)
- [Defaults](#defaults)
- [Development](#development)
- [Credits](#credits)

## Features

- Supports nextflow versions `24.10`, `25.04`, `25.10` and `26.04`
- Syntax highlighting
- Inline diagnositics
- Nextflow config support
- Bash highlighting for `script` blocks
- Bracket/comment/quote autocomplete

## Requirements

- Java 17 or later
- [Rust](https://www.rust-lang.org/tools/install) when installing this as a dev extension


## Install as a dev extension

This extension is not yet published, but can be installed directly from the repository.

Clone it:

```bash
git clone https://github.com/Sam-Sims/nextflow-zed.git
```

Then in Zed:

1. Open the Extensions page.
2. Select `Install Dev Extension`.
3. Select the cloned `nextflow-zed` directory.

You can also open the command palette and run `zed: install dev extension`.

Zed will build and install the extension automatically. Open a `.nf` file to start it and the language-server JAR will be downloaded on first use.

If installation fails, open the command palette and run `zed: open log`. I would also recommend launching Zed with `zededitor --foreground` when debugging the extension itself.

## Configuration

Configure the extension under the `lsp` key in your global Zed `settings.json`, or in a project's `.zed/settings.json`:

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
            "exclude": [".git", ".nextflow", "work"]
          }
        }
      }
    }
  }
}
```

- The `java` and `languageServer` entries are optional overrides. Without them, the extension finds Java through `JAVA_HOME` or your `PATH` and automatically downloads the newest language-server patch for the selected Nextflow language version.
- Supported language versions are `26.04`, `25.10`, `25.04` and `24.10`. The default is `26.04`. Restart the language server after changing its version, Java installation or JAR.
- Settings inside the `nextflow` object are forwarded to the language server, with user values overriding the extension defaults. See [Configuring Language Servers](https://zed.dev/docs/configuring-languages#configuring-language-servers) for details.

## Credits

This extension builds on the work of several existing language extensions that provided useful references and inspiration:
- https://github.com/ctuni/zed-nextflow/tree/main/languages/nextflow
- https://github.com/DLBPointon/zed_nextflow
- https://github.com/valentinegb/zed-groovy/
- https://github.com/nextflow-io/tree-sitter-nextflow/tree/main/queries
