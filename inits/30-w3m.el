;; w3m
(ari:when-autoloads (w3m w3m-browse-url w3m-search) "w3m"
  (setq w3m-use-cookies t
        w3m-default-display-inline-images nil
        w3m-quick-start nil
        w3m-home-page "http://www.google.com/"))
(setq browse-url-browser-function 'w3m-browse-url)