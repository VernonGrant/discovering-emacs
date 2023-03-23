# 5 - Essential Movement and Editing Shortcuts

[Listen To Episode]() | [YouTube Video]()

In today's episode I'll be sharing some default movement and editing shortcuts. I'll only be cover some of the essentials, but I'm sure there's something new for both beginners and experienced Emacs users. At the end I'll share some key binding recommendations to make the editing experience in Emacs slightly better.

## Movement shortcuts

There's obviously the basic character and word movements shortcuts, that I'm sure most of you already know, but for those new to Emacs. You can use `C-f` to move one character forward, `C-b` to move one character backward. And to move by word, you can use `M-f` and `M-b`.

There's also the basic `C-a` and `C-e` to move to the beginning and end of a line, and finally there's `C-p` and `C-n` to move up and down lines.

With the basics out of the way, let's now cover some more interesting bindings:

- `M-m`: Moves the cursor to the true beginning of a line, in other words it moves the cursor to the indentation or to the first character ignoring the white space.
- `M-<`,`M->` Jumps to the beginning and end of the buffer. Keep in mind that a mark is set before the jump takes place.
- `C-v`, `M-v` Moves the cursor a up a page or down a page, useful for faster vertical movement for file scanning.
- `M-g M-g` Moves the cursor to the specified line number. You can also prefix this command to avoid the mini buffer prompt. (We'll cover prefixing commands later)
- `C-l` Will cycle the cursors line between the center, top and bottom of the current window's view port.
- `M-r` Will cycle the cursor position between the center, top and bottom of the current windows view port.

## Taking advantage of the s-expression shortcuts

Aside from the aforementioned movement shortcuts, I find myself making heavy use Emacs's s-expression shortcuts. These are intended for lisp like programming languages, but in Emacs they actually work for almost all languages. If your unfamiliar with Emacs's s-expression shortcuts and how to use them, let me give you an example use case:

Imagine you open up a C source file that defines a series of functions. We can make use of the s-expression shortcuts, `C-M-p` and `C-M-n` to vertically move the cursor between each function, as long as the cursor is at the file's root level. If the cursor was somewhere inside a function, we can move the cursor to an outer block, using `C-M-u` (think of it as, up) and we can do the opposite by moving the cursor into deeper blocks, using `C-M-d` (think of this as, down).

Emacs provides a series of s-expression shortcuts for editing and movement commands. Be sure to give them a try, and you might also find them invaluable.

## Making use of prefixes

Before we move on to the editing shortcuts, it's useful to know about Emacs's ability to prefix existing shortcuts with positive and negative counts. To demonstrate this we'll look at the `kill-word` shortcut, `M-d`. By default this binding deletes a word to the right of the cursor. If we prefixed this command by first pressing `M--` and then `M-d`. It will perform the operation in the opposite direction and delete the first word to the left of the cursor. This type of prefix is basically a negative count and it's officially referred to as a negative argument.

Many of Emacs's default shortcuts can be prefixed with such negative arguments, by either using `M--` or `C--`. We can also prefix shortcuts with positive counts that causes the operation to be performed multiple times. For example, if we wanted to delete 5 words to the right of the cursor. We would press `M-5`, followed by `M-d`. Such positive counts can also be negated, so if we wanted to delete 5 words to the left, we could press `M--`,`M-5` and `M-d`.

One important thing to notice here, is that we can either use control or meta for prefix operations. This provides you with a little bit more flexibility and convince when making use of prefix shortcuts. Emacs has a few more prefix shortcuts, but these seems to be the one's I find myself using the most. To recap:

- `M-{1,2,3...}`, `C-{1,2,3...}` Prefixes a command with a count. This count can also be negated using either `M--` or `C--`.
- `M--`, `C--` Prefixes a command with a negative argument of `-1`.

## Editing shortcuts

To keep things interesting, I'm only going to share the editing related shortcuts that I myself use on regular basis. Also keep mind that most of the following shortcuts do also accept prefixes.

- `C-d`, `M-d` Delete a character or word forward.
- `C-k` Kills everything to the right of the cursor, on the current line.
- `C-M-k` Kills the s-expression in front of the cursor. It can be used to kill entire code blocks.
- `C-<backspace>` Deletes a word to the left of the cursor.
- `M-i` Inserts horizontal white space.
- `M-\` Deletes horizontal white space.
- `M-^` Joins the current line with previous line. And when used with a negative prefix, it will join the following line with the current line.
- `M-SPC`, Insures that there's only one space between characters.
- `M-c,`, `M-u`, `M-l` Can be use to capitalize, uppercase or lowercase a word.
- `C-x C-o` Removes all extra blank lines above and below the cursor.
- `C-x C-;` Comments out the current line.
- `M-;` Can be used to comment out regions.
- `C-x z` Repeats last complex command. A complex command is one that used the mini buffer.
- `C-x i` Inserts a file's contents into the current buffer, at the cursors point.
- `C-x (, C-x ), C-x e` Can be used to quickly record, end and play a macro.
- `C-x h` Highlights the entire buffer.
- `C-M-\` Re indents the current region. It can also be used after directly yanking some source code into the buffer.
- `M-z` Called, Zap to char, kills everything forward up to and including the given character. (I'll also share a better solution a little later)
- `M-q` Fill paragraph.
- `C-x r t` When rectangle selection mode is active (`C-x SPC`), this shortcut replaces the contents of the rectangle selection with the provided string, on each line.

## Shortcut recommendations

Before I share these recommendations we should be aware of the following user key binding rule:

> Sequences consisting of `C-c` and a letter (either upper or lower case; ASCII or non-ASCII) are reserved for users;

Although I personally following this rule for most of my key bindings. The following recommendations chooses to ignore this rule for efficiency reasons. But feel free to rebind them as you would like.

Over time I found default `save-buffer` shortcut of `C-x C-s` to be a little bit cumbersome. So I rebound this action to `C-RET`.

```Lisp
;; Save the current buffer.
(define-key global-map (kbd "<C-return>") 'save-buffer)
```

When navigating between two or more splits, `C-x o` requires you to cycle through in one direction. You can however use a negative prefix, but I found the binding `C-x O` to travel in opposite direction more convenient.

```Lisp
;; Change window backward.
(define-key global-map (kbd "C-x O") (lambda ()
                                       (interactive)
                                       (other-window -1)))
```

To add a new line in Emacs, without breaking the current line into two, one must first move the cursor to the end, using `C-e`, before pressing the return key. I found, combining these two action using the shortcut `M-RET` to be of much use.

```Lisp
;; Opens a new line and places cursor on it, without breaking the current line.
(define-key global-map (kbd "<M-return>") (lambda ()
                                            (interactive)
                                            (move-end-of-line 1)
                                            (newline-and-indent)))
```

The last recommendation is to make use of `zap-up-to-char`, which I find much more useful than `zap-to-char`. One additional optimization is to abstract away the mini buffer prompt by using an interactive function. I chose to remap `C-z` for this purpose and with this modification I can now press `C-z` followed by any character, making Emacs kill everything up to but not including the character.

```Lisp
;; Zap up to char quickly.
(defun vg-quick-zap-up-to-char (p c)
  "The same as zap up to char, but without the mini buffer prompt.
P: The prefix argument or the count.
C: The character to zap up to."
  (interactive "P\nc")
  (let ((cnt (cond ((null p) 1)
                   ((symbolp p) -1)
                   (t p))))
    (zap-up-to-char cnt c)))
(define-key global-map (kbd "C-z") 'vg-quick-zap-up-to-char)
```

## Conclusion

Emacs has great set of default editing and movement shortcuts that once mastered can make you very productive. And to some degree, I think it's a shame that so many new users start off using Emacs with Vim emulation. Of course everyone is different, and what works for some might not work for others. But I would encourage new Emacs users to give the default key bindings a decent chance. Who knows, you might find yourself in appreciation of synergy they create across such a vast amount of different major modes.

And as always you can find a link to the episodes detailed show notes in the description of this episode. And if you have some suggestions, corrections or need help, please feel free to open up a new discussion in the discussions section of the podcast's repository.

Thanks for listing and stay tuned for the next episode of [Discovering Emacs](https://www.discovering-emacs.com).
