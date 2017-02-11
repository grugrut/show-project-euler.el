;;; show-project-euler.el --- Show the problem with given number in Project Euler.
;; Author: grugrut <grugruglut+github@gmail.com>
;; URL: https://github.com/grugrut/show-project-euler.el
;; Version: 1.00

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(defun show-project-euler-problem (num)
  "Rerieve Problem NUM from Project Euler."
  (interactive "nProblem Number:")
  (let ((url-request-method "GET"))
    (switch-to-buffer (url-retrieve-synchronously
                       (format "https://projecteuler.net/problem=%d" num)))
    (goto-char (point-min))
    (search-forward "<div class=\"problem_content\"")
    (forward-line)
    (setq from (point))
    (search-forward "</div>")
    (forward-line -1)
    (end-of-line)
    (setq to (point))
    (setq response-string
	  (replace-regexp-in-string "</?p>" ""
				    (buffer-substring-no-properties
				     from to)))
    (kill-buffer (current-buffer))
    (let ((buffer (generate-new-buffer (format "*Problem %d*" num))))
      (set-buffer buffer)
      (insert response-string)
      (toggle-read-only buffer)
      (display-buffer buffer))))

(provide 'show-project-euler)

;;; show-project-euler.el ends here
