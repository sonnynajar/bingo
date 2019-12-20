#lang racket

(require pict
         racket/draw
         (prefix-in h:
                    (only-in 2htdp/image
                             line
                             pen
                             flip-horizontal
                             flip-vertical
                             above
                             beside
                             rotate)))

(provide snowflake)

(define center
  (dc (λ (dc dx dy)
        (define old-brush (send dc get-brush))
        (define old-pen (send dc get-pen))
        (send dc set-brush
              (new brush% [color "cyan"]))
        (send dc set-pen
              (new pen% [width 5] [color "blue"]))
        (define path (new dc-path%))
        (send path move-to 0 20)
        (send path line-to 0 40)
        (send path line-to 25 58)
        (send path line-to 50 40)
        (send path line-to 50 20)
        (send path line-to 25 3)
        (send path close)
        (send dc draw-path path dx dy)
        (send dc set-brush old-brush)
        (send dc set-pen old-pen))
      50 58))

(define stick
  (h:beside
   (h:line 20  20 (h:pen "blue" 5 "solid" "round" "round"))
   (h:line  0  70 (h:pen "blue" 5 "solid" "round" "round"))
   (h:line 20 -20 (h:pen "blue" 5 "solid" "round" "round"))))

(define side-sticks
  (h:above
   ;(line 50  50 (pen "blue" 5 "solid" "round" "round"))
   (h:rotate 45  stick)
   (h:line 0 20 "white")
   (h:rotate 135 stick)))



(define snowflake
  (hc-append
  side-sticks
  (vc-append
   stick
   center
   (h:flip-vertical stick))
  (h:flip-horizontal side-sticks)))