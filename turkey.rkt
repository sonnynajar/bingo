#lang racket

(require pict
         racket/draw)

(provide turkey)

(define eye
  (cc-superimpose
   (disk 20 #:color "white" #:border-color "black" #:border-width 3)
   (hc-append
    (blank 2)
    (disk 5 #:color "black" #:border-width 3))))

(define nose
  (dc (λ (dc dx dy)
        (define old-brush (send dc get-brush))
        (define old-pen (send dc get-pen))
        (send dc set-brush
              (new brush% [color "yellow"]))
        (send dc set-pen
              (new pen% [width 2] [color "orange"]))
        (define path (new dc-path%))
        (send path move-to 0 0)
        (send path line-to 15 0)
        (send path line-to 7.5 15)
        (send path close)
        (send dc draw-path path dx dy)
        (send dc set-brush old-brush)
        (send dc set-pen old-pen))
      15 15))

(define (feather color angle)
  (rotate (filled-ellipse 50 180 #:color color #:border-color "black" #:border-width 3) angle))

(define feathers
  (cc-superimpose
   (feather "orange" (/ pi 2))
   (feather "red" (/ pi 3))
   (feather "yellow" (/ pi 4))
   (feather "orange" (/ pi 6))
   (feather "red"    0)
   (feather "orange" (/ pi -6))
   (feather "yellow" (/ pi -4))
   (feather "red" (/ pi -3))
   ))

(define body
  (disk 120 #:color "brown" #:border-color "black" #:border-width 3))

(define head
  (disk 80 #:color "brown" #:border-color "black" #:border-width 3))

(define turkey
  (pin-over
   (pin-over
    (cc-superimpose
     (blank 180)
     feathers)
    0
    30
    (cc-superimpose
     (blank 180)
     body))
   50
   25
   (cc-superimpose
    head
    (vc-append
     (hc-append eye (blank 10) eye)
     (blank 5)
     (hc-append (blank 15) nose (blank 15))))))