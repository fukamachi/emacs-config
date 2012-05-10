(defvar growl-program "/usr/local/bin/growlnotify")

(defun growl (title message &optional id stickyp)
  (apply #'start-process
         (ari-seq:flatten
          (nconc
           `("growl" "*growl*" ,growl-program ,title "-w")
           (ari:cond-cons
            ((null id) `("-d" ,id))
            ((null stickyp) "-s")))))
  (process-send-string "*growl*" (concat message "\n"))
  (process-send-eof "*growl*"))