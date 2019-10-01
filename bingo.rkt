#lang racket

(require pict)

(define events-list
  (list
   "Sonny wears a light-colored shirt"
   "Phil says 'bastard'"
   "Judith mentions cats/nose whistles/thrift store (out loud)"
   "Lindsey wears not-boots"
   "Stephen wears a not-plain-colored shirt"
   "Delivery person walks in"
   "Person selling/promoting something walks in"
   "Staff asks 'Is this coffee fresh?'"
   "Parent wants to move young advanced student to older class"
   ;"Judith mentions nose whistles"
   "Customer needs help in Spanish"
   "Customer calls to cancel LTM subscription"
   "Person comes in to replace AC filters"
   "Jason gets a haircut"
   "The AC is not working properly"
   "Dead bug in the stairwell"
   "The backend didn't work properly"
   "Jordan lies about Lindsey's whereabouts on the phone"
   "Customer comes into our office"
   "Judith didn't have to find a sub all month"
   "Jordan wears a white shirt"
   "Sara has a different hair color"
   "Sonny doesn't know where something is (can't 'hide' it, 2min to look)"
   "Staff asks (email/out loud) 'Is X class going to run?'"
   ;"Judith bribes with dinner at her house to go to a Del Mar school"
   "People 'talk' in sign language"
   "Staff wears a hat to the office (not Sonny)"
   "Get an email about a car parked in 2 spots"
   "Lindsey didn't remind us about kitchen cleanliness all month"
   ;"Chromebook needs to be re-galliumed"
   ;"Two people 'book' the conference room at the same time"
   ;"Hillarious student allergies"
   "Elevator permit is renewed"
   "Core staff is out sick (can't be you)"
   "Sara talks about Lana"
   "You can hear someone else's music (coming from ear/headphones)"
   "You tried to get someone's attention, they're 'plugged-in', didn't hear you"
   "Judith's daughters call her 2 days in a row (same or mix)"
   "Discussion about how to get X thing to Y person using A person and B person"
   "Not Jordan answers the phone"
   "Phil shows up to the office without a bike"
   "Someone calls asking for X core staff, X person accepts the call"
   "Not Lindsey brings food to share with office"
   "You're receiving a spam call, show someone else (make them believe you)"
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
     #:border-color "orange")
    (vc-append (text "DATE:________________")
               (blank 10)))))

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

(define (row num)
  (cond
   ((= num 1)  
    (vc-append
     (horizontal-filled) (horizontal-empty) (horizontal-empty) (horizontal-empty) (horizontal-empty)))
   ((= num 2)  
    (vc-append
     (horizontal-empty) (horizontal-filled) (horizontal-empty) (horizontal-empty) (horizontal-empty)))
   ((= num 3)  
    (vc-append
     (horizontal-empty) (horizontal-empty) (horizontal-filled) (horizontal-empty) (horizontal-empty)))
   ((= num 4)  
    (vc-append
     (horizontal-empty) (horizontal-empty) (horizontal-empty) (horizontal-filled) (horizontal-empty)))
   ((= num 5)  
    (vc-append
     (horizontal-empty) (horizontal-empty) (horizontal-empty) (horizontal-empty) (horizontal-filled)))))

(define (col num)
  (cond
   ((= num 1)  
    (hc-append
     (vertical-filled) (vertical-empty) (vertical-empty) (vertical-empty) (vertical-empty)))
   ((= num 2)  
    (hc-append
     (vertical-empty) (vertical-filled) (vertical-empty) (vertical-empty) (vertical-empty)))
   ((= num 3)  
    (hc-append
     (vertical-empty) (vertical-empty) (vertical-filled) (vertical-empty) (vertical-empty)))
   ((= num 4)  
    (hc-append
     (vertical-empty) (vertical-empty) (vertical-empty) (vertical-filled) (vertical-empty)))
   ((= num 5)  
    (hc-append
     (vertical-empty) (vertical-empty) (vertical-empty) (vertical-empty) (vertical-filled)))))
   

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
    (hc-append
     (jack-o-lantern 50)
     (blank 5)
     (scale (text "ThoughtSTEM Bingo") 4)
     (blank 5)
     (jack-o-lantern 50))
    (scale (text "Cross each square out when that 'action' happens.") 2)
    (text "Board is valid from 10/01/2019 to 10/31/2019")
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
     (text "Winning Pattern: Horizontal line + Vertical line")
     (hc-append
      (row 1) (text "or") (row 2) (text "or") (row 3) (text "or") (row 4) (text "or") (row 5)
      (text "AND")
      (col 1) (text "or") (col 2) (text "or") (col 3) (text "or") (col 4) (text "or") (col 5))
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

