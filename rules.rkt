#lang bingo

(define (rules)
  (println "Read all the rules out loud")
  (list "Give each player 1 bingo card (now), if someone is absent leave it
            on their desk"
        "You must be present in the office in order to cross out a square
            (not because you heard it happened)"
        "Each time you cross out a square also write in the date"
        "You cannot cross out squares if you come in on Saturday or Sunday"
        "If X is about you, you're allowed to do X (on purpose) if and only
            if someone else is also in the office"
        "If X is not about you but you see X happens, you can cross it out"
        "When X is about something that did not happen in a month,
            you're allowed to ask if it has happened (to be in the loop)"
        "When you complete the pattern you must wait until there is at least
            a total of three people in the office and shout 'BINGO!'"
        "Once you say 'BINGO' two people must check your pattern and
            determine if it is a winner or not"
        (if (wining-pattern? bingo-card)
            "Announce the winner on #office-news channel"
            "Pin bingo card to the BINGO board and player is out")
        (if (and (last-weekday-of-the-month-at-2pm) (no-winner-yet))
            (if (one-person-with-max-score)
                "Person with most filled in squares wins"
                (rock-paper-scissors-tie-breaker))
            "Continue playing")        
        "The next round starts next month"))

  