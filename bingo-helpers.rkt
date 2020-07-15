#lang racket

(provide horizontal-filled
         horizontal-empty
         vertical-filled
         vertical-empty
         make-square
         free-squares
         two-plus-signs-touching
         two-plus-signs-not-touching
         two-plus-signs-superimposed
         two-exes-touching-1
         two-exes-touching-2
         two-exes-touching-3
         two-exes-touching-4
         two-exes-sharing-1
         two-exes-sharing-2
         two-exes-superimposed
         letter-y
         letter-m)

(require pict)

(define (wrap-pict-text string width s)
  (define text-pict (scale (text string) s))
  (cond
    [(>= (pict-width text-pict) width)                   ;Check for pict width vs allowed
     (vl-append (scale (text (find-wrap-line string width 0 0 s)) s)   
                (wrap-pict-text (substring string
                                           (string-length (find-wrap-line string width 0 0 s))
                                           (string-length string))
                                width s))]
    [(equal? string "") (blank 1)]                       ;Remove any blank lines
    [else text-pict]                                     ;Return the current text-pict
    ))

(define (find-wrap-line string width pointer last s)
  (cond
    [(equal? (string-ref string 0) #\ )                        ;Get rid of leading spaces
     (string-append (find-wrap-line (substring string 1) width pointer last s) " ")]
    [(eqv? pointer (string-length string))                     ;Check for end of string
     (cond
       [(<= width (pict-width (scale (text string) s))) (substring string 0 last)]
       [else string]
       )]
    [(equal? (string-ref string pointer) #\ )                  ;Check for word
     (cond
       [(< (pict-width (scale (text (substring string 0 pointer)) s)) width);Check for pict < width
        (find-wrap-line string width (+ pointer 1) pointer s)]          ;increment pointer and save last know valid string
       [else (substring string 0 last)]               ;Check for pict >= width
       )]
    [else (find-wrap-line string width (+ pointer 1) last s)])   ;Else recurssion
  )

(define (make-square t c)
  (define s 1.5)
  (cc-superimpose
   (if (> (pict-width (scale (text t) s)) 200)
       (wrap-pict-text t 200 s)
       (scale (text t) s))
   (cbl-superimpose
    (rectangle
     200
     200
     #:border-width 2
     #:border-color c)
    (vc-append (text "DATE:________________")
               (blank 10))
    ;(vc-append (text "never expires")
    ;           (blank 10))
    )))

(define free-squares
  (pict->bitmap
   (hc-append 
    (vc-append
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black"))
    (vc-append
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black"))
    (vc-append
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black"))
    (vc-append
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black"))
    (vc-append
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black")
     (make-square "FREE" "black")))))

(define (horizontal-filled)
  (hc-append
   (filled-rectangle 8 8)
   (filled-rectangle 8 8)
   (filled-rectangle 8 8)
   (filled-rectangle 8 8)
   (filled-rectangle 8 8)))

(define (horizontal-empty)
  (hc-append
   (rectangle 8 8)
   (rectangle 8 8)
   (rectangle 8 8)
   (rectangle 8 8)
   (rectangle 8 8)))

(define (vertical-filled)
  (vc-append
   (filled-rectangle 8 8)
   (filled-rectangle 8 8)
   (filled-rectangle 8 8)
   (filled-rectangle 8 8)
   (filled-rectangle 8 8)))

(define (vertical-empty)
  (vc-append
   (rectangle 8 8)
   (rectangle 8 8)
   (rectangle 8 8)
   (rectangle 8 8)
   (rectangle 8 8)))

(define (arrow-pict)
  (vc-append
   (row-fill-pattern 0 0 1 0 0)
   (row-fill-pattern 0 0 0 1 0)
   (row-fill-pattern 1 1 1 1 1)
   (row-fill-pattern 0 0 0 1 0)
   (row-fill-pattern 0 0 1 0 0)))

(define (row-fill-pattern a b c d e)
  (hc-append
   (if (= a 1)
       (filled-rectangle 8 8)
       (rectangle 8 8))
   (if (= b 1)
       (filled-rectangle 8 8)
       (rectangle 8 8))
   (if (= c 1)
       (filled-rectangle 8 8)
       (rectangle 8 8))
   (if (= d 1)
       (filled-rectangle 8 8)
       (rectangle 8 8))
   (if (= e 1)
       (filled-rectangle 8 8)
       (rectangle 8 8))))

(define (plus-sign)
  (vc-append
   (row-fill-pattern 0 1 0 0 0)
   (row-fill-pattern 1 1 1 0 0)
   (row-fill-pattern 0 1 0 0 0)
   (row-fill-pattern 0 0 0 0 0)
   (row-fill-pattern 0 0 0 0 0)))

(define (two-plus-signs-touching)
  (vc-append
   (row-fill-pattern 0 1 0 0 0)
   (row-fill-pattern 1 1 1 0 0)
   (row-fill-pattern 0 1 1 0 0)
   (row-fill-pattern 0 1 1 1 0)
   (row-fill-pattern 0 0 1 0 0)))

(define (two-plus-signs-not-touching)
  (vc-append
   (row-fill-pattern 0 1 0 0 0)
   (row-fill-pattern 1 1 1 0 0)
   (row-fill-pattern 0 1 0 1 0)
   (row-fill-pattern 0 0 1 1 1)
   (row-fill-pattern 0 0 0 1 0)))

(define (two-plus-signs-superimposed)
  (vc-append
   (row-fill-pattern 0 0 0 1 0)
   (row-fill-pattern 0 0 1 1 1)
   (row-fill-pattern 0 0 0 1 0)
   (row-fill-pattern 0 0 1 1 1)
   (row-fill-pattern 0 0 0 1 0)))

(define (two-exes-touching-1)
  (vc-append
   (row-fill-pattern 1 0 1 0 0)
   (row-fill-pattern 0 1 1 0 1)
   (row-fill-pattern 1 0 1 1 0)
   (row-fill-pattern 0 0 1 0 1)
   (row-fill-pattern 0 0 0 0 0)))

(define (two-exes-touching-2)
  (vc-append
   (row-fill-pattern 0 0 0 0 0)
   (row-fill-pattern 1 0 1 0 0)
   (row-fill-pattern 0 1 1 0 1)
   (row-fill-pattern 1 0 1 1 0)
   (row-fill-pattern 0 0 1 0 1)))

(define (two-exes-touching-3)
  (vc-append
   (row-fill-pattern 0 0 1 0 1)
   (row-fill-pattern 1 0 1 1 0)
   (row-fill-pattern 0 1 1 0 1)
   (row-fill-pattern 1 0 1 0 0)
   (row-fill-pattern 0 0 0 0 0)))

(define (two-exes-touching-4)
  (vc-append
   (row-fill-pattern 0 0 0 0 0)
   (row-fill-pattern 0 0 1 0 1)
   (row-fill-pattern 1 0 1 1 0)
   (row-fill-pattern 0 1 1 0 1)
   (row-fill-pattern 1 0 1 0 0)))

(define (two-exes-sharing-1)
  (vc-append
   (row-fill-pattern 0 0 1 0 1)
   (row-fill-pattern 0 0 0 1 0)
   (row-fill-pattern 1 0 1 0 1)
   (row-fill-pattern 0 1 0 0 0)
   (row-fill-pattern 1 0 1 0 0)))

(define (two-exes-sharing-2)
  (vc-append
   (row-fill-pattern 1 0 1 0 0)
   (row-fill-pattern 0 1 0 0 0)
   (row-fill-pattern 1 0 1 0 1)
   (row-fill-pattern 0 0 0 1 0)
   (row-fill-pattern 0 0 1 0 1)))

(define (two-exes-superimposed)
  (vc-append
   (row-fill-pattern 1 0 1 0 0)
   (row-fill-pattern 0 1 0 1 0)
   (row-fill-pattern 1 0 1 0 0)
   (row-fill-pattern 0 1 0 1 0)
   (row-fill-pattern 0 0 0 0 0)))

(define (letter-y)
  (vc-append
   (row-fill-pattern 1 0 0 0 1)
   (row-fill-pattern 0 1 0 1 0)
   (row-fill-pattern 0 0 1 0 0)
   (row-fill-pattern 0 0 1 0 0)
   (row-fill-pattern 0 0 1 0 0)))

(define (letter-m)
  (vc-append
   (row-fill-pattern 1 0 0 0 1)
   (row-fill-pattern 1 1 0 1 1)
   (row-fill-pattern 1 0 1 0 1)
   (row-fill-pattern 1 0 0 0 1)
   (row-fill-pattern 1 0 0 0 1)))