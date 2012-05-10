(global-set-key "\C-x\C-x" 'smart-compile)
(ari:when-autoloads (smart-compile) "smart-compile+"
  (ari-seq:append-to-list 'smart-compile-alist
                          `(("\\.cl$" . "sbcl --noinform %f")
                            ("\\.scm$" . "gosh %f")
                            ("\\.clj$" . "clj %f")
                            ("\\.pir$" . "parrot %f")
                            ("\\.\(pl\|pm\)$" . "perl %f")
                            ;("app\\.js$" . ,(expand-file-name "~/Library/Application\\ Support/Titanium/mobilesdk/osx/1.8.0.1/iphone/builder.py run %F"))
                            ("\\.js$" . ,(expand-file-name "~/Library/Application\\ Support/Titanium/mobilesdk/osx/1.8.0.1/iphone/builder.py run %F"))
                            ;("\\.js$" . "gjslint --strict %f")
                            )))