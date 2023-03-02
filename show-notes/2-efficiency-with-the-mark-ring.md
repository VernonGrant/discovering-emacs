# 2 - Efficiency With The Mark Ring

[Listen to episode](https://www.discovering-emacs.com/2134279/12309075-2-efficiency-with-the-mark-ring) | [YouTube Video](https://youtu.be/uhyr8kvKa2I)

## What is the mark ring

The mark ring feature maintains a record of previous locations. Emacs offers two types of mark rings, local and global. Both of these keeps track of previous locations and are limited to a certain number of marks. A user can cycle through the mark ring, jumping between locations. Marks are automatically added before or after performing certain actions, but most importantly, they can be added by the user.

The act of manually placing marks was much more popular in the past, maybe because most developers were working on a single monitor with limited screen real estate. Having the ability to manually set marks, was a great way to increase productivity and save time, because developers could slingshot themselves between locations. Back then there was no `transient-mark-mode`, so regions in emacs was not visually displayed, and so developers had to remember where they placed the last mark.

Some Emacs users still chooses to disable `transient-mark-mode` today. Although, this is not recommended and we won't be touching on this in detail, it does allow some aspects of mark setting to become more efficient. I might be mistaken, but I believe "Jonathan Blow", the creator of braid and the witness, still uses this workflow. So if your interested in seeing this in action, you can probably go checkout some of his online steams.

## Understanding the local and global mark rings

Each buffer in Emacs has its own local mark ring. Marks are automatically added to the this mark ring after certain actions are performed. A user can also manually add marks where needed.

In addition to the local mark ring, Emacs also offers a global mark ring. The global mark ring holds marks across multiple buffers, meaning, it can be used to cycle through previous buffers, landing at specific locations. But, its behavior is admittedly very confusing, one would expect the global mark ring to contain a single mark for each buffer and to update that mark to the most recent local mark for each individual buffer. But this is not the case, the same buffer can have multiple marks entries inside of the global mark ring.

After writing some Emacs Lisp code to look at the global mark rings state, it became clear that my intuition on how the global mark ring works, was wrong. And based on my experiment, I concluded that a mark, is only added to the global mark ring if the following two condition are met:

1. The mark at the top of the global mark ring's stack (or the latest global mark), must not be for the same buffer.
2. The mark must be unique (or a different location) from previous entries that matches the buffer.

In essence, you can only change a buffers global mark, if the latest global mark in the stack, is not for the same buffer. And the mark your trying to set is unique in the context of the global mark ring.

One configuration change I would like to suggest, is to decrease the mark limits of both the local and global mark rings, you can do this using these configuration options:

```Lisp
(setq mark-ring-max 6)
(setq global-mark-ring-max 8)
```

By default, both of these have a value of 16 and decreasing this to around 8, makes using the mark ring much more efficient.

## How marks are added

It's important to know when Emacs chooses to automatically add a mark to the mark rings. Building up an intuition for when Emacs adds marks, will help you better understand where the next jump will take you. One tip is to keep an eye on the mini buffer, for the words "Mark Set", obviously indicating that a mark has been added. Here is some of the most common actions that automatically adds new marks:

- Any time you start a new region, a mark will be placed at the beginning. The same is true for rectangle selections and using a mouse to drag out regions.
- Yanking will place a mark at the starting point. So after pasting something into a buffer, you can jump back to the original location. We will be coving
  jumping shortly.
- I-Search will also place marker before navigating to the selected term.
- Using certain commands such as `goto-line`, `insert-file`, `insert-abbrevs` and so on, will place a mark before the action takes place.

Aside from marks being automatically added, a user can also manually set marks, using `C-SPC C-SPC`. Basically, starting and ending a regional selection.

## How to jump between marks

By default you can jump between local marks using `C-u C-SPC` and repeating this key combination will cycle you through each mark in the local mark ring. This is where the configuration option `set-mark-command-repeat-pop` comes in handy. Setting it to a non nil value, will eliminate the need to repeat this key binding for each jump. With this option set, you can press `C-u C-SPC`, leave the control key down and just continue tapping space to cycle through the local mark ring.

```Lisp
(setq-default set-mark-command-repeat-pop t)
```

This configuration option also effects the binding for the global mark ring, which is `C-x C-SPC`, so instead of tediously repeating this for each global mark jump. You can also just type `C-x C-SPC`, keep control down and just tap away at the space bar to cycle through the global mark ring.

## Conclusion

The mark ring feature once mastered, can be a real productivity boost and time saver. I really hope this episode provided you with some value and that you decide to start to incorporate the kill ring feature it into your daily workflow.

And as always you can find a link to the episodes detailed show notes in the description of this episode. And if you have some suggestions, corrections or need help, please feel free to open up a new discussion in the discussions section of the podcast's repository.

Thanks for listing and stay tuned for the next episode of [Discovering Emacs](https://www.discovering-emacs.com).
