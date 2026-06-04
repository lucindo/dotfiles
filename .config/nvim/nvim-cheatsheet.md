# Neovim cheatsheet

Leader = `Space`. Open this file fast with `<leader>sn` (search nvim config).

## Textobjects (mini.ai)

Use with an operator (`d` `c` `y`) or visual (`v`), then `a` (around) or `i` (inside).

### Treesitter-aware (this config)
| keys      | object                         |
|-----------|--------------------------------|
| `af` `if` | function (outer / inner)       |
| `ac` `ic` | class                          |
| `aa` `ia` | argument / parameter           |
| `ao` `io` | code block (if / for / while)  |

### Built-in
| keys      | object                               |
|-----------|--------------------------------------|
| `a)` `i)` | parentheses (also `b` = any bracket) |
| `a]` `i]` | square brackets                      |
| `a}` `i}` | braces                               |
| `a'` `a"` `` a` `` | quotes (also `q` = any quote)|
| `at` `it` | HTML/XML tag                         |
| `a?` `i?` | prompt for custom pair               |

### Modifiers
- `an`/`in` = **next** match, `al`/`il` = **last** match — e.g. `cin)` change inside next `()`.
- counts: `2if`, `va2)`.
- `g[` / `g]` jump to left/right edge of the textobject.

### Examples
- `vaf` select whole function · `dif` delete its body
- `cic` change class body · `daa` delete an argument (+comma)
- `yao` yank enclosing block · `ci"` change inside quotes
- `cib` change inside nearest bracket · `ciq` inside nearest quote

## Surround (mini.surround) — `gs` prefix

| keys                | action            |
|---------------------|-------------------|
| `gsa{motion}{char}` | add surround      |
| `gsd{char}`         | delete surround   |
| `gsr{old}{new}`     | replace surround  |
| `gsf` / `gsF{char}` | find right / left |
| `gsh{char}`         | highlight         |

Chars: `)`/`b` parens · `]` `}` brackets · `t` tag (prompts) · `f` function call (prompts) · `'` `"` `` ` `` quotes · `?` custom.

### Examples
- `gsaiw)` wrap word in `()` · `gsa$"` quote to end of line
- `gsd)` remove parens · `gsr)'` turn `()` into `''`
- `gsaif}` wrap a function body in `{}` (uses the mini.ai object above)
- visual: select, then `gsa)` to wrap

## Flash (jump) — bare `s`
- `s{chars}` jump · `S` treesitter select · `r`/`R` remote (operator) · `<c-s>` toggle in `/` search

## Comments (mini.comment)
- `gcc` line · `gc{motion}` e.g. `gcip` paragraph · `gc` in visual

---

## Search — `<leader>s` (telescope)
| keys              | action                          |
|-------------------|---------------------------------|
| `<leader>sf`      | find files                      |
| `<leader>sg`      | live grep                       |
| `<leader>sw`      | grep word under cursor          |
| `<leader>sd`      | diagnostics                     |
| `<leader>sr`      | resume last picker              |
| `<leader>s.`      | recent files                    |
| `<leader>sb`      | list buffers                    |
| `<leader><leader>`| find buffers                    |
| `<leader>sh`      | help tags                       |
| `<leader>sk`      | keymaps                         |
| `<leader>ss`      | telescope builtins              |
| `<leader>sn`      | nvim config files               |
| `<leader>/`       | fuzzy find in current buffer    |
| `<leader>s/`      | live grep in open files         |

## Git — `<leader>g`
| keys         | action                       |
|--------------|------------------------------|
| `<leader>gs` | status (fugitive)            |
| `<leader>ga` | add / stage current file     |
| `<leader>gd` | diff split                   |
| `<leader>gC` | commit                       |
| `<leader>gp` | push                         |
| `<leader>gP` | pull                         |
| `<leader>gl` | log                          |
| `<leader>gb` | branches (search)            |
| `<leader>gB` | blame (gitsigns)             |
| `<leader>gh` | buffer commit history        |
| `<leader>gH` | repo commit history (search) |
| `<leader>gf` | git files (search)           |

## LSP (buffer-local, on attach)
| keys         | action                              |
|--------------|-------------------------------------|
| `grd`        | go to definition                    |
| `grD`        | go to declaration                   |
| `grr`        | references                          |
| `gri`        | implementation                      |
| `grt`        | type definition                     |
| `grn`        | rename                              |
| `gra`        | code action                         |
| `gO`         | document symbols                    |
| `gW`         | workspace symbols                   |
| `<leader>f`  | format buffer (conform)             |
| `<leader>xl` | lint current file                   |

## Toggle — `<leader>t`
| keys         | action                          |
|--------------|---------------------------------|
| `<leader>te` | file explorer (Oil)             |
| `<leader>tt` | terminal split                  |
| `<leader>tf` | auto-format on save             |
| `<leader>tc` | treesitter context              |
| `<leader>to` | symbol outline                  |
| `<leader>td` | diagnostics virtual text        |
| `<leader>tl` | diagnostics virtual lines       |
| `<leader>th` | inlay hints                     |

## Trouble / lists — `<leader>x`
| keys         | action                          |
|--------------|---------------------------------|
| `<leader>xx` | diagnostics                     |
| `<leader>xX` | buffer diagnostics              |
| `<leader>xs` | symbols                         |
| `<leader>xd` | LSP defs / refs                 |
| `<leader>xL` | location list                   |
| `<leader>xQ` | quickfix list                   |
| `<leader>xt` | TODO list                       |

## Editing & windows
| keys                  | action                            |
|-----------------------|-----------------------------------|
| `<Esc>`               | clear search highlight            |
| `Y`                   | yank to end of line               |
| `J`                   | join lines, keep cursor           |
| `<leader>p` (visual)  | paste without yanking             |
| `<leader>R`           | replace word under cursor (file)  |
| `<A-j>` / `<A-k>`     | move line/selection down / up     |
| `<` / `>` (visual)    | indent and reselect               |
| `n` / `N`             | next/prev search, centered        |
| `<C-d>` / `<C-u>`     | half-page down/up, centered       |
| `<C-h/j/k/l>`         | move between windows              |
| `<C-Up/Down/Left/Right>` | resize window                  |
| `-`                   | open parent dir (Oil)             |
| `<leader>u`           | undo tree                         |
| `<Esc><Esc>`          | exit terminal mode                |
