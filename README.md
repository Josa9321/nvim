# Neovim Configuration

Personal Neovim configuration with a focus on LaTeX/typesetting workflows,
scientific computing (Julia, Python), and C++ development. Built on Neovim
0.12+ with `vim.lsp.config` and managed via `lazy.nvim`.

## Tech Stack

| Category            | Tools |
|---------------------|-------|
| **Plugin Manager** | [lazy.nvim](https://github.com/folke/lazy.nvim) |
| **Language**       | Lua |
| **Completion**     | nvim-cmp, cmp-nvim-lsp, cmp-buffer, cmp-path, cmp-cmdline, cmp-latex-symbols, cmp-vimtex, cmp_luasnip |
| **Snippets**       | LuaSnip (with custom TeX snippets) |
| **LSP**            | texlab, basedpyright, clangd, julials, lua_ls, marksman, R (languageserver), ts_ls, html, cssls |
| **Treesitter**     | nvim-treesitter |
| **Fuzzy Finder**   | telescope.nvim, telescope-fzf-native.nvim, telescope-ui-select.nvim, telescope-bibtex.nvim |
| **File Explorer**  | neo-tree.nvim |
| **Git**            | gitsigns.nvim, vim-fugitive |
| **Statusline**     | vim-airline (simple theme) |
| **Colorscheme**    | rose-pine |
| **LaTeX**          | vimtex, texlab, tectonic (compiler), zathura (viewer) |
| **Debugging**      | nvim-dap, nvim-dap-ui, nvim-dap-virtual-text, nvim-dap-julia, cppdbg |
| **AI/LLM**         | opencode.nvim, copilot.lua, mcphub.nvim |
| **Markdown**       | render-markdown.nvim |
| **Terminal**       | betterTerm.nvim |
| **Navigation**     | harpoon (harpoon2), leap.nvim |
| **Session**        | persistence.nvim |
| **Misc**           | nvim-autopairs, vim-surround, undotree, trouble.nvim, csvview.nvim, cppman.nvim, cyclist.vim, image.nvim, snacks.nvim, plenary.nvim, nui.nvim, vim-dadbod |

## Project Structure

```
~/.config/nvim/
├── init.lua                  # Entry point — loads lazy.nvim then config
├── lazy-lock.json            # Locked plugin versions
├── .gitignore
├── lua/
│   ├── config/
│   │   ├── init.lua          # Requires all sub-configs
│   │   ├── lazy.lua          # lazy.nvim bootstrap + plugin spec import
│   │   ├── lsp.lua           # nvim-cmp setup + LSP client configs
│   │   ├── remap.lua         # Global key mappings
│   │   ├── set.lua           # Editor options (numbers, tabs, undo, etc.)
│   │   └── plugins/
│   │       ├── colors.lua    # Colorscheme + transparent background
│   │       ├── luasnip.lua   # Snippet engine setup + loader
│   │       ├── harpoon.lua   # Harpoon keymaps
│   │       ├── telescope.lua # Telescope find/grep/buffer keymaps
│   │       ├── autopairs.lua # Disable in Telescope/vim
│   │       ├── gitsigns.lua  # Gitsigns signs + `on_attach` mappings
│   │       ├── vimtex.lua    # Vimtex disable compiler (texlab handles it)
│   │       └── render-markdown.lua # Markdown rendering options
│   └── plugins/
│       ├── *.lua             # ~30 individual plugin specs (see below)
├── after/ftplugin/
│   ├── cpp.lua               # C++ compile-and-run mapping
│   ├── julia.lua             # Julia run mapping
│   ├── python.lua            # Python run mapping
│   ├── tex.lua               # TeX build/forward-search mappings
│   ├── markdown.lua          # Buffer-local wrap/spell settings
│   └── text.lua              # Buffer-local wrap/spell settings
└── LuaSnip/
    ├── all.lua               # Global snippet placeholder
    └── tex/
        ├── environments.lua  # LaTeX environment snippets
        ├── math.lua          # Math autosnippets (α, β, \frac, ...)
        ├── fonts.lua         # \texttt, \textit, \textbf
        └── delimeters.lua    # Delimiter snippets (stub)
```

## Key Features

### LaTeX & Typesetting

The configuration is heavily optimized for LaTeX work using the **tectonic**
compiler and **texlab** language server. Forward/inverse search works with
**Zathura**. Build is triggered via `<leader>rc` and forward search via
`<leader>rf`. Custom LuaSnip snippets under `LuaSnip/tex/` provide:
math autosnippets (`;a` → `\alpha`, `;b` → `\beta`, `ff` → `\frac{}`),
font commands (`ttt` → `\texttt`, `tit` → `\textit`, `tbf` → `\textbf`),
and environment snippets (itemize, enumerate, figure, table, etc.).
Vimtex provides syntax highlighting and text objects but delegates
compilation to texlab.

### Language Server Protocol

Languages configured with `vim.lsp.config` (Neovim 0.12+):

| Language      | Server          | Notes |
|---------------|-----------------|-------|
| LaTeX / Bib   | texlab          | tectonic compiler, zathura viewer |
| Python        | basedpyright    | Respects `$VIRTUAL_ENV` / `$CONDA_PREFIX` |
| C / C++       | clangd          | `--background-index`, `--clang-tidy` |
| Julia         | julials         | Uses Revise + LanguageServer.jl |
| Lua           | lua_ls          | LuaJIT runtime |
| Markdown      | marksman        | Built from source |
| R             | languageserver  | |
| TypeScript/JS | ts_ls           | |
| HTML          | vscode-html-language-server | |
| CSS           | vscode-css-language-server | |

### Completion

`nvim-cmp` configured with multiple sources and smart keybindings:
- `<C-n>` / `<C-p>` navigate or confirm single-entry
- `<CR>` confirms; expands luasnip if expandable
- `<C-e>` aborts completion
- Separate sources for `tex` and `txt` filetypes
- Cmdline completion for `/`, `?`, and `:`

### Debugging

`nvim-dap` with **cppdbg** (Microsoft C++ tools) and **Julia** debugger
supports. DAP UI opens automatically on attach/launch and closes on
termination. Keymaps: `<Leader>dt` toggle breakpoint, `<Leader>dc`
continue, `<F5>` step over, `<F6>` step into, `<F4>` step out.

### Terminal Management

Integrated terminals via `betterTerm.nvim`. Access up to 5 terminals with
`<C-0>` through `<C-4>`, select a terminal with `<leader>tt`, rename with
`<leader>tr`, and toggle tab bar with `<leader>tb`.

### Git Integration

`gitsigns.nvim` with Unicode sign columns (`┃`, `_`, `‾`, `┆`) and a full
suite of hunk operations (`<leader>hs` stage, `<leader>hr` reset,
`<leader>hp` preview, `<leader>hb` blame, `<leader>hd` diff).
Navigation with `]c` / `[c`. `vim-fugitive` provides the `:Git` command.

### Session Persistence

`persistence.nvim` saves and restores sessions automatically. On startup
with a file argument, the last session is loaded.

### File Navigation

- **Harpoon** (`harpoon2`): mark files with `<leader>a`, quick menu with
  `<C-e>`, jump to slots 1-6 via `<leader>1`–`<leader>6`.
- **Telescope**: `<leader>ff` find files, `<leader>fg` live grep,
  `<leader>fb` buffers, `<leader>fh` help, `<leader>fs` grep string,
  `<leader>fa` aerial outline.
- **Neo-tree**: toggle file explorer with `<leader>pv`.
- **Leap**: motion-based navigation via `s`.

### AI Assistance

- **opencode.nvim**: `<leader>oa` opens a full tab for AI interaction,
  `<leader>os` selects context, `go` / `goo` appends ranges or lines.
- **copilot.lua**: GitHub Copilot completions.
- **mcphub.nvim**: MCP server integration.

## Getting Started

### Prerequisites

- Neovim 0.12+ (uses `vim.lsp.config` API)
- A Nerd Font (for icons)
- Optional: `tectonic`, `zathura`, `clangd`, `basedpyright-langserver`,
  `lua-language-server`, `marksman`, `julia`, `R`, `typescript-language-server`

### Installation

```bash
git clone git@github.com:jplaroco/nvim-config.git ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```

On first launch, `lazy.nvim` bootstraps itself automatically. LSP servers,
treesitter parsers, and debug adapters may need manual installation per
your system's package manager.

> **Note**: Paths in `lua/config/lsp.lua` reference system-specific
> locations (e.g. `~/anaconda3/bin/basedpyright-langserver`,
> `~/Apps/marksman-linux-x64`). Adjust these to match your environment.
> C++ debugging requires the Microsoft cpptools extension downloaded to
> `~/ms-vscode.cpptools-<version>/`.

## Key Mappings Reference

### General

| Mode | Key       | Action |
|------|-----------|--------|
| n    | `<C-d>`   | Page down, center cursor |
| n    | `<C-u>`   | Page up, center cursor |
| n    | `<C-h>`   | Previous tab |
| n    | `<C-l>`   | Next tab |
| n    | `n` / `N` | Next/prev search result, center |
| n    | `j` / `k` | Smart `gj`/`gk` (wrap-aware) |
| n    | `gl`      | Go to end of line (`g$`) |
| n    | `gh`      | Go to start of line (`g^`) |
| n    | `<A-h/j/k/l>` | Window navigation |
| n    | `<C-arrows>` | Window resize |

### LSP

| Mode | Key          | Action |
|------|--------------|--------|
| n    | `gD`         | Go to declaration |
| n    | `gd`         | Go to definition |
| n    | `<leader>F`  | Format buffer |

### Telescope

| Mode | Key           | Action |
|------|---------------|--------|
| n    | `<leader>ff`  | Find files |
| n    | `<leader>fg`  | Live grep |
| n    | `<leader>fb`  | Buffers |
| n    | `<leader>fh`  | Help tags |
| n    | `<leader>fs`  | Grep string (prompt) |
| n    | `<leader>fa`  | Aerial outline |

### Git (Gitsigns)

| Mode | Key           | Action |
|------|---------------|--------|
| n    | `]c` / `[c`   | Next/prev hunk |
| n    | `<leader>hs`  | Stage hunk |
| n    | `<leader>hr`  | Reset hunk |
| n    | `<leader>hp`  | Preview hunk |
| n    | `<leader>hb`  | Blame line |
| n    | `<leader>hd`  | Diff this |
| n    | `<leader>hS`  | Stage buffer |
| n    | `<leader>hR`  | Reset buffer |
| n    | `<leader>tb`  | Toggle blame |
| n    | `<leader>tw`  | Toggle word diff |

### Harpoon

| Mode | Key          | Action |
|------|--------------|--------|
| n    | `<leader>a`  | Add file to list |
| n    | `<C-e>`      | Toggle quick menu |
| n    | `<leader>1`–`6` | Go to slot 1–6 |
| n    | `<A-p>` / `<A-n>` | Prev / next |

### Quickfix / Location

| Mode | Key            | Action |
|------|----------------|--------|
| n    | `<C-k>` / `<C-j>` | Next/prev quickfix |
| n    | `<leader>k` / `<leader>j` | Next/prev location |

### Filetype-Specific

| Filetype | Key            | Action |
|----------|----------------|--------|
| cpp      | `<leader>rc`   | Compile + run with clang++ |
| julia    | `<leader>rc`   | Run with `julia --project %` |
| python   | `<leader>rc`   | Run with `python %` |
| tex      | `<leader>rc`   | Build with tectonic (via texlab) |
| tex      | `<leader>rf`   | Forward search (zathura) |

### Other

| Mode | Key            | Action |
|------|----------------|--------|
| n    | `<leader>tc`   | Toggle system clipboard |
| n    | `<leader>tt`   | Select terminal |
| n    | `<leader>tr`   | Rename terminal |
| n    | `<leader>tb`   | Toggle terminal tab bar |
| n    | `<C-0>`–`<C-4>` | Toggle terminal 0–4 |
| n    | `<leader>u`    | Toggle undotree |
| n    | `<leader>pv`   | Toggle neo-tree |
| n    | `<leader>xx`   | Diagnostics (Trouble) |
| n    | `<leader>xX`   | Buffer diagnostics (Trouble) |
| n    | `<leader>cs`   | Document symbols (Trouble) |
| n    | `<leader>cl`   | LSP references (Trouble) |
| n    | `<leader>dt`   | Toggle DAP breakpoint |
| n    | `<leader>dc`   | DAP continue |
| n    | `<leader>oa`   | Open OpenCode in new tab |
| n, x | `<leader>os`  | Select OpenCode |
| n, x | `go`          | Append range to OpenCode |
| n    | `goo`         | Append line to OpenCode |
| n, t | `<C-,>` / `<C-.>` | Scroll OpenCode up/down |

## Plugins

All plugins are declared as individual Lua files under `lua/plugins/` and
auto-imported by `lazy.nvim`. Plugin-specific configuration lives in
`lua/config/plugins/`. The full locked set is recorded in
`lazy-lock.json`.

## Editor Settings

- Relative line numbers with absolute number on current line
- 4-space tabs, expandtab, smart indentation
- No line wrapping by default (enabled per-filetype for TeX, markdown, text)
- Undo history persisted to `~/.vim/undodir`
- `hlsearch` disabled, `incsearch` enabled
- `cursorline`, `signcolumn=yes:2`, `scrolloff=8`
- 50ms updatetime for faster plugin responsiveness
- Transparent background via rose-pine colorscheme
