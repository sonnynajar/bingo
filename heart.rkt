#lang racket

(require pict)

(provide heart)

(define r
  (filled-rectangle 20 20
                    #:color "red"
                    #:draw-border? #f))

(define b
  (filled-rectangle 20 20
                    #:color "black"
                    #:draw-border? #f))

(define w
  (filled-rectangle 20 20
                    #:color "white"
                    #:draw-border? #f))

(define row-1  (hc-append     b b b b w w w b b b b))
(define row-2  (hc-append   b r r r r b w b r r r r b))
(define row-3  (hc-append b r r w w r r b r r r r r r b))
(define row-4  (hc-append b r w w r r r r r r r r r r b))
(define row-5  (hc-append b r w r r r r r r r r r r r b))
(define row-6  (hc-append b r r r r r r r r r r r r r b))
(define row-7  (hc-append   b r r r r r r r r r r r b))
(define row-8  (hc-append     b r r r r r r r r r b))
(define row-9  (hc-append       b r r r r r r r b))
(define row-10 (hc-append         b r r r r r b))
(define row-11 (hc-append           b r r r b))
(define row-12 (hc-append             b r b))
(define row-13 (hc-append               b))

(define heart
  (vc-append
   row-1
   row-2
   row-3
   row-4  
   row-5  
   row-6 
   row-7 
   row-8  
   row-9  
   row-10 
   row-11 
   row-12
   row-13))