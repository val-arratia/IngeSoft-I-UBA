!classDefinition: #MarsRoverLogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 11:02:52'!
test01EmptyLogWhenNothingHasBeenProcessed
	| marsRover positionLog |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLog := MarsRoverPositionLog subscribingTo: marsRover .
	self assert: positionLog log isEmpty.! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 11:18:45'!
test02LogFowardCommand
	| marsRover expectedLog positionLog |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLog := MarsRoverPositionLog subscribingTo: marsRover .
	marsRover process: 'f'.
	
	expectedLog:= OrderedCollection with: 1@2.
	self assert: positionLog log equals: expectedLog .! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 11:23:51'!
test03LogManyCommands
	| marsRover expectedLog positionLog |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLog := MarsRoverPositionLog subscribingTo: marsRover .
	marsRover process: 'ffrfbl'.
	expectedLog:= OrderedCollection with: 1@2 with: 1@3 with: 2@3 with:1@3.
	self assert: positionLog log equals: expectedLog .! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 11:43:00'!
test04HeadingLogAddsOneCommandRight
	| marsRover headingLog |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingLog := MarsRoverHeadingLog subscribingTo: marsRover .
	marsRover process: 'r' .
	
	self assert: headingLog log equals: (OrderedCollection with: 'East' ).! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 12:44:10'!
test05HeadingLogAddsManyCommands
	| marsRover headingLog |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingLog := MarsRoverHeadingLog subscribingTo: marsRover .
	marsRover process: 'rlrrr' .
	
	self assert: headingLog log equals: (OrderedCollection with: 'East' with:'North' with:'East' with:'South' with:'West').! !

!MarsRoverLogTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 14:13:25'!
test06HeadingPositionLogShowsLogCorrectly
	| marsRover headingpositionLog |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingpositionLog := MarsRoverHeadingPositionLog subscribingTo: marsRover .
	marsRover process: 'fr' .

	self assert: headingpositionLog log equals: (OrderedCollection with: 1@2  with:'East' ).! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 13:37:54'!
test01WindowShowsPositionAfterChange
	| marsRover  positionWindow|
	
	marsRover:=MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionWindow := MarsRoverPositionWindow subscribingTo: marsRover .
	marsRover process: 'f'.
	self assert: positionWindow show equals: 1@2 .
	! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 13:44:58'!
test02WindowShowsPositionAfterManyChanges
	| marsRover positionWindow |
	
	marsRover:=MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionWindow := MarsRoverPositionWindow subscribingTo: marsRover .
	marsRover process: 'frflf'.
	self assert: positionWindow show equals:2@3 .
	! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 13:47:03'!
test03WindowShowsNothingAfterFirstChange
	| marsRover headingWindow|
	
	marsRover:=MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingWindow := MarsRoverHeadingWindow subscribingTo: marsRover .
	marsRover process: 'f'.
	self assert: headingWindow show equals: '' .
	! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 13:53:20'!
test04WindowShowsHeadingAfterChange
	| marsRover headingWindow |
	
	marsRover:=MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingWindow := MarsRoverHeadingWindow subscribingTo: marsRover .
	marsRover process: 'fr'.
	self assert: headingWindow show equals: 'Apuntando al Este' .
	! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 16:47:59'!
test05WindowShowsPositionAfterChangeWithoutHeadingChange
	| marsRover headingpositionWindow |
	
	marsRover:=MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingpositionWindow := MarsRoverHeadingPositionWindow subscribingTo: marsRover .
	marsRover process: 'f'.
	
	self assert: headingpositionWindow show equals: ('1@2').
	! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 16:49:40'!
test06WindowShowsHeadingAndPositionAfterChange
	| marsRover headingpositionWindow |
	
	marsRover:=MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingpositionWindow := MarsRoverHeadingPositionWindow subscribingTo: marsRover .
	marsRover process: 'fr'.
	
	self assert: headingpositionWindow show equals: ('Apuntando al Este','1@2').
	! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 16:50:04'!
test07WindowShowsHeadingPositionAfterManyChanges
	| marsRover headingpositionWindow |
	
	marsRover:=MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingpositionWindow := MarsRoverHeadingPositionWindow subscribingTo: marsRover .
	marsRover process: 'frf'.
	
	self assert: headingpositionWindow show equals: ('Apuntando al Este','2@2').
	! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head log observer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'VA 10/29/2023 14:24:16'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self .
	log:= OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'VA 10/30/2023 12:29:30'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'VA 10/30/2023 13:32:17'!
