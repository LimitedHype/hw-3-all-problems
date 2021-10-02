
(require 2htdp/universe)
(require 2htdp/image)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Introduction

;; Spelling Bee is a vocabulary game hosted by the New York Times. The project
;; for this class is to build a program similar to Spelling Bee over the course
;; of several homework assignments. Before reading any further, you should play
;; the New York Times' Spelling Bee to understand the rules of the game:
;;
;; https://www.nytimes.com/puzzles/spelling-bee
;;
;; Your first version of Spelling Bee, which you will design for this
;; assignment, will make several simplifications:
;;
;; 1. You will construct words using five letters, and not seven,
;; 2. You will be able to enter nonsensical words,
;; 3. You will not be able to correct mistakes (i.e., backspace will not
;;      work),
;; 4. You will be able enter the same word several times, and
;; 5. You won't keep score.
;;
;; In later homework, you will remove these restrictions.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Step 1: Representing and Displaying Available Letters
;;

;; Design data called Letters that holds the five letters that are
;; available for your simplified Spelling Bee. Note that one of the letters is
;; distinguished as the required letter (i.e., the letter displayed at the
;; center).
;;
;; Tip: Use "1String" to refer to a one-character string in your data 
;; definition.

;; [TODO] Data design recipe

(define-struct Letters (letter1 letter2 letter3 letter4 req-letter))

;; a Letters is a (make-letters [1String 1String 1String 1String 1String])
;; INTERP: (make-letters [l1 l2 l3 l4 reql]) represents the possible characters
;; of the word to be spelled.
;; where l1 l2 l3 and l4 is a 1String representing such possible letters.
;; reql represents a 1String that is required in the word.


;; Template
;; letters-temp : Letters -> ?

(define (letters-temp ltr)
  (...
   (Letters-letter1 ltr) ...
   (Letters-letter2 ltr) ...
   (Letters-letter3 ltr) ...
   (Letters-letter4 ltr) ...
   (Letters-req-letter ltr) ...))


;; Design a function to display Letters as an Image. Feel free to layout the
;; letters in any way you like. However, the required letter must be
;; distinguished in some way (e.g., by position, color, font, etc).
;;
;; NOTE: You must not use substring in this function, or in any helper function
;; that it employs.

;; [TODO] Function design recipe

;; Examples
(define LTR1 (make-Letters "a" "e" "c" "d" "e"))
(define LTR2 (make-Letters "a" "d" "c" "d" "e"))
(define LTR3 (make-Letters "a" "h" "c" "d" "e"))
(define LTR4 (make-Letters "a" "p" "c" "d" "e"))
(define LTR5 (make-Letters "a" "A" "c" "d" "e")) 


;; TESTS
(check-expect (letter-to-img LTR1) (overlay (beside/align "baseline"
                                                          (text "a" 20 "black")
                                                          (text "e" 20 "black")
                                                          (text "e" 20 "yellow")
                                                          (text "c" 20 "black")
                                                          (text "d" 20 "black"))
                                            (rectangle 300 200 "solid" "blue")))

(check-expect (letter-to-img LTR5) (overlay (beside/align "baseline"
                                                          (text "a" 20 "black")
                                                          (text "A" 20 "black")
                                                          (text "e" 20 "yellow")
                                                          (text "c" 20 "black")
                                                          (text "d" 20 "black"))
                                            (rectangle 300 200 "solid" "blue")))


;; letter-to-img ; Letters -> Image
;; uses the characters in Letters to construct an image
(define (letter-to-img ltr)
  (overlay
   (beside/align "baseline"
                 (text (Letters-letter1 ltr) 20 "black")
                 (text (Letters-letter2 ltr) 20 "black")
                 (text (Letters-req-letter ltr) 20 "yellow")
                 (text (Letters-letter3 ltr) 20 "black")
                 (text (Letters-letter4 ltr) 20 "black"))
   (rectangle 300 200 "solid" "blue")))
  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Step 2: Representing the World

;; A game of Spelling Bee must track the available letters and the partial word
;; that the player has entered. Design data called World that holds
;; this data, and design a function called world->image that displays a World as
;; an image. You can produce any image that you like, but it should clearly show
;; both the available letters and the partial word.

;; Note: The final step of this homework has you revise the data definition for
;; World. We recommend completing this step before the revision. However, we
;; recommend you read the whole assignment first so that you can understand
;; the revision that you will have to do.

;; [TODO] Data design recipe

