(prelude-require-packages '(dynamic-fonts
                            hackernews
                            persp-projectile
                            ))

;; Set transparency of emacs
(defun transparency (value)
  "Set the transparency VALUE(0=transparent/100=opaque) of the frame window."
  (interactive "nTransparency Value 0 - 100 opaque: ")
  (set-frame-parameter (selected-frame) 'alpha value))

(transparency 90)

(setq prelude-guru nil)
(setq dynamic-fonts-preferred-monospace-point-size 14)
(cua-mode 1)
(dynamic-fonts-setup)
(scroll-bar-mode -1)
(view-mode)
