#lang racket

(require pict)

(provide clover)

(define g
  (filled-rectangle 20 20
                    #:color "darkgreen"
                    #:draw-border? #f))

(define l
  (filled-rectangle 20 20
                    #:color "green"
                    #:draw-border? #f))

(define w
  (filled-rectangle 20 20
                    #:color "white"
                    #:draw-border? #f))

(define row-1  (hc-append               g g w g g                ))
(define row-2  (hc-append             g l l g l l g              ))
(define row-3  (hc-append           g l l l l l l l g            ))
(define row-4  (hc-append           g l l l l l l l g            ))
(define row-5  (hc-append           g l l l l l l l g            ))
(define row-6  (hc-append     g g g w g l l l l l g w g g g      ))
(define row-7  (hc-append   g l l l g w g l l l g w g l l l g    ))
(define row-8  (hc-append g l l l l l l w g l g w g l l l l l g  ))
(define row-9  (hc-append g l l l l l l g g l g g l l l l l l g  ))
(define row-10 (hc-append   g l l l l l l l l l l l l l l l g    ))
(define row-11 (hc-append g l l l l l l g g l g g l l l l l l g  ))
(define row-12 (hc-append g l l l l l l w g l g g g l l l l l g  ))
(define row-13 (hc-append   g l l l g w g l l l g g g l l l g    ))
(define row-14 (hc-append     g g g w g l l l l l g g g g g      ))
(define row-15 (hc-append         w g l l l l l l l g g          ))
(define row-16 (hc-append       w w g l l l l l l l g g g        ))
(define row-17 (hc-append     w w w g l l l l l l l g w g g      ))
(define row-18 (hc-append   w w w w w g l l g l l g w w w g g    ))
(define row-19 (hc-append   w w w w w w g g w g g w w w w w g    ))
(define row-20 (hc-append w w w w w w w w w w w w w w w w w g g  ))
(define row-21 (hc-append w w w w w w w w w w w w w w w w w w g g))
(define row-22 (hc-append w w w w w w w w w w w w w w w w w w w g))

(define clover
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
   row-13
   row-14
   row-15
   row-16
   row-17
   row-18
   row-19
   row-20
   row-21
   row-22))