(define-struct World [letters partial-word previous-words])
;; A World is a make-world [Letters String String]
;; INTERP: a make-world [ltr ptwrd prewrd] is a state that contains
;;a defined set of Letters represented by ltr. 
;; As a player inputs addditional letters with a keypressed
;;event, ptwrd, a String, will update and track the partial word.
;; prewrd, represented as a String records the prior guessed words,
;;each word seperated by a "\n".



;; world-temp : Letters String String -> ? 
(define (world-temp ltr ptwrd prewrd)
  (...
   (World-letters (letters-temp ltr)) ...
   (World-partial-word ptwrd) ...
   (World-previous-words prewrd) ...))




;; [TODO] Function design recipe

;; Examples
(define WORLD-1 (make-World (make-Letters "a" "b" "c" "d" "e") "bed" "deca"))
(define WORLD-2 (make-World (make-Letters "!" "c" "a" "d" "4") "cad" "daaa\ndac"))
(define WORLD-3 (make-World (make-Letters "d" "e" "c" "n" "e") "need" "dece\ncen"))
(define WORLD-4 (make-World (make-Letters "a" "b" "L" "d" "e") "Led" "deLa\ned"))
(define WORLD-5 (make-World (make-Letters "a" "D" "c" "p" "e") "becDa" "Deca\nceD"))


;; TESTS

(check-expect (world->image WORLD-1) (beside
                                      (overlay
                                       (above
                                        (above
                                         (text "a" 20 "black")
                                         (beside/align "baseline"
                                                       (text "b" 20 "black")
                                                       (text " e " 20 "yellow")
                                                       (text "c" 20 "black")))
                                        (text "d" 20 "black"))
                                       (rectangle 150 200 "solid" "blue"))
                                      (overlay
                                       (above
                                        (text "bed"  20 "green")
                                        (text
                                         (string-append
                                          "Previous Words: \n" "deca")
                                         10 "orange"))
                                       (rectangle 150 200 "solid" "blue"))))


(check-expect (world->image WORLD-5) (beside
                                      (overlay
                                       (above
                                        (above
                                         (text "a" 20 "black")
                                         (beside/align "baseline"
                                                       (text "D" 20 "black")
                                                       (text " e " 20 "yellow")
                                                       (text "c" 20 "black")))
                                        (text "p" 20 "black"))
                                       (rectangle 150 200 "solid" "blue"))
                                      (overlay
                                       (above
                                        (text "becDa"  20 "green")
                                        (text
                                         (string-append
                                          "Previous Words: \n" "Deca\nceD")
                                         10 "orange"))
                                       (rectangle 150 200 "solid" "blue"))))



;; world->image : World -> Image
;; Takes the World state, and creates an image displaying such data.

