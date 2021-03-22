breed [ squids squid]
breed [ octopi octopus]
breed [ dolphins dolphin]
breed [ sharks shark]

turtles-own [ near-shark near-squid near-dolphin ]

to setup
  clear-all

  ask patches [ set pcolor 87 ]

  ;;CREATING THE SQUID
  create-squids initial-number-squid
  [
    set shape "squid"
    set color pink
    set size 1.5
    setxy random-xcor random-ycor
  ]

  ;;CREATING THE OCTOPUS
  create-octopi initial-number-octopus
  [
    set shape "octopus"
    set color violet
    set size 1.5
    setxy random-xcor random-ycor
  ]

  ;;CREATING THE DOLPHIN
  create-dolphins initial-number-dolphin
  [
    set shape "dolphin"
    set color blue
    set size 1.5
    setxy random-xcor random-ycor
  ]

  ;;CREATING THE SHARK
  create-sharks initial-number-shark
  [
    set shape "shark"
    set color grey
    set size 1.5
    setxy random-xcor random-ycor
  ]

  reset-ticks
end

to go

  ask squids [
    move
    ink-shark
    run-away
    squids-get-eaten
  ]

  ask octopi [
    move
    camoflauge
    not-move
    octopi-get-eaten
  ]

  ask dolphins [
    move
    dolphin-pairs
    dolphin-get-eaten
  ]

  ask sharks [
    move
    run-away-from-ink
    run-away-from-dolphins
    chase
    look-away
  ]

 tick

end

to move
  rt random 100
  lt random 100
  fd 1
end

;; squid will ink if shark is in sight

to ink-shark
  if any? sharks in-radius 1 [ set color black ]
end

;; octopus will camoflauge itself if shark is in sight

to camoflauge
    if any? sharks in-radius 1 [ set color 87 ]
end

;; run away from shark

to run-away
  set near-shark min-one-of other sharks [distance myself]
  face near-shark
  rt 180
end

;; squid get eaten by shark

to squids-get-eaten
  ask sharks [ask squids-here [die]]
end

;; shark run away from ink

to run-away-from-ink
  face min-one-of squids with [color = black ] [ distance myself ]
  rt 180
end

;; octopus dont move once camoflauge to stay hidden

to not-move
  ask octopi with [color = grey] [fd 0]
end

;; octopus get eaten by shark

to octopi-get-eaten
  ask sharks [ask octopi-here [die]]
end

;; dolphins go near other turtles

to dolphin-pairs
  set near-dolphin min-one-of other dolphins [distance myself]
  face near-dolphin
end

;; dolphin attack shark if together

to run-away-from-dolphins
  if count dolphins > 1 [
    face min-one-of dolphins [ distance myself ]
    rt 90 ]
end

to chase
  face min-one-of squids with [ color = pink ] [ distance myself ]
  face min-one-of dolphins [ distance myself ]
  face min-one-of octopi with [ color = violet ]  [ distance myself ]
end

;; turn away from camo
to look-away
  face min-one-of octopi with [ color = 87 ] [ distance myself ]
  rt 180
end

;; dolphins die

to dolphin-get-eaten
    if count dolphins in-radius 2 = 1 [
    ask sharks [ask dolphins-here [die]] ]
end


