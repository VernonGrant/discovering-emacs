# 4 - Using Whitespace Mode

[Listen To Episode](https://www.discovering-emacs.com/2134279/12444688-4-using-whitespace-mode) | [YouTube Video](https://youtu.be/uViGjSqrLDw)

Today, we're taking a look at Emacs's `whitespace-mode` and discussing how we can simplify its configuration to make it more applicable for most use cases.

## Introduction

Emacs has by far the most comprehensive whitespace rendering capabilities, that I've come across in any text editor. It has the basics that you would expect, such as rendering spaces, tabs and line breaks. But it also offers much more, it provides whitespace reports, performs cleanup operations and gives us fine grained control of what types of whitespace to render depending on the context. For example, we can highlight spaces that are in front of tabs, long lines, big indentations and much more.

But unfortunately, with Emacs's whitespace mode being so feature rich, it can be misunderstood by new users, coming from other text editors. As by default, enabling `whitespace-mode` will render a wide array of whitespace criteria, that at first sight seems strange and confusing. And the end result is usually (even in my personal experience), to just keep whitespace mode disabled. When in reality I would much rather have whitespace visible at all times.

And that's the goal for today's episode, to make `whitespace-mode` more applicable to new Emacs users and for general use cases.

## Specifying a whitespace style

We can define what types of whitespace should be shown, by specifying the whitespace style. We do this by modifying the configuration option `whitespace-style`. It takes a list, consisting of the types of whitespace that you would like visualize. There's a large number of types available, but our goal here is to just show the bare minimum. If you want to see all the available options, you can press `C-h v` and type in `whitespace-style`.

So to keep things simple I recommend you set the whitespace style configuration list to include the following:

```Lisp
;; Define the whitespace style.
(setq-default whitespace-style
              '(face spaces empty tabs newline trailing space-mark tab-mark newline-mark))
```

With just this configuration change, the behavior of Emacs's whitespace mode will become much more familiar, in regards to how other text editors visualize whitespace.

## Dealing with whitespace coloring issues

Seeing as whitespace mode is so seldomly used, most themes don't define proper whitespace coloring. Generally speaking, you want whitespace to appear in a faded manner, to be visible, but not distracting. To help you with potential theming issues, I included some Emacs lisp code that you can place inside of your configuration file to help easily adjust the whitespace color by certain percentage.

```Lisp
;; Whitespace color corrections.
(require 'color)
(let* ((ws-lighten 30) ;; Amount in percentage to lighten up black.
       (ws-color (color-lighten-name "#000000" ws-lighten)))
  (custom-set-faces
   `(whitespace-newline                ((t (:foreground ,ws-color))))
   `(whitespace-missing-newline-at-eof ((t (:foreground ,ws-color))))
   `(whitespace-space                  ((t (:foreground ,ws-color))))
   `(whitespace-space-after-tab        ((t (:foreground ,ws-color))))
   `(whitespace-space-before-tab       ((t (:foreground ,ws-color))))
   `(whitespace-tab                    ((t (:foreground ,ws-color))))
   `(whitespace-trailing               ((t (:foreground ,ws-color))))))
```

## Specifying what symbols should represent whitespace

There's a configuration option named `whitespace-display-mappings`, that you can use to specify what Unicode character should be use to visualize a specific whitespace. It takes a two dimensional list, where each inner list consists of a `kind`, which can be either `tab-mark`, `space-mark` and `newline-mark`. After which you specify the character you want to replace, and lastly, you specify a `vector` that holds the characters to use for the replacement purpose. You can specify multiple vectors to act as fallbacks, in case a Unicode symbol isn't available.

I'll share my configuration as an example in show notes.

```Lisp
;; Make these characters represent whitespace.
(setq-default whitespace-display-mappings
      '(
        ;; space -> · else .
        (space-mark 32 [183] [46])
        ;; new line -> ¬ else $
        (newline-mark ?\n [172 ?\n] [36 ?\n])
        ;; carriage return (Windows) -> ¶ else #
        (newline-mark ?\r [182] [35])
        ;; tabs -> » else >
        (tab-mark ?\t [187 ?\t] [62 ?\t])))
```

## Enabling whitespace mode globally

We can enable whitespace mode globally by calling `global-whitespace-mode`. The downside of this is that whitespace will be rendered inside of every Emacs buffer and this is really not necessary. For example, I don't want whitespace to be rendered inside `shell`, `occur` or `ibuffer` windows.

Luckily there's an option available to control which modes should enable whitespace mode when `global-whitespace-mode` is enabled. And it's aptly named, `whitespace-global-modes`. This option takes a list of major mode symbol names, that when matched, will enable `whitespace-mode`. We can also negate the list, by prefixing it with `not`, causing global whitespace mode to be disabled for the listed major mode symbols. And that's the way I configure it myself.

```Lisp
;; Don't enable whitespace for.
(setq-default whitespace-global-modes
              '(not shell-mode
                    help-mode
                    magit-mode
                    magit-diff-mode
                    ibuffer-mode
                    dired-mode
                    occur-mode))
```

## Making use of cleanup actions

One benefit of having whitespace mode enabled globally, is that we can take advantage of the whitespace actions feature. This features allows us to automatically run a series of actions after a buffer is written.

Today we're only really interested in the cleanup actions. These cleanup actions will perform different operations based on the defined whitespace style. For our defined whitespace style the following actions will be formed on cleanup.

- It will remove all empty lines at beginning and/or end of the buffer.
- It will remove all trailing tabs and spaces.

```Lisp
;; Set whitespace actions.
(setq-default whitespace-action
              '(cleanup auto-cleanup))
```

If you want to seen all the available cleanup operations, in relation to different `whitespace-style` options. You can press `C-h f` and type in `whitespace-cleanup`.

## Conclusion

Emacs's whitespace mode has a great degree of flexibility and power. If gives you control over what types whitespace should be given attention, how they should be visualized and cleaned. If you have been avoiding whitespace mode in Emacs, I hope this episode might encourage you to give it a try.

And as always you can find a link to the episodes detailed show notes in the description of this episode. And if you have some suggestions, corrections or need help, please feel free to open up a new discussion in the discussions section of the podcast's repository.

Thanks for listing and stay tuned for the next episode of [Discovering Emacs](https://www.discovering-emacs.com).