rotateLeft
	
	head rotateLeft.
	self notifyHeadingChangeTo: observer .! !

!MarsRover methodsFor: 'heading' stamp: 'VA 10/30/2023 13:32:23'!
rotateRight
	
	head rotateRight.
	self notifyHeadingChangeTo: observer .! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'VA 10/30/2023 13:32:03'!
moveEast
	
	position := position + (1@0).
	self notifyPositionChangeTo: observer .! !

!MarsRover methodsFor: 'moving' stamp: 'VA 10/29/2023 14:29:29'!
moveForward
	
	head moveForward.
	! !

!MarsRover methodsFor: 'moving' stamp: 'VA 10/30/2023 13:31:46'!
moveNorth
	
	position := position + (0@1).
	self notifyPositionChangeTo: observer .! !

!MarsRover methodsFor: 'moving' stamp: 'VA 10/30/2023 13:31:53'!
moveSouth
	
	position := position + (0@-1).
	self notifyPositionChangeTo: observer .! !

!MarsRover methodsFor: 'moving' stamp: 'VA 10/30/2023 13:31:58'!
moveWest
	
	position := position + (-1@0).
	self notifyPositionChangeTo: observer .! !

!MarsRover methodsFor: 'moving' stamp: 'VA 10/30/2023 13:29:40'!
notifyHeadingChangeTo: anObserver
	
	anObserver updateHeadingWith: head.! !

!MarsRover methodsFor: 'moving' stamp: 'VA 10/30/2023 13:30:18'!
notifyPositionChangeTo: anObserver
	
	anObserver updatePositionWith: position.! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'windowProcess' stamp: 'VA 10/29/2023 22:42:50'!
showHeading
	^''.! !

!MarsRover methodsFor: 'windowProcess' stamp: 'VA 10/29/2023 22:25:50'!
showPosition
	^position.! !


!MarsRover methodsFor: 'logProcess' stamp: 'VA 10/30/2023 16:52:31'!
registerHeadingObserver: aMarsRoverHeading
	observer := aMarsRoverHeading.! !

!MarsRover methodsFor: 'logProcess' stamp: 'VA 10/30/2023 16:53:01'!
registerHeadingPositionObserver: aMarsRoverHeadingPositionLog 
	observer := aMarsRoverHeadingPositionLog ! !

!MarsRover methodsFor: 'logProcess' stamp: 'VA 10/30/2023 16:53:14'!
registerPositionObserver: aMarsRoverPosition
	observer := aMarsRoverPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 16:51:46'!
updateHeadingWith: aHeading
	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 16:51:38'!
updatePositionWith: aPosition 
	self subclassResponsibility ! !


!classDefinition: #MarsRoverLog category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLog methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 13:35:09'!
initializeSubscribingTo: aMarsRover 
	self subclassResponsibility ! !

!MarsRoverLog methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 13:34:58'!
log
	self subclassResponsibility ! !

!MarsRoverLog methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 13:35:19'!
updateHeadingWith: aHeading
	self subclassResponsibility ! !

!MarsRoverLog methodsFor: 'as yet unclassified' stamp: 'VA 10/30/2023 13:35:29'!
updatePositionWith: aPosition
	self subclassResponsibility ! !


!classDefinition: #MarsRoverHeadingLog category: 'MarsRover-WithHeading'!
MarsRoverLog subclass: #MarsRoverHeadingLog
	instanceVariableNames: 'marsRover log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLog methodsFor: 'initialize' stamp: 'VA 10/30/2023 16:52:31'!
initializeSubscribingTo: aMarsRover 
	
	marsRover := aMarsRover.
	marsRover registerHeadingObserver: self.
	log := OrderedCollection new.! !


!MarsRoverHeadingLog methodsFor: 'log' stamp: 'VA 10/30/2023 11:46:14'!
log
	^log! !

!MarsRoverHeadingLog methodsFor: 'log' stamp: 'VA 10/30/2023 13:31:16'!
updateHeadingWith: aHeading
	(aHeading isKindOf: MarsRoverHeadingEast )ifTrue: [ log add:'East'].
	(aHeading isKindOf: MarsRoverHeadingNorth ) ifTrue: [ log add:'North'].
	(aHeading isKindOf: MarsRoverHeadingSouth ) ifTrue: [ log add:'South'] .
	(aHeading isKindOf: MarsRoverHeadingWest )ifTrue: [log add:'West'].! !

