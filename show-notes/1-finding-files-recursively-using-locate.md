# 1 - Finding Files Recursively Using Locate

[Listen to episode](https://www.discovering-emacs.com/2134279/12265945-1-finding-files-recursively-using-locate)

## What is locate?

Locate is a program that searches for a specific pattern inside a database that contains pathnames. The command used for updating the database is called `updatedb`.

Once the database has been generated, you can use `locate` to find all matching file paths inside of the database. It does this almost instantly, making it a great choice to find files inside of unknown locations. All you need to do is run `locate pattern` to find matches. You can also make use of shell globbing and quoting characters to help narrow the results.

On Linux you should be all set, but if your on a Mac, please conceder installing `findutils`, via brew, instead of trying to use the default `locate` and `updatedb` commands. The brew version of these commands will be prefixed with a `g`, so you'll need to run `glocate` and `gupdatedb`.

## Using locate in combination with Emacs

Emacs already has a command named locate. When running this command you can pass it a string, and locate will then look through the database for all the matching paths, and lists all the results in an Emacs buffer. This buffer also features some additional functionality, but we won't be covering that today.

This can obviously save you time when your looking for a file, but can't remember where it's located. But for most of my personal use cases, I'm more interested in finding files recursively inside a specific project's scope, and that's what we'll be discussing next.

## Using locate for individual projects

There are many ways you can go about configuring locate in and outside of Emacs. The following is what I came up, but feel free to experiment and come up with better solutions.

First, we don't really want to generate a database for our entire file system, so we can configure locate to generate a database just for the folder containing our projects. We will write a Emacs lisp function that calls `updatedb` with two arguments, `localpaths` that specifies the folder that contains all our projects, and `output` that specifies the location of our database file. In addition, we also need to create an environment variable that specifies the same database path, named `LOCATE_PATH`, we can do this inside of our dot Emacs configuration file.

If your on Mac-OS, you'll also need to set two additional Emacs option variables, for `locate-command` and `locate-update-command` as we need to take into account the `g` prefix.

Next we will define two helper functions inside our dot Emacs configuration. The first function will help us update our locate database when needed. The second will help us automatically filter the results based on the projects root folder, this allows us to use locate for only project specific files.

```Lisp
;;;;;;;;;;;;;;;
;; Functions ;;
;;;;;;;;;;;;;;;

(defun vg-get-the-project-path()
  "Get a projects root directory if found.
Try to find the .git folder or a .dirlocals.el file and base the projects
root on that."
  (let ((dirlocals-file (locate-dominating-file default-directory ".dir-locals.el"))
        (git-folder (locate-dominating-file default-directory ".git")))
    ;; Return git folder if found.
    (when git-folder
      git-folder)
    ;; Return dirlocals path if found.
    (when dirlocals-file
      dirlocals-file)
    ;; Can't find root, just return the default directory.
    (expand-file-name default-directory)))

;;;;;;;;;;;;
;; Locate ;;
;;;;;;;;;;;;

;; We need to define this environment variable to specify the database to use.
(setenv "LOCATE_PATH" "/Users/vernon/locate-database")

;; The g-prefix is required for Mac, when installing findutils via brew.
(setq-default locate-command "glocate")
(setq-default locate-update-command "gupdatedb")

(defun vg-locate-in-project-scope()
  "Call locate with the current projects root path being the filter."
  (interactive)
  (let ((match (read-string "Locate: ")))
    (locate-with-filter match (vg-get-the-project-path))))

(defun vg-locate-update()
  "Update the locate database."
  (interactive)
  (let (
        ;; Define your projects folder path here.
        (projects-folder-path "/Users/vernon/Devenv")
        (locate-database-path (getenv "LOCATE_PATH")))
    (message "Updating locate database...")
    (shell-command     (mapconcat 'identity
                                  (list
                                   "gupdatedb"
                                   (concat "--localpaths=" projects-folder-path)
                                   (concat "--output=" locate-database-path))
                                  " "))
    (message "Database has been updated!")))

;; Setting our custom bindings.
(define-key global-map (kbd "C-c f") 'vg-locate-in-project-scope)
(define-key global-map (kbd "C-c F") 'vg-locate-update)
```

A good set of key bindings for these functions will be `C-c f`, to recursively find files inside the current project. And `C-c F` to update the locate database.

Please note, you can find the code examples in the podcast repository, linked inside the show notes of this episode.

## Conclusion

Although there are many great plugins that makes finding files recursively easy. Locate can be a valid solution for those who's main goal is to keep their Emacs configuration as minimal as possible.

Thanks for listing and stay tuned for the next episode of [Discovering Emacs](https://www.discovering-emacs.com).
