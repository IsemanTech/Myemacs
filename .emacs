(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes
   (quote
    ("9a0f67f8f7f64d511bb7ab5653f8818ee92ee8848be6cacaea3a2ab04fc05952" default)))
 '(ecb-options-version "2.40"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-default-highlight-face ((t (:background "dodger blue"))))
 '(font-lock-comment-face ((t (:foreground "dark orange"))))
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
the directories in the INCLUDE environment variable."
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

;;start ECB Code Browser with Emacs
(require 'ecb)
 
;;Lets give color theme a try WOO!
(require 'color-theme)

;;GNU indenting
(setq c-default-style "gnu" c-basic-offset 4)

;;Get rid of the annoying make -k prompt when compiling
(setq compilation-read-command nil)
;;auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;;auto start smex for meta x
(require 'smex)
(smex-initialize)
(global-set-key(kbd "M-x") 'smex)
