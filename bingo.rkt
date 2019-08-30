#lang racket

(require pict)

(define events-list
  (list
   #|01|#  "Sonny wears a light-colored shirt"
   #|02|#  "Phil says 'bastard'"
   #|03|#  "Judith mentions foster cats"
   #|04|#  "Lindsey wears not-boots"
   #|05|#  "Stephen wears a not-plain-colored shirt"
   #|06|#  "Awkward delivery person walks in"
   #|07|#  "Person selling/promoting something walks in"
   #|08|#  "Staff asks 'Is this coffee fresh?'"
   #|09|#  "Parent wants to move young advanced student to older class"
   #|10|#  "Judith mentions nose whistles"
   #|11|#  "Customer needs help in Spanish"
   #|12|#  "Customer calls to cancel LTM subscription"
   #|13|#  "Person comes in to replace AC filters"
   #|14|#  "Jason gets a haircut"
   #|15|#  "The AC is not working"
   #|16|#  "Dead bug in the stairwell"
   #|17|#  "The backend goes down"
   #|18|#  "Jordan lies about Lindsey's whereabouts on the phone"
   #|19|#  "Customer comes into our office"
   #|20|#  "Judith didn't have to find a sub all month"
   #|21|#  "Jordan wears a white shirt"
   #|22|#  "Sara has a different hair color"
   #|23|#  "Sonny doesn't know where something is"
   #|24|#  "Staff asks (email/out loud) 'Is X class going to run?'"
   #|25|#  "Judith bribes with dinner at her house to go to a Del Mar school"
   #|26|#  "People 'talk' in sign language"
   #|27|#  "Staff wears a hat to the office (not Sonny)"
   #|28|#  "Get an email about a car parked in 2 spots"
   #|29|#  "Lindsey didn't remind us about kitchen cleanliness all month"
   #|30|#  "Chromebook needs to be re-galliumed"
   #|31|#  "Two people 'book' the conference room at the same time"
   #|32|#  "Hillarious student allergies"
   #|33|#  "Elevator permit is renewed"
           ))

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

(define (make-square t)
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
     #:border-color "green")
    (vc-append (text "DATE:________________")
               (blank 10)))))

(define (arrow-pict)
  (vc-append
   (hc-append
    (rectangle 8 8)
    (rectangle 8 8)
    (filled-rectangle 8 8)
    (rectangle 8 8)
    (rectangle 8 8))
   (hc-append
    (rectangle 8 8)
    (rectangle 8 8)
    (rectangle 8 8)
    (filled-rectangle 8 8)
    (rectangle 8 8))
   (hc-append
    (filled-rectangle 8 8)
    (filled-rectangle 8 8)
    (filled-rectangle 8 8)
    (filled-rectangle 8 8)
    (filled-rectangle 8 8))
   (hc-append
    (rectangle 8 8)
    (rectangle 8 8)
    (rectangle 8 8)
    (filled-rectangle 8 8)
    (rectangle 8 8))
   (hc-append
    (rectangle 8 8)
    (rectangle 8 8)
    (filled-rectangle 8 8)
    (rectangle 8 8)
    (rectangle 8 8))))

(define (make-grid #:v [p "0"])
  (define l (shuffle events-list))

  (pict->bitmap
   (vc-append
    (scale (text "ThoughtSTEM Bingo") 4)
    (scale (text "Cross each square out when that 'action' happens.") 2)
    (text "Board is valid from 09/01/2019 to 9/30/2019")
    (blank 5)
    (hc-append 
     (vc-append
      (make-square (list-ref l 0))
      (make-square (list-ref l 1))
      (make-square (list-ref l 2))
      (make-square (list-ref l 3))
      (make-square (list-ref l 4)))
     (vc-append
      (make-square (list-ref l 5))
      (make-square (list-ref l 6))
      (make-square (list-ref l 7))
      (make-square (list-ref l 8))
      (make-square (list-ref l 9)))
     (vc-append
      (make-square (list-ref l 10))
      (make-square (list-ref l 11))
      (make-square "FREE")
      (make-square (list-ref l 12))
      (make-square (list-ref l 13)))
     (vc-append
      (make-square (list-ref l 14))
      (make-square (list-ref l 15))
      (make-square (list-ref l 16))
      (make-square (list-ref l 17))
      (make-square (list-ref l 18)))
     (vc-append
      (make-square (list-ref l 19))
      (make-square (list-ref l 20))
      (make-square (list-ref l 21))
      (make-square (list-ref l 22))
      (make-square (list-ref l 23)))
     )
    (vc-append
     (blank 5)
     (scale (text "RULES") 2)
     (scale (text "In order to cross something out you need to be present in the office when X happens.") 1.5)
     (text "To 'prevent' cheating write in the date of when X happens.")
     (scale (text "You're allowed to do X (to cross it out) if and only if someone else is present to SEE it happen.") 1.5)
     (blank 10)
     (text "Winning Pattern: Arrow pointing in any direction")
     (hc-append
      (arrow-pict)
      (blank 10)
      (rotate (arrow-pict) (/ pi 2))
      (blank 10)
      (rotate (arrow-pict) pi)
      (blank 10)
      (rotate (arrow-pict) (/ (* pi 3) 2)))
     (blank 10)
     (text (~a "Card #" p))))))

   
(make-grid #:v 1)
(make-grid #:v 2)
(make-grid #:v 3)
(make-grid #:v 4)
(make-grid #:v 5)
(make-grid #:v 6)
(make-grid #:v 7)
(make-grid #:v 8)
(make-grid #:v 9)
(make-grid #:v 10)
