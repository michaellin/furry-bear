;;; Test Cases for the Scheme Project 

;; To run all tests:
;;     python3 scheme_test.py tests.scm
;;

;; In the following sections, you should provide test cases, so that by 
;; running 
;;     python3 scheme_test.py tests.scm
;; you can test the portions of the project you've completed.  In fact, 
;; you might consider writing these tests BEFORE tackling the associated
;; problem!


;; -- BEGIN TEST -- ;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The following should work for the initial files. ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

3
; expect 3

-123
; expect -123

1.25
; expect 1.25

#t
; expect #t

#f
; expect #f

)
; expect Error


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 1  (the reader) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;   Initially, the project skeleton simply reads and prints the expressions
;   entered.  Later on, it starts evaluating them.  You may therefore need
;   to modify the tests you initially provide for this section when you get
;   to later sections.  For example, initially, entering the symbol x will
;   simply cause the evaluator to print "x" rather than attempting to evaluate
;   it (and getting an error).  Therefore, you may later have to modify
;   x to (e.g.) 'x

(car '(3 4))
; expect 3

(cdr '(3 4))
; expect (4)

(car (car '((3 . 4) (5 . 6))))
; expect 3

(car (car (cdr '((3 . 4) (5 . 6)))))
; expect 5

'(3 4 . 5)
; expect (3 4 . 5)

'(3 . 4 5)
; expect Error

'()
; expect ()

'(.)
; expect Error

;; Must match weird STk output
'( . 4)
; expect 4

'(#t . #f)
; expect (#t . #f)

'(#t #f #t #f)
; expect (#t #f #t #f)

'a
; expect a

'#t
; expect #t

;; STk returns ((quote b) 3 2 (quote c) (quote a)) just like our program
;; '('b 3 2 'c 'a)
;;; expect ('b 3 2 'c 'a)

(3 2)
; expect Error


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem A2 and B2 (symbol evaluation and simple defines) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define a 2)
a
; expect 2

(define b a)
b
; expect 2

a
; expect 2

'a
; expect a

'b
; expect b

(define $ 3)
$
; expect 3

(define $ a b)
; expect Error

(define $ a)
$
; expect 2

(define %*%@ 42)
%*%@
; expect 42


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem 3 (primitive function calls) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(+ (* 2 2) (/ 2 1))
; expect 6

;; Custom zero-division error
(/ 1 0)
; expect Error

(/ 5 10 3)
; expect Error

(cdr '(3 4 5))
; expect (4 5)

(car '())
; expect Error

(quotient 2)
; expect Error

(quotient 2 0)
; expect Error

(quotient 2 3)
; expect 0

(+ 3.2 4.1 2.8 0.8)
; expect 10.9

(not 3)
; expect #f

(list? '(3 4 2))
; expect #t

(symbol? 'a)
; expect #t


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem A4, B4, A5, B5, and 6 (calls on user-defined functions) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ----- A4 ----- ;;
;; -------------- ;;

(lambda (x) (set! y x) (+ x y))
; expect <(lambda (x) (begin (set! y x) (+ x y))), <Global frame at 0x848444c>>

(lambda (x y) (/ x y))
; expect <(lambda (x y)  (/ x y)), <Global frame at 0x848444c>>

(lambda (x))
; Error

(lambda (x) ())
; expect <(lambda (x)  ()), <Global frame at 0x848444c>>

(lambda (x x) (+ x x))
; expect <(lambda (x x)  (+ x x)), <Global frame at 0x848444c>>

(lambda (0) (1))
; expect <(lambda (0)  (1)), <Global frame at 0x848444c>>

(lambda (anything) (something))
; expect <(lambda (anything)  (something)), <Global frame at 0x848444c>>

(lambda (x) (lambda (y) (+ y x)) x)
; expect <(lambda (x)  (begin((lambda (y) (+ y x)) x))), <Global frame at 0x848444c>>

(lambda (+ x 1))
; expect Error

;; ----- B4 ----- ;;
;; -------------- ;;

(define function a (+ a 1))
; expect Error

;; ----- A5/B5/6 ----- ;;
;; ------------------- ;;

(define (test2)
  (define (helper x)
    (+ x (* x x) (- 10 x)))
  helper)
((test2) 100)
; expect 10010

(test2 100)
; expect Error

(define (have_money? x)
  (define (helper x n)
    (cond ((= x 100) #t)
	  ((= x 0) #f)
	  (else (+ x n))))
  (helper x 99))
(have_money? 100)
; expect #t

(have_money? 1)
; expect 100

(have_money?)
; expect Error

(define (test1 x)
  (define y x)
  (+ x y))
(test1 3)
; expect 6

(define func (lambda (x) (* x x)))
(func 10)
; expect 100

((lambda (x) 1) 2)
; expect 1

(define func1 (lambda x (+ x 1)))
(func1 2)
; expect Error

(define (add_one x) (+ x 1))
(add_one 10)
; expect 11

(define (add_squares a b) (+ (* a a) (* b b)))
(add_squares 6 8)
; expect 100

(add_squares 5)
; expect Error

(define (func (x y) z) (+ x 1))
(func (1 2) 3)
; expect Error

(func 2 5)
; expect 6

(define (id x) x)
(id 'samething)
; expect samething

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;
;; Problem 7 (set!) ;;
;;;;;;;;;;;;;;;;;;;;;;

(define x 4)
(set! x 5)
; expect 5

(define (test7 n) (set! x n))
(test7 10)
; expect 10


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem A8 (if, and) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(if #t 3 4)
; expect 3

(if #f 4 5)
; expect 5

(if (> 3 5) 10 100)
; expect 100

(if #f 0)
; expect

(if #t (+ 10 5))
; expect 15

(if #f (+ 12 10) (/ 3 0))
; expect Error

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Problem B8 (cond, or) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

; YOUR TEST CASES HERE


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;
;; Problem 9 (let) ;;
;;;;;;;;;;;;;;;;;;;;;

; YOUR TEST CASES HERE


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Extra Credit 1 (let*) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

; YOUR TEST CASES HERE


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Extra Credit 2 (case) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

; YOUR TEST CASES HERE


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;
;; Problem A10 ;;
;;;;;;;;;;;;;;;;;

;; The subsequence of list S for which F outputs a true value (i.e., one
;; other than #f), computed destructively
(define (filter! f s)
   ; *** YOUR CODE HERE ***
)

(define (big x) (> x 5))

(define ints (list 1 10 3 8 4 7))
(define ints1 (cdr ints))

(define filtered_ints (filter! big ints))
filtered_ints
; expect (10 8 7)
(eq? filtered_ints ints1)
; expect #t


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;
;; Problem A11 ;;
;;;;;;;;;;;;;;;;;

;; The number of ways to change TOTAL with DENOMS
;; At most MAX-COINS total coins can be used.
(define (count_change total denoms max-coins)
  ; *** YOUR CODE HERE ***
)

(define us_coins '(50 25 10 5 1))
(count_change 20 us_coins 18)
; expect 8


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;
;; Problem B10 ;;
;;;;;;;;;;;;;;;;;

;; Reverse list L destructively, creating no new pairs.  May modify the 
;; cdrs of the items in list L.
(define (reverse! L)
   ; *** YOUR CODE HERE ***
)

(define L (list 1 2 3 4))
(define LR (reverse! L))
LR
; expect (4 3 2 1)

(eq? L (list-tail LR 3))
; expect #t


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;
;; Problem B11 ;;
;;;;;;;;;;;;;;;;;

;; The number of ways to partition TOTAL, where 
;; each partition must be at most MAX_VALUE
(define (count-partitions total max-value)
  ; *** YOUR CODE HERE ***
)

(count-partitions 5 3)
; expect 5
; Note: The 5 partitions are [[3 2] [3 1 1] [2 2 1] [2 1 1 1] [1 1 1 1 1]]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;
;; Problem 12 ;;
;;;;;;;;;;;;;;;;

;; A list of all ways to partition TOTAL, where  each partition must 
;; be at most MAX_VALUE and there are at most MAX_PIECES partitions.
(define (list-partitions total max-pieces max-value)
  ; *** YOUR CODE HERE ***
)

(list-partitions 5 2 4)
; expect ((4 1) (3 2))
(list-partitions 7 3 5)
; expect ((5 2) (5 1 1) (4 3) (4 2 1) (3 3 1) (3 2 2))



;; -- END TEST -- ;;