(define (world->image wrld)
  (beside
   (overlay
    (above
     (above
      (text (Letters-letter1 (World-letters wrld)) 20 "black")
      (beside/align "baseline"
                    (text (Letters-letter2 (World-letters wrld)) 20 "black")
                    (text (string-append " " (Letters-req-letter
                                              (World-letters wrld)) " ") 20 "yellow")
                    (text (Letters-letter3 (World-letters wrld)) 20 "black")))
     (text (Letters-letter4 (World-letters wrld)) 20 "black"))
    (rectangle 150 200 "solid" "blue"))
   (overlay
    (above
     (text (World-partial-word wrld)  20 "green")
     (text (string-append "Previous Words: \n" (World-previous-words wrld)) 10 "orange"))
    (rectangle 150 200 "solid" "blue"))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Step 3:  Player Interactions

;; In a game of Spelling Bee, the player can either enter a letter to add to the
;; current word, or press the "Enter" key to complete the word. Design a
;; function with the following signature:




;; [TODO] Complete the function design recipe

;; TESTS

(check-expect (key-pressed WORLD-1 "e")
              (make-World (make-Letters "a" "b" "c" "d" "e") "bede" "deca"))
(check-expect (key-pressed WORLD-5 "\r")
              (make-World (make-Letters  "a" "D" "c" "p" "e") "" "Deca\nceD\nbecDa"))
(check-expect (key-pressed WORLD-4 "k")
              (make-World (make-Letters "a" "b" "L" "d" "e") "Led" "deLa\ned"))
(check-expect (key-pressed WORLD-3 "!")
              (make-World (make-Letters "d" "e" "c" "n" "e") "need" "dece\ncen"))
(check-expect (key-pressed WORLD-1 "a")
              (make-World (make-Letters "a" "b" "c" "d" "e") "beda" "deca"))
(check-expect (key-pressed WORLD-4 "d")
              (make-World (make-Letters "a" "b" "L" "d" "e") "Ledd" "deLa\ned"))
(check-expect (key-pressed WORLD-4 "b")
              (make-World (make-Letters "a" "b" "L" "d" "e") "Ledb" "deLa\ned"))
(check-expect (key-pressed WORLD-4 "L")
              (make-World (make-Letters "a" "b" "L" "d" "e") "LedL" "deLa\ned"))
(check-expect (key-pressed WORLD-2 "!")
              (make-World (make-Letters "!" "c" "a" "d" "4") "cad!" "daaa\ndac"))

;; key-pressed : World KeyEvent -> World
;; Listens / checks if the key pressed event character matches one of Letters.
;; If a return key is entered, and the World-partial-word contains the Letters-req-letter,
;;then it is added to the list of guessed words.

(define (key-pressed wrld evt)
  (cond
    [(and (key=? evt "\r") (string-contains? (Letters-req-letter
                                              (World-letters wrld)) (World-partial-word wrld)))
     (make-World (World-letters wrld) ""
                 (string-append
                  (World-previous-words wrld)
                  "\n" (World-partial-word wrld)))]
    [(key=? evt (Letters-letter1 (World-letters wrld)))
     (make-World (World-letters wrld)
                 (string-append
                  (World-partial-word wrld)
                  (Letters-letter1 (World-letters wrld))) (World-previous-words wrld))]
    [(key=? evt (Letters-letter2 (World-letters wrld)))
     (make-World (World-letters wrld)
                 (string-append
                  (World-partial-word wrld)
                  (Letters-letter2 (World-letters wrld))) (World-previous-words wrld))]
    [(key=? evt (Letters-letter3
                 (World-letters wrld)))
     (make-World (World-letters wrld)
                 (string-append
                  (World-partial-word wrld)
                  (Letters-letter3 (World-letters wrld))) (World-previous-words wrld))]
    [(key=? evt (Letters-letter4
                 (World-letters wrld)))
     (make-World (World-letters wrld)
                 (string-append
                  (World-partial-word wrld)
                  (Letters-letter4 (World-letters wrld))) (World-previous-words wrld))]
    [(key=? evt (Letters-req-letter (World-letters wrld)))
     (make-World (World-letters wrld)
                 (string-append
                  (World-partial-word wrld)
                  (Letters-req-letter (World-letters wrld))) (World-previous-words wrld))]
    [else (make-World (World-letters wrld)
                      (World-partial-word wrld) (World-previous-words wrld))]))




;; When the key is an an available letter, key-pressed should produce a new
;; world that adds that letter to the end of the current word. If the key is not
;; an available letter, it should produce the previous world. If the key is the
;; special string "\r" (which stands for the Enter key), it should produce a new
;; world with the empty string for the current word, as long as the current word
;; contains the center letter. If the player presses any other key, produce the
;; previous world unchanged. In other words, your program should not produce an
;; error if the player presses the "wrong" key.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Step 4: World Program

;; At this point, you have enough in place to play a basic game. Use the
;; following world program to play spelling bee.

;; play : World -> World
;;
;; Uses big-bang to play a game of Spelling Bee, given Letters.
(define (play w)
  (big-bang
      w
    (to-draw world->image)
    (on-key key-pressed)))

;; [TODO] Click Run. Then, in Interactions, use the function play on an 
;; example of Letters.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Step 5: Keeping Track of Words

;; make a third field in step 5 that keeps track of all letters 

;; The Spelling Bee program that you have so far doesn't even keep track of the
;; words you've entered! We really need the game to show the words that
;; you've already entered. For example, if you previously entered the words
;; "bell" and "well", and the available letters are "b", "o", "w", "e", and "l",
;; with "l" at the center, the program should really display something that
;; looks like this:
;;
;;   O     Words so far:
;; B L W   bell
;;   E     well
;;
;; Here is how you can display text on multiple lines. In a string, the special
;; character "\n" represents a new line. So, the string
;; "Words so far:\nbell\nwell" represents a string that appears on three lines.
;;
;; Modify the data World to include the words so far, represented
;; as a string. You will also have modify the functions you've written so far.
;; But, if you carefully followed the design recipe, the changes will be minor.
;;
;; NOTE: Your program will show the words entered so far, but it will not
;; check that the player does not enter a duplicate word. We will address that
;; problem later.

;; [TODO] Modifications

