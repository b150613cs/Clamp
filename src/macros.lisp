;;;; macros for writing macros

(defmacro mac (name args &body body)
  "The same as defmacro except allows auto-uniq ie any symbol that ends with
   '@' will be replaced by a uniq symbol"
  (let1 uniqs (table)
    `(defmacro ,name ,args
       ,@(alter #'auto
		[or (gethash _ uniqs) (setf (gethash _ uniqs) (uniq (symbol-name _)))]
		body))))

(defmacro w/uniq (names &body body)
  "Binds each element in names (or names if it is just a symbol), with
   a unique symbol"
  (lf (consp names)
      `(with ,(mappend (fn (n) `(,n (uniq (symbol-name ',n))))
		       names)
	 ,@body)
      `(let1 ,names (uniq (symbol-name ',names)) ,@body)))