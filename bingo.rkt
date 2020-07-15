#lang racket

(provide make-square)

(require pict
         ;"./turkey.rkt"
         ;"./snowflake.rkt"
         ;"./heart.rkt"
         "./clover.rkt"
         "./bingo-helpers.rkt")

(define events-list
  (list
   "Sonny wears a light-colored shirt"
   ;"Judith mentions cats/nose whistles/thrift store (out loud)"
   "Lindsey wears not-boots"
   "Stephen wears a not-plain-colored shirt"
   "Delivery person walks in"
   ;"Person selling/promoting something walks in"
   "At least 3 people in the office are drinking coffee"
   ;"Parent wants to move young advanced student to older class"
   ;"Customer needs help in Spanish"
   ;"Customer calls to cancel LTM subscription"
   ;"Person comes in to replace AC filters"
   ;"Jason gets a haircut"
   "The AC is not working properly"
   ;"Dead bug in the stairwell"
   "The backend (new or old) didn't work properly"
   ;"Jordan lies about Lindsey's whereabouts on the phone"
   ;"Customer comes into our office"
   ;"Judith didn't have to find a sub all month"
   "Jordan wears a white shirt"
   "Sara has a different hair color"
   ;"Sonny doesn't know where something is (can't 'hide' it, 2min to look)"
   "Staff asks (email/out loud) 'Is X class going to run?'"
   ;"Judith bribes with dinner at her house to go to a Del Mar school"
   "People 'talk' in sign language"
   "Staff wears a hat to the office (not Sonny)"
   "Get an email about a car parked in 2 spots"
   ;"Lindsey didn't remind us about kitchen cleanliness all month"
   ;"Chromebook needs to be re-galliumed"
   "Someone kicks someone else out from the meeting room"
   ;"Hillarious student allergies"
   ;"Elevator permit is renewed"
   "Core staff is out sick (can't be you)"
   ;"Sara talks about Lana"
   "You can hear someone else's music (coming from ear/headphones)"
   "You tried to get someone's attention, they're 'plugged-in', didn't hear you"
   ;"Judith's daughters call her 2 days in a row (same or mix)"
   ;"Discussion about how to get X thing to Y person using A person and B person"
   "Not Jordan answers the phone"
   "Someone calls asking for X core staff, X person accepts the call"
   "You bring food to share with office"
   "You're receiving a spam call, show someone else (make them believe you)"
   ;"Judith successfully onboards a new instructor"
   "We hire someone in San Diego"
   ;"Unknown Racket error -- must be something 2 other staff members have never seen before"
   ;"You ask if 'that a question for Jordan or Eunice?'"
   ;"You interact with Eunice via email/slack"
   ;"Judith tries to game the system"
   ;"You arrive to the office before Sonny OR you leave the office after Jason"
   "You found a typo/bug on the (live) metacoders.org page"
   "Eunice calls a parent from a class you're monitoring"
   "An instructor comes into the office when the entire staff is in a meeting"
   "We get a summer camp enrollment in another city"
   "We get a weekly class set up in another city"
   "We hire someone in another city"
   "We get a weekly class enrollment in another city"
   ;"Its raining and there are at least 7 people in the office"
   "Stephen has to give you EDIT access to some file/repo"
   ;"You heart a MetaCoders post on Instagram"
   "You share a MetaCoders post on FB"
   "Not-Lindsey wears boots"
   ))

(define (make-grid #:v [p "0"] #:color [c "black"])
  (define l (shuffle events-list))

  (pict->bitmap
   (vc-append
    (hc-append
     (scale clover .15)
     (blank 5)
     (scale (text "MetaCoders Bingo") 4)
     (blank 5)
     (scale clover .15))
    (scale (text "Cross each square out when that 'action' happens.") 2)
    (text "Board is valid from 03/04/2019 to 03/31/2019")
    (blank 5)
    (hc-append 
     (vc-append
      (make-square (list-ref l 0) c)
      (make-square (list-ref l 1) c)
      (make-square (list-ref l 2) c)
      (make-square (list-ref l 3) c)
      (make-square (list-ref l 4) c))
     (vc-append
      (make-square (list-ref l 5) c)
      (make-square (list-ref l 6) c)
      (make-square (list-ref l 7) c)
      (make-square (list-ref l 8) c)
      (make-square (list-ref l 9) c))
     (vc-append
      (make-square (list-ref l 10) c)
      (make-square (list-ref l 11) c)
      (make-square "FREE" c)
      (make-square (list-ref l 12) c)
      (make-square (list-ref l 13) c))
     (vc-append
      (make-square (list-ref l 14) c)
      (make-square (list-ref l 15) c)
      (make-square (list-ref l 16) c)
      (make-square (list-ref l 17) c)
      (make-square (list-ref l 18) c))
     (vc-append
      (make-square (list-ref l 19) c)
      (make-square (list-ref l 20)c )
      (make-square (list-ref l 21)c )
      (make-square (list-ref l 22)c )
      (make-square (list-ref l 23)c ))
     )
    (vc-append
     (blank 5)
     (scale (text "RULES") 2)
     (scale (text "In order to cross something out you need to be present in the office when X happens.") 1.5)
     (text "To 'prevent' cheating write in the date of when X happens.")
     (scale (text "You're allowed to do X (to cross it out) if and only if someone else is present to SEE it happen.") 1.5)
     (blank 10)
     (text "Winning Pattern: Big Letter M in any direction")
     (blank 5)
     (hc-append
      (letter-m)
      (text " or ")
      (rotate (letter-m) (/ pi 2))
      (text " or ")
      (rotate (letter-m) pi)
      (text " or ")
      (rotate (letter-m) (/ (* 3 pi ) 2)))
     (blank 10)
     (text (~a "Card #" p))))))

   
(make-grid #:v 1 #:color "green")
(make-grid #:v 2 #:color "green")
(make-grid #:v 3 #:color "green")
(make-grid #:v 4 #:color "green")
(make-grid #:v 5 #:color "green")
(make-grid #:v 6 #:color "green")
(make-grid #:v 7 #:color "green")

