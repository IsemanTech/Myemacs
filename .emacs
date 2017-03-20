(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(browse-url-browser-function (quote ignore))
 '(browse-url-generic-program "qupzilla")
 '(custom-enabled-themes (quote (isemanthaj1)))
 '(custom-safe-themes
   (quote
    ("9a0f67f8f7f64d511bb7ab5653f8818ee92ee8848be6cacaea3a2ab04fc05952" default)))
 '(ecb-options-version "2.40")
 '(package-selected-packages
   (quote
    (bongo w3 volume nyan-mode pdf-tools exwm-x cl-generic exwm scad-preview scad-mode yasnippet lua-mode helm ggtags color-theme auto-complete-c-headers))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-default-highlight-face ((t (:background "dodger blue"))))
 '(font-lock-comment-face ((t (:foreground "dark orange"))))
 '(font-lock-function-name-face ((t (:foreground "white"))))
 '(font-lock-string-face ((t (:foreground "lime green"))))
 '(font-lock-type-face ((t (:foreground "cornflower blue"))))
 '(font-lock-variable-name-face ((t (:foreground "white"))))
 '(region ((t (:background "#444444" :foreground "white smoke")))))

;;Open .h, .cpp or .c in C/C++ mode automatically by default.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(require 'cl)

(defun file-in-directory-list-p (file dirlist)
  "Returns true if the file specified is contained within one of
the directories in the list. The directories must also exist."
  (let ((dirs (mapcar 'expand-file-name dirlist))
        (filedir (expand-file-name (file-name-directory file))))
    (and
     (file-directory-p filedir)
     (member-if (lambda (x) ; Check directory prefix matches
                  (string-match (substring x 0 (min(length filedir) (length x))) filedir))
                dirs))))

(defun buffer-standard-include-p ()
  "Returns true if the current buffer is contained within one of
`the directories in the INCLUDE environment variable."
  (and (getenv "INCLUDE")
       (file-in-directory-list-p buffer-file-name (split-string (getenv "INCLUDE") path-separator))))

(add-to-list 'magic-fallback-mode-alist '(buffer-standard-include-p . c++-mode))

; start package.el with emacs
(require 'package)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
; initialize package.el
(package-initialize)


;;defining my own functions that starts auto-complete-cheaders and gets called for C/C++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
   (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-unknown-linux-gnu/5.2.0/../../../../include/c++/5.2.0")
  )
;; calling function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
 
;;Lets give color theme a try WOO!
(require 'color-theme)

;;k&r indenting
(setq c-default-style "k&r" c-basic-offset 4)

;;Get rid of the annoying make -k prompt when compiling
(setq compilation-read-command nil)
;;auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;;auto start smex for meta x
;;(require 'smex)
;;(smex-initialize)
;;(global-set-key(kbd "M-x") 'smex)

;;start helm
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

;;Emacs themes
(set-background-color "black")
(set-foreground-color "white")

;;Set default emacs font
(add-to-list 'default-frame-alist
	     '(font . "DejaVu Sans Mono-12"))
(set-frame-font "DejaVu Sans Mono-12" nil t)
;;Setup Slime
(load (expand-file-name "~/quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/bin/sbcl")
(slime-setup)

;;emacs window manager!
(require 'exwm)
(require 'exwm-config)
(exwm-config-default)
;;workspace number
(setq exwm-workspace-number 1)
;;auto start exwm
(exwm-enable)

;;display battery mode
(display-battery-mode 1)

;;display time
(display-time-mode 1)

;;nyan cat mode and start anim
(nyan-mode)
(nyan-start-animation)

;;bongo
(bongo)
(bongo-insert-directory "~/Music/Japanese")
(split-window-below)
(bongo-library)
