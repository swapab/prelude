;;; mu4e-config.el --- bla bla bla
;;; -*- coding: utf-8 -*-

;; Copyright 2011-2016 François-Xavier Bois

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")

(require 'mu4e)
(require 'mu4e-contrib)

;; default
(setq mu4e-maildir (expand-file-name "~/Maildir"))

(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/[Gmail].Trash")

;; don't save message to Sent Messages, GMail/IMAP will take care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
(setq mu4e-maildir-shortcuts
      '(("/INBOX"             . ?i)
        ("/[Gmail].Sent Mail" . ?s)
        ("/[Gmail].Trash"     . ?t)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
;; I don't use a signature...
(setq
 user-mail-address "sabnave@redhat.com"
 user-full-name  "Swapnil Abnave"
 ;; message-signature
 ;;  (concat
 ;;    "Swapnil Abnave\n"
 ;;    "IRC: swapab\n")
)

;; start : https://medium.com/@kirang89/emacs-as-email-client-with-offlineimap-and-mu4e-on-os-x-3ba55adc78b6 ----

;; show images
(setq mu4e-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; convert html emails properly
;; Possible options:
;;   - html2text -utf8 -width 72
;;   - textutil -stdin -format html -convert txt -stdout
;;   - html2markdown | grep -v '&nbsp_place_holder;' (Requires html2text pypi)
;;   - w3m -dump -cols 80 -T text/html
;;   - view in browser (provided below)
(setq mu4e-html2text-command "textutil -stdin -format html -convert txt -stdout")

;; spell check
(add-hook 'mu4e-compose-mode-hook
          (defun my-do-compose-stuff ()
            "My settings for message composition."
            (set-fill-column 72)
            (flyspell-mode)))

;; add option to view html message in a browser
;; `aV` in view to activate
(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; fetch mail every 5 mins
(setq mu4e-update-interval 300)

;; ------- end : https://medium.com/@kirang89/emacs-as-email-client-with-offlineimap-and-mu4e-on-os-x-3ba55adc78b6 ----

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu, 'gnutls' in Archlinux.

;; start  http://cachestocaches.com/2017/3/complete-guide-email-emacs-using-mu-and-/

(use-package mu4e-alert
  :ensure t
  :after mu4e
  :init
  (setq mu4e-alert-interesting-mail-query
        (concat
         "flag:unread maildir:/Exchange/INBOX "
         "OR "
         "flag:unread maildir:/Gmail/INBOX"
         ))
  (mu4e-alert-enable-mode-line-display)
  (defun gjstein-refresh-mu4e-alert-mode-line ()
    (interactive)
    (mu4e~proc-kill)
    (mu4e-alert-enable-mode-line-display)
    )
  (run-with-timer 0 60 'gjstein-refresh-mu4e-alert-mode-line)
  )

;; end http://cachestocaches.com/2017/3/complete-guide-email-emacs-using-mu-and-/

(require 'smtpmail)

(setq message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials
      '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials
      (expand-file-name "~/.authinfo.gpg")
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-debug-info t)

(provide 'mu4e-config)
;;; mu4e-config.el ends here
