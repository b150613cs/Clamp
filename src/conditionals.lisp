;;;; These are utilities for conditional branching.

(in-package :clamp)

(mac iflet (var expr &body branches)
  "Same as clamp:if but if a predicate is true, the value of predicate 
   is bound to VAR in the corresponding branch."
  (if branches
      (w/uniq gv
	`(let ,gv ,expr
	   (if ,gv
	       (let ,var ,gv
		 (declare (ignorable ,@(flat var)))
		 ,(car branches))
	       ,(if (cdr branches)
		    `(iflet ,var ,@(cdr branches))))))
      expr))

(mac whenlet (var expr &body body)
  "If EXPR returns non-nil, bind that value to VAR and execute body."
  `(iflet ,var ,expr (do ,@body)))

(mac aif (expr &body branches)
   "Equivalent to iflet but automatically binds EXPR to 'it'."
  `(iflet it ,expr ,@branches))

(mac awhen (expr &body body)
   "Equivalent to whenlet but automatically binds the value of EXPR
    to 'it'."
  `(whenlet it ,expr ,@body))

(mac aand (&rest args)
  "Equivalent to and, but binds the value of the previous expr to 
   'it'."
  (if (no args)
        t
      (no (cdr args))
        (car args)
      :else
        `(let it ,(car args)
	   (declare (ignorable it))
	   (and it (aand ,@(cdr args))))))

(mac iflet2 (var &rest clauses)
  "Equivalent to iflet, but will also execute the corresponding branch
   if the predicate has a second return value which is non-nil. This
   is useful for accessing hashtables."
  (w/uniq (val win)
    (if (null clauses)
          nil
	(single clauses)
          (car clauses)
	:else
          (let (t1 c1 . rest) clauses
            `(mvb (,val ,win) ,t1
               (if (or ,val ,win)
                   (let ,var ,val (declare (ignorable it)) ,c1)
                   (aif2 ,@rest)))))))

(mac aif2 (&rest clauses)
  "Equivalent to aif, but will also execute the corresponding branch
   if the predicate has a second return value which is non-nil. This
   is useful for accessing hashtables."
  `(iflet it ,@clauses))

(mac case (keyform &rest clauses)
  "Equivalent to cl:case except there are no parens around each 
   clause."
  `(cl:case ,keyform ,@(group clauses)))

(mac ccase (keyform &rest clauses)
  "Equivalent to cl:ccase except there are no parens around each
   clause."
  `(cl:ccase ,keyform ,@(group clauses)))

(mac ecase (keyform &rest clauses)
  "Equivalent to cl:ecase except there are no parens around each
   clause."
  `(cl:ecase ,keyform ,@(group clauses)))
