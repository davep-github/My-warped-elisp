;;;
;;; Setup the Emacs Lisp PYthon development environment.
;;;

;; Ease of use for experimentation.  Eventually it will "wither away."
(setq dp-use-elpy-mode-p t)
(when (bound-and-true-p dp-use-elpy-mode-p)
  (elpy-enable)

  (defun dp-elpy-mode-hook ()
    (interactive)
    ;; I wanted to do this in the python-mode hook but I had to use
    ;; elpy-mode-map directly which I don't like.
    (define-key elpy-mode-map [(meta up)] 'dp-other-window-up)
    (define-key elpy-mode-map [(meta down)] 'other-window)
    (define-key elpy-mode-map [(control up)] 'dp-scroll-down)
    (define-key elpy-mode-map [(control down)] 'dp-scroll-up)
    (define-key elpy-mode-map [(meta ?.)] 'elpy-goto-definition)
    (define-key elpy-mode-map [(meta ?,)] 'pop-tag-mark)
    (define-key elpy-mode-map [(control return)] 'dp-open-above)
    ;; move from C-return
    (define-key elpy-mode-map [(meta control return)]
      'elpy-shell-send-statement-and-step)
    ;; See also <:elpy-python-bindings:> in `dp-python-mode-hook'
    ;; this works:
    (define-key elpy-mode-map [(control ?c) (control ?c)] 'dp-server-edit)
    (define-key elpy-mode-map [(control ?c) (control ?C)]
      'elpy-shell-send-region-or-buffer)
    ;;@todo XXX reconcile me and the bindings in dp-python-mode-map
    (dp-bump-key-binding [(control ?c) (control ?c)]
    			 'dp-server-edit
    			 [(control ?c) (control ?C)]
    			 elpy-mode-map))

  (add-hook 'elpy-mode-hook 'dp-elpy-mode-hook)

  ;; This needs must be done after flycheck loads?  The doc says set to nil
  ;; to prevent a timeout, but the custom code complains if it's not int or
  ;; float.  The code that looks at it definitely cares if it's nil rather
  ;; than zero.
  (setq flymake-no-changes-timeout nil)
  ;; I'd like to make this on a per-buffer basis.  Maybe.
  (make-variable-buffer-local 'flymake-no-changes-timeout)

  ;; Add some aliases for the nicely descriptive (but typing nightmares even
  ;; with completion.
  (dp-defaliases 'egd
		 'elpy-goto-definition)
  (dp-defaliases 'edgo 'edgow 'edg2
		 'elpy-goto-definition-other-window)
 
  (message "Completed dp-elpy.el setup.")
  )

(provide 'dp-elpy)