!MarsRoverHeadingLog methodsFor: 'log' stamp: 'VA 10/30/2023 13:31:06'!
updatePositionWith: aPosition
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingLog class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingLog class
	instanceVariableNames: ''!

!MarsRoverHeadingLog class methodsFor: 'class initialization' stamp: 'VA 10/30/2023 11:43:34'!
subscribingTo: aMarsRover 
	^self new initializeSubscribingTo: aMarsRover .! !


!classDefinition: #MarsRoverHeadingPositionLog category: 'MarsRover-WithHeading'!
MarsRoverLog subclass: #MarsRoverHeadingPositionLog
	instanceVariableNames: 'marsRover log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingPositionLog methodsFor: 'initialize' stamp: 'VA 10/30/2023 16:53:01'!
initializeSubscribingTo: aMarsRover 
	
	marsRover := aMarsRover.
	marsRover registerHeadingPositionObserver: self.
	log:= OrderedCollection new.! !

!MarsRoverHeadingPositionLog methodsFor: 'initialize' stamp: 'VA 10/30/2023 14:11:13'!
log
	^log! !

!MarsRoverHeadingPositionLog methodsFor: 'initialize' stamp: 'VA 10/30/2023 14:11:34'!
updateHeadingWith: aHeading
	(aHeading isKindOf: MarsRoverHeadingEast )ifTrue: [ log add:'East'].
	(aHeading isKindOf: MarsRoverHeadingNorth ) ifTrue: [ log add:'North'].
	(aHeading isKindOf: MarsRoverHeadingSouth ) ifTrue: [ log add:'South'] .
	(aHeading isKindOf: MarsRoverHeadingWest )ifTrue: [log add:'West'].! !

!MarsRoverHeadingPositionLog methodsFor: 'initialize' stamp: 'VA 10/30/2023 14:11:45'!
updatePositionWith: aPosition
	log add: aPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingPositionLog class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingPositionLog class
	instanceVariableNames: 'marsRover'!

!MarsRoverHeadingPositionLog class methodsFor: 'class initialization' stamp: 'VA 10/30/2023 14:08:57'!
subscribingTo: aMarsRover 
	^self new initializeSubscribingTo:aMarsRover .! !


!MarsRoverHeadingPositionLog class methodsFor: 'initialization' stamp: 'VA 10/30/2023 14:08:52'!
initializeSubscribingTo: aMarsRover 
	self shouldBeImplemented.
	marsRover := aMarsRover.! !


!classDefinition: #MarsRoverPositionLog category: 'MarsRover-WithHeading'!
MarsRoverLog subclass: #MarsRoverPositionLog
	instanceVariableNames: 'marsRover log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionLog methodsFor: 'initialization' stamp: 'VA 10/30/2023 16:53:14'!
initializeSubscribingTo: aMarsRover 
	
	marsRover := aMarsRover.
	marsRover registerPositionObserver: self.
	log := OrderedCollection new.! !

!MarsRoverPositionLog methodsFor: 'initialization' stamp: 'VA 10/30/2023 13:30:10'!
updateHeadingWith: aHeading
	! !

!MarsRoverPositionLog methodsFor: 'initialization' stamp: 'VA 10/30/2023 13:30:41'!
updatePositionWith: aPosition
	log add: aPosition .! !


!MarsRoverPositionLog methodsFor: 'log' stamp: 'VA 10/30/2023 11:04:00'!
log
	^log! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverPositionLog class' category: 'MarsRover-WithHeading'!
MarsRoverPositionLog class
	instanceVariableNames: ''!

!MarsRoverPositionLog class methodsFor: 'class initialization' stamp: 'VA 10/30/2023 11:02:52'!
subscribingTo: aMarsRover 
	^self new initializeSubscribingTo: aMarsRover .! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!classDefinition: #MarsRoverHeadingPositionWindow category: 'MarsRover-WithHeading'!
MarsRoverWindow subclass: #MarsRoverHeadingPositionWindow
	instanceVariableNames: 'marsRover window headingWindow positionWindow'
	classVariableNames: 'Headingwindow'
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingPositionWindow methodsFor: 'initialization' stamp: 'VA 10/30/2023 16:53:01'!
initializeSubscribingTo: aMarsRover 
	
	marsRover := aMarsRover.
	marsRover registerHeadingPositionObserver: self.
	positionWindow:= ''.
	headingWindow :=''.! !


