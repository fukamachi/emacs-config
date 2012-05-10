(defvar *network-interface-names* '("en1" "wlan0")
  "Candidates for the network devices.")

(defun officep ()
  "Am I in the office? If I am in the office, my IP address must start with '10.0.100.'."
  (aif (some #'ari-net:machine-ip-address *network-interface-names*)
    (eq 0 (string-match "^10\\.0\\.100\\." it))))