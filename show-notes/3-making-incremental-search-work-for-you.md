# 3 - Making Incremental Search Work for You

[Listen To Episode](https://www.discovering-emacs.com/2134279/12359134-3-making-incremental-search-work-for-you) | [YouTube Video](https://youtu.be/9CdbfZXsrqg)

Today I'm going to share some of the ways I utilize Emacs's incremental search, during my workflow. In addition I'll be sharing some configuration recommendations that you might also find useful.

## Displaying the number of matches in the Minibuffer

By default incremental search does not provide any indication of the total number of matches that where found for current search term. It also doesn't show us how many more matches we can navigate forward or backward before wrapping, would occur.

Luckily, there's a configuration option that solves both of these issues. Setting the option `isearch-lazy-count` to a non nil value, will provide an indicator in the minibuffer that shows the total number of matches found, and how many more lies ahead or behind the current match.

```Lisp
(setq-default isearch-lazy-count t)
```

Having the minibuffer display the total number of matching terms, helps me a lot in terms of awareness. Knowing exactly how many matches where found and how far along I am, is a great convenience and helps with my intuition when navigating through a file's source code.

## Making use of the search rings

Incremental search does also have a search ring. The search ring is basically just a list that contains your previous search terms. Having the option to bring back some of your previous searches is major time saver and I find myself using it all the time.

The way in which you navigate the search ring, is by simplify pressing `M-p`, to advance and `M-n` to retreat. My typical use case will be to activate incremental search by pressing `C-s` and then immediately hitting `M-n` repeatedly, until I find the previous search term I'm looking for.

Please also be aware that there's actually two search rings, one for regular searches and another for regular expression searches. By default, both of these will store a maximum of 16 search terms. You can how ever customize the size of these rings by using the following two configuration options:

```Lisp
    (defcustom search-ring-max 26)
    (defcustom regexp-search-ring-max 26)
```

## Using its yanking capabilities

Incremental search has the ability to yank things into the current search string. This is by far one of the features I use the most, and not just for searching purposes. The most common yanking option is to make use of `C-w`, to pull the word that's in front of the cursor into the current search term.

Let's go over a practical example: You place the cursor in front of two separate words that you would like to search for. First you activate incremental search by pressing `C-s` and then you press `C-w` and the search term will expand, so it includes the first word. Pressing `C-w` a second time will pull the next word into the search term. The incremental search now contains both words and so you can now continue jumping to other matches by pressing `C-s`.

It's almost like the selection expansion feature you might find in other code editors. I find myself using this feature to quickly yank one or more words, so I can perform a quick search, do a query replacements or simply just do a basic yank.

Here's some more yanking shortcuts you can use:

- `C-M-y`, Can be used to yank one char at a time.
- `C-M-z`, Can be used to yank up until a character. I sometimes use this inside of long strings to yank everything up until the ending quote.
- `M-s C-e`: Can be used to yank the rest of the line.

Emacs 27.1 added the option to make all standard movement keys automatically perform yanking operations when, incremental search is active. I don't personally use this, but you try it out by setting `isearch-yank-on-move` to a non nil value.

```Lisp
(setq-default isearch-yank-on-move t)
```

One other set of key bindings worth mentioning here is `C-y` and `M-y`. They allow you to take an entry from the kill ring and append it to the current search term. So, if I wanted to search for something matching a previous kill, I can simplify activate incremental search and hit `C-y`. You can also use `M-y` to cycle through earlier kill ring entries.

## Performing quick query replacements

This might be common knowledge but I think it's still worth mentioning that you can transition from incremental search to query replacement by typing `M-%`. And with the aforementioned yanking capabilities you can use incremental search as a convenient precursor to query replacement.

## Jumping to first and last match

Sometimes after starting a search you might want to navigate to the very first or last match. You can do this by pressing `M-s M-<` to jump to the beginning and `M-s M->` to jump to the end.

You can also set the option `isearch-allow-motion` to enable the standard vertical motion key bindings of `M-<` (beginning-of-buffer), `M->` (end-of-buffer), `C-v` (scroll-up-command) and `M-v` (scroll-down-command).

## Triggering occur form incremental search

Another great way to make use of incremental search is by using it as a precursor to Occur. You can use the current search term as an regular expression for Occur by pressing `M-s o`. Use this if you need to make changes to some of the matches, by directly editing them inside of Occur.

## Conclusion

Incremental search can be used for much more than just searching. It can be utilized to become a convenient little helper, and once mastered, it becomes a great precursor to many additional operations. Ultimately making things more intuitive and faster to perform.

And as always you can find a link to the episodes detailed show notes in the description of this episode. And if you have some suggestions, corrections or need help, please feel free to open up a new discussion in the discussions section of the podcast's repository.

Thanks for listing and stay tuned for the next episode of [Discovering Emacs](https://www.discovering-emacs.com).
