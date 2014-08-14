;;;; these are several cl operations which are aliased for clamp

(in-package :clamp)

;;; special forms
(defalias do  progn)
(defalias after unwind-protect)

;;; macros
(defalias def defun)
(defalias mac defmacro)
(defalias ++ incf)
(defalias -- decf)
(defalias mvb multiple-value-bind)
(defalias mvl multiple-value-list)
(defalias do1 prog1)
(defalias do2 prog2)
(defalias = setf)
(defalias errsafe ignore-errors)
(defalias w/file with-open-file)

;;; functions
(defalias is eql)
(defalias iso equalp)
(defalias no not)
(defalias len length)
(defalias map mapcar)
(defalias isa typep)
(defalias uniq gensym)
(defalias even evenp)
(defalias odd oddp)
(defalias redup remove-duplicates)
(defalias dedup delete-duplicates)
(defalias table make-hash-table)
(defalias rand random)
(defalias trunc truncate)
(defalias join append)
(defalias cut subseq)
(defalias rev reverse)
(defalias nrev nreverse)
(defalias const constantly)
(defalias idfn identity)
(defalias outstring make-string-output-stream)
(defalias inside get-output-stream-string)
(defalias instring make-string-input-stream)
(defalias swap rotatef)
;; (defalias rotate rotatef) is there any reason to have rotate and swap?
(defalias writec write-char)
