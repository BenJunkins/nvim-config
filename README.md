# Neovim Config

Personal Neovim setup written in Lua and managed with [lazy.nvim](https://github.com/folke/lazy.nvim).
This file is a refresher: what is installed, every keybinding, and enough Neovim basics to get moving again after time away.

- **Leader key:** `Space`
- **Requires:** Neovim 0.12 or newer (checked on v0.12.5, Linux Mint)
- **Theme:** Kanagawa (wave)

## Contents

- [Quick start](#quick-start)
- [How the config is laid out](#how-the-config-is-laid-out)
- [Plugins](#plugins)
- [Keybindings](#keybindings)
- [Language support](#language-support)
- [Editor options](#editor-options)
- [Neovim basics refresher](#neovim-basics-refresher)
- [Maintenance and troubleshooting](#maintenance-and-troubleshooting)
- [Gotchas](#gotchas)

## Quick start

### Requirements

| Needed                                    | Why                                                            |
| ----------------------------------------- | -------------------------------------------------------------- |
| Neovim 0.12+                              | Uses `vim.lsp.config` / `vim.lsp.enable` and 0.12-only options |
| `git`                                     | lazy.nvim clones plugins                                       |
| C compiler (`gcc`)                        | Builds treesitter parsers                                      |
| `curl`, `tar`, `unzip`                    | Mason and treesitter downloads                                 |
| `ripgrep` (`rg`)                          | Telescope live grep and grep string                            |
| Node.js + `npm`                           | Mason installs pyright, jsonls and prettier with it            |
| Python 3 with `venv`                      | Mason installs black and isort with it                         |
| A [Nerd Font](https://www.nerdfonts.com)  | Statusline separators, file icons, diagnostic signs            |
| `xclip` (X11) or `wl-clipboard` (Wayland) | System clipboard yanks (`<leader>y`)                           |

On Debian, Ubuntu or Mint:

```bash
sudo apt install git gcc curl unzip ripgrep nodejs npm python3-venv xclip
```

The distro's `neovim` package is usually too old. Install the official release tarball from
<https://github.com/neovim/neovim/releases> instead.

The font used here is **ShureTechMono Nerd Font**. Unpack its `.ttf` files into
`~/.local/share/fonts/`, run `fc-cache -f`, then pick it as the font in your terminal's profile settings.

### Install

```bash
git clone git@github.com:BenJunkins/nvim-config.git ~/.config/nvim
```

```bash
nvim
```

1. **First launch:** lazy.nvim installs itself and every plugin, then Mason installs the language servers and
   formatters in the background. Run `:Mason` to watch progress.
2. **Quit and reopen once.** The `tree-sitter` CLI arrives through Mason during the first launch, so the
   syntax parsers are built on the second one.
3. Run `:checkhealth` to confirm everything is green.

## How the config is laid out

```text
~/.config/nvim
├── init.lua                          entry point, just loads lua/McKearnyPlum
├── lua/McKearnyPlum/
│   ├── init.lua                      loads the files below, in this order
│   ├── remap.lua                     leader key and general keymaps
│   ├── set.lua                       editor options
│   ├── lazy.lua                      plugin manager bootstrap and the plugin list
│   ├── config/
│   │   ├── lsp.lua                   Mason, tool list, enabled servers, diagnostics, LSP keymaps
│   │   └── lsp_settings/lua_ls.lua   settings for the Lua language server
│   └── autocmds.lua                  empty, reserved for autocommands
└── after/plugin/                     one file per plugin, sourced automatically once plugins are loaded
    ├── autopairs.lua
    ├── colors.lua                    Kanagawa theme
    ├── conform.lua                   formatters, format on save, <leader>f
    ├── FineCmdLine.lua               floating command line
    ├── harpoon.lua
    ├── lualine.lua                   statusline
    ├── telescope.lua
    ├── treesitter.lua                parser install and highlighting
    ├── undotree.lua                  toggle key and persistent undo
    └── vimFugitive.lua
```

To add a plugin: add it to the list in `lua/McKearnyPlum/lazy.lua`, then put its setup and keymaps in a new
file under `after/plugin/`.

## Plugins

| Plugin                                 | What it does                                                    |
| -------------------------------------- | --------------------------------------------------------------- |
| **lazy.nvim**                          | Plugin manager                                                  |
| **telescope.nvim** (+ plenary.nvim)    | Fuzzy finder for files and text                                 |
| **harpoon** (harpoon2 branch)          | Pin a few files per project and jump between them instantly     |
| **kanagawa.nvim**                      | Colorscheme                                                     |
| **lualine.nvim** (+ nvim-web-devicons) | Statusline with mode, branch, diff, diagnostics, LSP status     |
| **smear-cursor.nvim**                  | Animated cursor trail                                           |
| **conform.nvim**                       | Runs formatters, including on save                              |
| **nvim-treesitter** (main branch)      | Installs syntax parsers; Neovim does the highlighting           |
| **undotree**                           | Visual tree of the undo history                                 |
| **vim-fugitive**                       | Git inside Neovim                                               |
| **nvim-autopairs**                     | Closes brackets and quotes automatically                        |
| **mason.nvim**                         | Installs language servers and formatters into Neovim's data dir |
| **mason-lspconfig.nvim**               | Translates between Mason package names and LSP config names     |
| **mason-tool-installer.nvim**          | Keeps the tool list in `config/lsp.lua` installed               |
| **nvim-lspconfig**                     | Ready-made configurations for language servers                  |
| **blink.cmp** (+ friendly-snippets)    | Completion menu and snippets                                    |
| **fine-cmdline.nvim** (+ nui.nvim)     | Floating command line in the middle of the screen               |

## Keybindings

Notation: `<leader>` is `Space`, `<C-x>` is Ctrl+x, `<M-x>` is Alt+x, `<CR>` is Enter.
`{motion}` means the key waits for a movement, for example `<leader>yiw` or `<leader>dd`.

### General

| Keys         | Mode     | Action                                               |
| ------------ | -------- | ---------------------------------------------------- |
| `jk`         | Insert   | Back to normal mode (same as `Esc`)                  |
| `:`          | Normal   | Open the floating command line                       |
| `<leader>pv` | Normal   | Open the file explorer (netrw) in the current folder |
| `<leader>t`  | Normal   | Open a terminal in a vertical split, ready to type   |
| `Esc`        | Terminal | Leave terminal typing mode (then `:q` closes it)     |
| `<leader>u`  | Normal   | Toggle the undo tree                                 |
| `Q`          | Normal   | Disabled, so Ex mode is never entered by accident    |

### Editing

| Keys                    | Mode            | Action                                                       |
| ----------------------- | --------------- | ------------------------------------------------------------ |
| `J`                     | Normal          | Join the line below onto this one, cursor stays where it was |
| `J` / `K`               | Visual          | Move the selected lines down / up and re-indent them         |
| `<leader>f`             | Normal          | Format the buffer (same formatters as format on save)        |
| `gcc`                   | Normal          | Toggle comment on the line (built in)                        |
| `gc{motion}` / `gc`     | Normal / Visual | Toggle comment over a motion or selection (built in)         |
| `]<Space>` / `[<Space>` | Normal          | Add an empty line below / above (built in)                   |

Saving a file formats it automatically. See [Language support](#language-support) for which formatter runs.

### Clipboard and registers

A plain `y` or `d` stays inside Neovim. These keys are for the system clipboard and for protecting what you yanked.

| Keys                | Mode   | Action                                                       |
| ------------------- | ------ | ------------------------------------------------------------ |
| `<leader>y{motion}` | Normal | Yank to the system clipboard                                 |
| `<leader>Y`         | Normal | Yank the whole line to the system clipboard                  |
| `<leader>y`         | Visual | Yank the selection to the system clipboard                   |
| `<leader>p`         | Normal | Paste the last thing you _yanked_, even if you deleted since |
| `<leader>p`         | Visual | Paste over the selection without losing what you yanked      |
| `<leader>d{motion}` | Normal | Delete without saving the text anywhere                      |
| `<leader>d`         | Visual | Delete the selection without saving the text anywhere        |

### Moving around

| Keys              | Mode   | Action                                             |
| ----------------- | ------ | -------------------------------------------------- |
| `<C-d>` / `<C-u>` | Normal | Half a page down / up, keeping the cursor centered |
| `n` / `N`         | Normal | Next / previous search match, centered on screen   |

### Finding files and text (Telescope)

| Keys         | Mode   | Action                                                  |
| ------------ | ------ | ------------------------------------------------------- |
| `<leader>ff` | Normal | Find files by name                                      |
| `<leader>fg` | Normal | Find files tracked by git                               |
| `<leader>gl` | Normal | Live grep: search file contents as you type             |
| `<leader>gf` | Normal | Grep string: type a search term first, then browse hits |

Inside a Telescope window:

| Keys                            | Action                                                   |
| ------------------------------- | -------------------------------------------------------- |
| `<C-n>` / `<C-p>` or arrow keys | Next / previous result                                   |
| `<CR>`                          | Open                                                     |
| `<C-x>` / `<C-v>` / `<C-t>`     | Open in a horizontal split / vertical split / tab        |
| `<C-u>` / `<C-d>`               | Scroll the preview up / down                             |
| `<Tab>` / `<S-Tab>`             | Mark several results                                     |
| `<C-q>`                         | Send all results to the quickfix list                    |
| `<M-q>`                         | Send only the marked results to the quickfix list        |
| `<C-/>`                         | Show every available key                                 |
| `<C-c>`                         | Close                                                    |
| `Esc`                           | Switch to normal mode in the picker (`Esc` again closes) |

### Harpoon

Pin the handful of files you are working in and jump straight to them. The list is separate for each
project folder.

| Keys                      | Mode   | Action                           |
| ------------------------- | ------ | -------------------------------- |
| `<leader>a`               | Normal | Add the current file to the list |
| `<C-e>`                   | Normal | Show the list in Telescope       |
| `<leader>1` … `<leader>4` | Normal | Jump to file 1 – 4               |
| `[h` / `]h`               | Normal | Previous / next file in the list |
| `<leader>hc`              | Normal | Clear the list                   |

### LSP (code intelligence)

These work in any buffer where a language server is attached.

| Keys         | Mode            | Action                       |
| ------------ | --------------- | ---------------------------- |
| `<leader>gd` | Normal          | Go to definition             |
| `<leader>gD` | Normal          | Go to declaration            |
| `<leader>gi` | Normal          | Go to implementation         |
| `<leader>gr` | Normal          | List references              |
| `<leader>rn` | Normal          | Rename the symbol everywhere |
| `<leader>ca` | Normal / Visual | Code actions (quick fixes)   |

Neovim also ships its own LSP keys, which work here too:

| Keys              | Mode            | Action                                        |
| ----------------- | --------------- | --------------------------------------------- |
| `K`               | Normal          | Hover documentation (press again to enter it) |
| `grn`             | Normal          | Rename                                        |
| `gra`             | Normal / Visual | Code actions                                  |
| `grr`             | Normal          | References                                    |
| `gri`             | Normal          | Implementation                                |
| `grt`             | Normal          | Type definition                               |
| `grx`             | Normal          | Run code lens                                 |
| `gO`              | Normal          | Outline of symbols in the file                |
| `<C-]>` / `<C-t>` | Normal          | Jump to definition / jump back                |
| `<C-s>`           | Insert          | Signature help                                |

### Diagnostics

Errors and warnings show inline as virtual text, as icons in the sign column, and update while you type.

| Keys         | Mode   | Action                                                         |
| ------------ | ------ | -------------------------------------------------------------- |
| `<leader>cd` | Normal | Show the diagnostic under the cursor in a floating window      |
| `]d` / `[d`  | Normal | Next / previous diagnostic (its message pops up automatically) |
| `]D` / `[D`  | Normal | Last / first diagnostic in the file                            |
| `<C-w>d`     | Normal | Show diagnostics under the cursor (built in)                   |

### Completion (blink.cmp, "super-tab" preset)

The menu appears as you type, with suggestions from the language server, file paths, snippets and words in the buffer.

| Keys                            | Mode   | Action                                                      |
| ------------------------------- | ------ | ----------------------------------------------------------- |
| `<Tab>`                         | Insert | Accept the selected item, or jump to the next snippet field |
| `<S-Tab>`                       | Insert | Jump to the previous snippet field                          |
| `<C-n>` / `<C-p>` or arrow keys | Insert | Next / previous item                                        |
| `<C-Space>`                     | Insert | Open the menu, or toggle the documentation panel            |
| `<C-e>`                         | Insert | Close the menu                                              |
| `<C-b>` / `<C-f>`               | Insert | Scroll the documentation up / down                          |
| `<C-k>`                         | Insert | Toggle signature help                                       |

### Auto pairs

Typing `(`, `[`, `{`, `"`, `'` or a backtick inserts the closing character too.

| Keys    | Mode   | Action                                                          |
| ------- | ------ | --------------------------------------------------------------- |
| `<CR>`  | Insert | Between a pair: open it up onto separate, indented lines        |
| `<BS>`  | Insert | Between an empty pair: delete both characters                   |
| `<M-e>` | Insert | Fast wrap: move the closing bracket to the end of a chosen word |

### Git (vim-fugitive)

| Keys         | Mode   | Action                              |
| ------------ | ------ | ----------------------------------- |
| `<leader>gs` | Normal | Open the git status window (`:Git`) |

Inside the status window:

| Keys        | Action                                  |
| ----------- | --------------------------------------- |
| `s` / `u`   | Stage / unstage the file or hunk        |
| `-`         | Toggle staged                           |
| `U`         | Unstage everything                      |
| `=`         | Toggle an inline diff                   |
| `dd` / `dv` | Open a diff split / vertical diff split |
| `X`         | Discard the change under the cursor     |
| `cc`        | Commit                                  |
| `ca` / `ce` | Amend, editing / keeping the message    |
| `<CR>`      | Open the file                           |
| `g?`        | Show all keys                           |
| `gq`        | Close                                   |

Any git command works as `:Git <command>`, for example `:Git push`, `:Git pull`, `:Git blame`, `:Git log`.

### Undo tree

`<leader>u` opens a tree of every past state of the file. Undo history is saved to disk, so it survives
closing Neovim.

| Keys      | Action                             |
| --------- | ---------------------------------- |
| `J` / `K` | Step to the previous / next state  |
| `<CR>`    | Jump to the state under the cursor |
| `D`       | Toggle the diff panel              |
| `<Tab>`   | Move focus back to the file        |
| `?`       | Show all keys                      |
| `q`       | Close                              |

### Quickfix list

The quickfix list is a list of locations, filled by Telescope's `<C-q>`, by LSP references, or by `:grep`.

| Keys                 | Mode   | Action                           |
| -------------------- | ------ | -------------------------------- |
| `<C-j>` / `<C-k>`    | Normal | Next / previous entry, centered  |
| `]q` / `[q`          | Normal | Next / previous entry (built in) |
| `:copen` / `:cclose` |        | Show / hide the list             |

### Floating command line

Pressing `:` in normal mode opens a small centered prompt instead of the bottom line. Commands work exactly the same.

| Keys                | Action                    |
| ------------------- | ------------------------- |
| `<CR>`              | Run the command           |
| `<Tab>` / `<S-Tab>` | Complete, next / previous |
| `<Up>` / `<Down>`   | Command history           |
| `Esc` or `<C-c>`    | Cancel                    |

In visual mode `:` still uses the normal bottom command line.

## Language support

| Language                                 | Language server | Formatter on save | Syntax parser                            |
| ---------------------------------------- | --------------- | ----------------- | ---------------------------------------- |
| Lua                                      | `lua_ls`        | stylua            | installed                                |
| Python                                   | `pyright`       | black             | installed                                |
| JSON                                     | `jsonls`        | prettier          | installed on first open                  |
| JavaScript, TypeScript, JSX, TSX         | none            | prettier          | JavaScript installed, rest on first open |
| CSS, HTML, YAML                          | none            | prettier          | installed on first open                  |
| Markdown                                 | none            | prettier          | installed                                |
| Vim script, Vim help, treesitter queries | none            | none              | installed                                |

**What each piece gives you**

- **Language server (LSP):** errors as you type, hover docs, go to definition, rename, code actions, smarter completion.
- **Formatter:** rewrites the file in a consistent style when you save or press `<leader>f`. If a filetype has
  no formatter listed, the language server's formatter is used when one is attached.
- **Syntax parser (treesitter):** accurate highlighting. Any language not installed yet is downloaded and
  built automatically the first time you open that kind of file.

The Lua server is set up for editing this config: it knows Neovim's own API, so `vim.` completes and `K` shows
its documentation. It does not know plugin modules, so `require("telescope.builtin").` will not complete.
Give it a few seconds after opening a Lua file before it answers.

### Tools Mason installs

Listed under `ensure_installed` in `lua/McKearnyPlum/config/lsp.lua`. They live in
`~/.local/share/nvim/mason/` and are only visible to Neovim, not to your shell.

| Tool                           | Kind            | Used for                                      | Mason needs |
| ------------------------------ | --------------- | --------------------------------------------- | ----------- |
| lua-language-server (`lua_ls`) | Language server | Lua                                           | nothing     |
| pyright                        | Language server | Python                                        | npm         |
| json-lsp (`jsonls`)            | Language server | JSON                                          | npm         |
| stylua                         | Formatter       | Lua                                           | nothing     |
| black                          | Formatter       | Python                                        | python3     |
| prettier                       | Formatter       | JS, TS, CSS, HTML, JSON, YAML, Markdown       | npm         |
| isort                          | Import sorter   | Python (installed, not hooked up to save yet) | python3     |
| tree-sitter-cli                | Build tool      | Compiling syntax parsers                      | nothing     |

### Adding a language

1. Add the server and formatter names to `ensure_installed` in `lua/McKearnyPlum/config/lsp.lua`
   (browse names with `:Mason`).
2. Add the server to the `vim.lsp.enable({ ... })` list in the same file.
3. Add the formatter under `formatters_by_ft` in `after/plugin/conform.lua`.
4. Restart Neovim. The syntax parser installs itself when you first open a file of that type.

## Editor options

Set in `lua/McKearnyPlum/set.lua` and `after/plugin/undotree.lua`.

| Setting                              | Effect                                                                                 |
| ------------------------------------ | -------------------------------------------------------------------------------------- |
| Relative line numbers                | Current line shows its real number, others show the distance, so `5j` is easy to judge |
| 4-space indentation, spaces not tabs | `tabstop`, `softtabstop`, `shiftwidth` = 4, `expandtab`                                |
| `smartindent`                        | New lines pick up sensible indentation                                                 |
| No line wrap                         | Long lines run off screen instead of wrapping                                          |
| Column marker at 111                 | Visual guide for line length                                                           |
| No swap or backup files              | Nothing extra is written next to your files                                            |
| Persistent undo                      | Undo history is kept in `~/.local/share/nvim/undo`                                     |
| Search highlight off, incremental on | Matches show while typing the search, then clear                                       |
| `scrolloff = 8`                      | Always keeps 8 lines visible above and below the cursor                                |
| Sign column always shown             | Text does not shift when diagnostics appear                                            |
| `updatetime = 50`                    | Faster reaction for plugins that wait for you to pause                                 |
| True color                           | Needed for the theme                                                                   |

## Neovim basics refresher

### Modes

| Mode         | Enter with                               | For                               |
| ------------ | ---------------------------------------- | --------------------------------- |
| Normal       | `Esc` or `jk`                            | Moving around and giving commands |
| Insert       | `i` `a` `o` `I` `A` `O`                  | Typing text                       |
| Visual       | `v` characters, `V` lines, `<C-v>` block | Selecting                         |
| Command line | `:`                                      | Running commands                  |
| Terminal     | `<leader>t`                              | A shell inside Neovim             |

Ways into insert mode: `i` before the cursor, `a` after it, `I` at the start of the line, `A` at the end,
`o` on a new line below, `O` on a new line above.

### Save and quit

| Command       | Action                       |
| ------------- | ---------------------------- |
| `:w`          | Save                         |
| `:q`          | Close the window             |
| `:wq` or `ZZ` | Save and close               |
| `:q!`         | Close and throw away changes |
| `:qa`         | Quit everything              |
| `:e <file>`   | Open a file                  |

### Moving

| Keys                  | Moves                                                                 |
| --------------------- | --------------------------------------------------------------------- |
| `h` `j` `k` `l`       | Left, down, up, right                                                 |
| `w` / `b` / `e`       | Next word / previous word / end of word                               |
| `0` / `^` / `$`       | Start of line / first non-blank / end of line                         |
| `gg` / `G`            | Top / bottom of the file                                              |
| `12G` or `:12`        | Line 12                                                               |
| `{` / `}`             | Previous / next blank-line-separated block                            |
| `%`                   | Matching bracket                                                      |
| `f<char>` / `t<char>` | Onto / just before the next `<char>` on the line (`;` and `,` repeat) |
| `<C-d>` / `<C-u>`     | Half a page down / up                                                 |
| `<C-o>` / `<C-i>`     | Back / forward through places you have jumped                         |
| `zz`                  | Center the screen on the cursor                                       |

A number in front repeats a movement: `5j` goes down five lines, `3w` forward three words.

### Editing is "verb + noun"

An **operator** (what to do) followed by a **motion or text object** (what to do it to).

| Operator    | Meaning                      |
| ----------- | ---------------------------- |
| `d`         | Delete (cut)                 |
| `c`         | Change (delete, then insert) |
| `y`         | Yank (copy)                  |
| `>` / `<`   | Indent / unindent            |
| `=`         | Fix indentation              |
| `gc`        | Comment                      |
| `gu` / `gU` | Lowercase / uppercase        |

| Text object | Selects                                                |
| ----------- | ------------------------------------------------------ |
| `iw` / `aw` | A word / a word plus its space                         |
| `i"` / `a"` | Inside quotes / including the quotes                   |
| `i(` / `a(` | Inside parentheses / including them (also `[` `{` `<`) |
| `it` / `at` | Inside / around an HTML tag                            |
| `ip` / `ap` | A paragraph                                            |

Put together: `diw` delete the word, `ci"` change what is inside the quotes, `yap` copy the paragraph,
`da(` delete the parentheses and their contents, `>ip` indent the paragraph.

Doubling an operator applies it to the line: `dd`, `yy`, `cc`, `>>`.

| Keys          | Action                                 |
| ------------- | -------------------------------------- |
| `x`           | Delete the character under the cursor  |
| `r<char>`     | Replace one character                  |
| `p` / `P`     | Paste after / before the cursor        |
| `u` / `<C-r>` | Undo / redo                            |
| `.`           | Repeat the last change                 |
| `D` / `C`     | Delete / change to the end of the line |
| `~`           | Flip the case of a character           |

### Search and replace

| Keys / command    | Action                                                   |
| ----------------- | -------------------------------------------------------- |
| `/text` / `?text` | Search forward / backward                                |
| `n` / `N`         | Next / previous match                                    |
| `*` / `#`         | Search for the word under the cursor, forward / backward |
| `:%s/old/new/g`   | Replace everywhere in the file                           |
| `:%s/old/new/gc`  | Same, asking before each one                             |
| `:s/old/new/g`    | Replace on the current line, or in the selection         |

### Registers and macros

Everything you yank or delete goes into a register. `"` picks one: `"ayy` yanks a line into register `a`,
`"ap` pastes it.

| Register  | Holds                                 |
| --------- | ------------------------------------- |
| `"`       | The last yank or delete (the default) |
| `0`       | The last yank only                    |
| `+`       | The system clipboard                  |
| `_`       | Nothing: the "black hole"             |
| `a` – `z` | Whatever you put there                |

`:reg` lists them all.

A macro records keystrokes to replay: `qa` starts recording into `a`, `q` stops, `@a` plays it, `@@` plays it
again, `10@a` plays it ten times.

### Windows, buffers and tabs

A **buffer** is an open file. A **window** is a view onto a buffer. A **tab** is a layout of windows.

| Keys / command         | Action                                      |
| ---------------------- | ------------------------------------------- |
| `:sp` / `:vs`          | Split horizontally / vertically             |
| `<C-w>h` `j` `k` `l`   | Move to the window left / down / up / right |
| `<C-w>w`               | Cycle through windows                       |
| `<C-w>q`               | Close the window                            |
| `<C-w>o`               | Close every other window                    |
| `<C-w>=`               | Make all windows equal size                 |
| `:ls`                  | List buffers                                |
| `]b` / `[b`            | Next / previous buffer                      |
| `<C-^>`                | Flip to the previous buffer                 |
| `:bd`                  | Close the buffer                            |
| `:tabnew`, `gt` / `gT` | New tab, next / previous tab                |

### Marks

`ma` sets mark `a` at the cursor, `` `a `` jumps back to it and `'a` jumps to its line. Capital letters (`mA`)
work across files. ` `` ` returns to where you were before the last jump.

### Getting help

| Command                      | Shows                                           |
| ---------------------------- | ----------------------------------------------- |
| `:help <topic>`              | Documentation, for example `:help text-objects` |
| `:help <key>`                | What a key does, for example `:help ctrl-w`     |
| `:Tutor`                     | The built-in interactive tutorial               |
| `K` on a word in a help page | Follow the link (`<C-o>` goes back)             |

## Maintenance and troubleshooting

| Command                                    | Use it to                                                                           |
| ------------------------------------------ | ----------------------------------------------------------------------------------- |
| `:Lazy`                                    | Manage plugins (`U` update, `S` sync, `X` clean, `q` close)                         |
| `:Mason`                                   | Manage language servers and formatters (`i` install, `U` update all, `X` uninstall) |
| `:MasonToolsInstall` / `:MasonToolsUpdate` | Install missing / update the tools in `ensure_installed`                            |
| `:TSUpdate`                                | Update syntax parsers                                                               |
| `:TSInstall <language>`                    | Install a parser by hand                                                            |
| `:ConformInfo`                             | See which formatters apply to this file, and the formatter log                      |
| `:checkhealth`                             | Run every health check                                                              |
| `:checkhealth vim.lsp`                     | See which language servers are attached and how they are configured                 |
| `:lsp restart`                             | Restart the language servers for this buffer                                        |
| `:messages`                                | Re-read errors that flashed past                                                    |
| `:verbose map <keys>`                      | Find out what a key is mapped to and which file set it                              |
| `:Inspect`                                 | Show the highlight groups under the cursor                                          |

Log files are in `~/.local/state/nvim/`: `lsp.log`, `mason.log`, `conform.log` and `nvim.log`.

**Something is not working?**

- _No completion, hover or errors in a file:_ run `:checkhealth vim.lsp`. If the server is missing, open
  `:Mason` and check that it installed (pyright, jsonls and prettier need `npm`).
- _File does not format on save:_ run `:ConformInfo`.
- _No colors in a file type:_ run `:checkhealth nvim-treesitter`. It needs the `tree-sitter` CLI (from Mason)
  and a C compiler.
- _Boxes or question marks instead of icons:_ the terminal is not using a Nerd Font.
- _Clipboard yanks do nothing:_ install `xclip` or `wl-clipboard`, then check `:checkhealth vim.provider`.

## Gotchas

- **`<leader>p` and `<leader>f` pause for up to a second.** `<leader>pv`, `<leader>ff` and `<leader>fg` begin
  with the same keys, so Neovim waits to see whether you will type more. Pressing another key ends the wait.
- **Some default keys are replaced.** `<C-e>` opens Harpoon instead of scrolling one line. `<C-j>` and `<C-k>`
  step through the quickfix list. `Q` does nothing. In visual mode `J` and `K` move lines instead of joining
  them or looking up help.
- **Search matches are not left highlighted** (`hlsearch` is off). Use `n` and `N` to step through them.
- **There are no swap files.** Edits since your last save are lost if Neovim is killed. Undo history is written
  each time you save, so everything up to that save can still be undone later.
- **`isort` is installed but not run on save.** Python is formatted by black only.
- **JavaScript and TypeScript have formatting but no language server.** Add `ts_ls` by following
  [Adding a language](#adding-a-language) if you want one.
- **`lazy-lock.json` is ignored by git,** so plugin versions are not pinned and a fresh install pulls the latest
  of everything.
- **Never map `<C-[>`.** Terminals send it as `Esc`, so the mapping fires every time you press `Esc`.
