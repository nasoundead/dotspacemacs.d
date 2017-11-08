
;; add something to exec-path
(defconst os:windowsp (eq system-type 'windows-nt)
  "if current operation system is windows system")
(defconst os:linuxp (eq system-type 'gnu/linux)
  "if current operation system is linux")
(defconst os:win32p (and os:windowsp
                         (not (getenv "PROGRAMW6432")))
  "if current operation system is windows 32bit version")
(defconst os:win64p (and os:windowsp
                         (getenv "PROGRAMW6432"))
  "if current operation system is windows 64bit verison.")

(defun prepend-to-exec-path (path)
  "prepend the path to the emacs intenral `exec-path' and \"PATH\" env variable.
Return the updated `exec-path'"
  (setenv "PATH" (concat (expand-file-name path)
                         path-separator
                         (getenv "PATH")))
  (setq exec-path
        (cons (expand-file-name path)
              exec-path)))

(when os:windowsp
  (mapc #'prepend-to-exec-path
        (reverse
         (list
          (if os:win64p
              "C:/Program Files (x86)/Git/bin"
            "C:/Program Files/Git/bin")
          "~/forwin/dll"
          "~/forwin/bin"
          ))))