!MarsRoverHeadingPositionWindow methodsFor: 'window' stamp: 'VA 10/30/2023 16:44:22'!
show
	^headingWindow, positionWindow ! !

!MarsRoverHeadingPositionWindow methodsFor: 'window' stamp: 'VA 10/30/2023 16:41:33'!
updateHeadingWith: aHeading
	(aHeading isKindOf: MarsRoverHeadingEast )ifTrue: [ headingWindow :='Apuntando al Este'].
	(aHeading isKindOf: MarsRoverHeadingNorth ) ifTrue: [ headingWindow :='Apuntando al Norte'].
	(aHeading isKindOf: MarsRoverHeadingSouth ) ifTrue: [ headingWindow := 'Apuntando al Sur'] .
	(aHeading isKindOf: MarsRoverHeadingWest )ifTrue: [headingWindow :='Apuntando al Oeste'].! !

!MarsRoverHeadingPositionWindow methodsFor: 'window' stamp: 'VA 10/30/2023 16:44:46'!
updatePositionWith: aPosition 
	positionWindow := (aPosition asString) .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingPositionWindow class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingPositionWindow class
	instanceVariableNames: ''!

!MarsRoverHeadingPositionWindow class methodsFor: 'class initialization' stamp: 'VA 10/30/2023 14:16:37'!
subscribingTo: aMarsRover 
	^self new initializeSubscribingTo: aMarsRover .
	! !


!classDefinition: #MarsRoverHeadingWindow category: 'MarsRover-WithHeading'!
MarsRoverWindow subclass: #MarsRoverHeadingWindow
	instanceVariableNames: 'marsRover valueToShow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWindow methodsFor: 'initialization' stamp: 'VA 10/30/2023 16:52:31'!
initializeSubscribingTo: aMarsRover 
	marsRover := aMarsRover.
	marsRover registerHeadingObserver: self.
	valueToShow:=''.! !


!MarsRoverHeadingWindow methodsFor: 'window' stamp: 'VA 10/30/2023 13:49:02'!
show
	^valueToShow ! !

!MarsRoverHeadingWindow methodsFor: 'window' stamp: 'VA 10/30/2023 13:54:15'!
updateHeadingWith: aHeading
	(aHeading isKindOf: MarsRoverHeadingEast )ifTrue: [ valueToShow :='Apuntando al Este'].
	(aHeading isKindOf: MarsRoverHeadingNorth ) ifTrue: [ valueToShow :='Apuntando al Norte'].
	(aHeading isKindOf: MarsRoverHeadingSouth ) ifTrue: [ valueToShow :='Apuntando al Sur'] .
	(aHeading isKindOf: MarsRoverHeadingWest )ifTrue: [valueToShow :='Apuntando al Oeste'].! !

!MarsRoverHeadingWindow methodsFor: 'window' stamp: 'VA 10/30/2023 13:48:47'!
updatePositionWith: aPosition 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWindow class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingWindow class
	instanceVariableNames: ''!

!MarsRoverHeadingWindow class methodsFor: 'class initialization' stamp: 'VA 10/30/2023 13:47:48'!
subscribingTo: aMarsRover 
	^self new initializeSubscribingTo: aMarsRover .! !


!classDefinition: #MarsRoverPositionWindow category: 'MarsRover-WithHeading'!
MarsRoverWindow subclass: #MarsRoverPositionWindow
	instanceVariableNames: 'marsRover valueToShow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionWindow methodsFor: 'initialization' stamp: 'VA 10/30/2023 16:53:14'!
initializeSubscribingTo: aMarsRover 
	marsRover := aMarsRover.
	marsRover registerPositionObserver: self.
	valueToShow :=''.! !


!MarsRoverPositionWindow methodsFor: 'window' stamp: 'VA 10/30/2023 13:45:11'!
updateHeadingWith: aHead 
	! !

!MarsRoverPositionWindow methodsFor: 'window' stamp: 'VA 10/30/2023 13:43:58'!
updatePositionWith: aPosition 
	valueToShow:= aPosition .! !


!MarsRoverPositionWindow methodsFor: 'accessing' stamp: 'VA 10/30/2023 13:44:16'!
show
	^valueToShow ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverPositionWindow class' category: 'MarsRover-WithHeading'!
MarsRoverPositionWindow class
	instanceVariableNames: ''!

!MarsRoverPositionWindow class methodsFor: 'class initialization' stamp: 'VA 10/30/2023 13:38:31'!
subscribingTo: aMarsRover 
	^self new initializeSubscribingTo:aMarsRover .! !
