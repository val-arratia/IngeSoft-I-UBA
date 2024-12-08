!classDefinition: #MarsRoverTest category: 'Mars Rover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverTest methodsFor: 'Zero' stamp: 'SG 10/7/2023 17:33:12'!
test01Zero
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: North new.
	
	rover runCommands: ''.
	
	self assert: [rover isInPosition: (0@0) facing: North new].! !


!MarsRoverTest methodsFor: 'One' stamp: 'SG 10/7/2023 17:36:24'!
test02OneEastRight
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: East new.
	
	rover runCommands: 'r'.
	
	self assert: [rover isInPosition: (0@0) facing: South new].! !

!MarsRoverTest methodsFor: 'One' stamp: 'VA 10/9/2023 11:59:33'!
test03OneEastLeft
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: East new.
	
	rover runCommands: 'l'.
	
	self assert: [rover isInPosition: (0@0) facing: North new].! !

!MarsRoverTest methodsFor: 'One' stamp: 'VA 10/9/2023 11:59:52'!
test04OneBackNorth
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: North new.
	
	rover runCommands: 'b'.
	
	self assert: [rover isInPosition: (0@-1) facing: North new].! !

!MarsRoverTest methodsFor: 'One' stamp: 'VA 10/9/2023 12:00:41'!
test05OneForwardNorth
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: North new.
	
	rover runCommands: 'f'.
	
	self assert: [rover isInPosition: (0@1) facing: North new].! !

!MarsRoverTest methodsFor: 'One' stamp: 'VA 10/9/2023 12:00:50'!
test06OneNorthLeft
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: North new.
	
	rover runCommands: 'l'.
	
	self assert: [rover isInPosition: (0@0) facing: West new].! !

!MarsRoverTest methodsFor: 'One' stamp: 'VA 10/9/2023 12:00:58'!
test07OneNorthRight
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: North new.
	
	rover runCommands: 'r'.
	
	self assert: [rover isInPosition: (0@0) facing: East new].! !

!MarsRoverTest methodsFor: 'One' stamp: 'VA 10/9/2023 12:02:41'!
test08OneSouthLeft
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: South new.
	
	rover runCommands: 'l'.
	
	self assert: [rover isInPosition: (0@0) facing: East new].! !

!MarsRoverTest methodsFor: 'One' stamp: 'VA 10/9/2023 12:02:53'!
test09OneSouthRight
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: South new.
	
	rover runCommands: 'r'.
	
	self assert: [rover isInPosition: (0@0) facing: West new].! !

!MarsRoverTest methodsFor: 'One' stamp: 'VA 10/9/2023 12:03:02'!
test10OneWestLeft
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: West new.
	
	rover runCommands: 'l'.
	
	self assert: [rover isInPosition: (0@0) facing: South new].! !

!MarsRoverTest methodsFor: 'One' stamp: 'VA 10/9/2023 12:03:11'!
test11OneWestRight
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: West new.
	
	rover runCommands: 'r'.
	
	self assert: [rover isInPosition: (0@0) facing: North new].! !


!MarsRoverTest methodsFor: 'Many' stamp: 'VA 10/9/2023 12:03:30'!
test12TwoForwardNorth
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: North new.
	
	rover runCommands: 'ff'.
	
	self assert: [rover isInPosition: (0@2) facing: North new].! !

!MarsRoverTest methodsFor: 'Many' stamp: 'VA 10/9/2023 12:43:12'!
test13InvalidCommand
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: North new.
	
	
	self should: [rover runCommands: 'fqf'.] 
		raise: Error 
		withExceptionDo: [:anError |
			self assert:(MarsRover invalidCommandDescription) equals:(anError messageText)	.
			self assert: (rover isInPosition: (0@1) facing: North new).
	].! !

!MarsRoverTest methodsFor: 'Many' stamp: 'VA 10/9/2023 13:26:19'!
test14ManyInstructions
	
	| rover |
	
	rover := MarsRover new withPosition: 0@0 facing: North new.
	
	rover runCommands: 'fffbblfbr'.
	
	self assert: [rover isInPosition: 0@1 facing: North new].! !


!classDefinition: #CardinalPoint category: 'Mars Rover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!CardinalPoint methodsFor: 'moving' stamp: 'SG 10/7/2023 18:45:27'!
backward
	self subclassResponsibility.! !

!CardinalPoint methodsFor: 'moving' stamp: 'SG 10/7/2023 18:45:11'!
forward
	self subclassResponsibility.! !


!CardinalPoint methodsFor: 'turning' stamp: 'SG 10/7/2023 17:29:22'!
left
	self subclassResponsibility.! !

!CardinalPoint methodsFor: 'turning' stamp: 'SG 10/7/2023 17:29:26'!
right
	self subclassResponsibility.! !


!CardinalPoint methodsFor: 'comparing' stamp: 'SG 10/7/2023 19:25:21'!
= anObject
	^ self class = anObject class.! !


!classDefinition: #East category: 'Mars Rover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!East methodsFor: 'moving' stamp: 'SG 10/7/2023 19:29:08'!
backward
	^ -1@0! !

!East methodsFor: 'moving' stamp: 'SG 10/7/2023 19:29:12'!
forward
	^ 1@0! !


!East methodsFor: 'turning' stamp: 'SG 10/7/2023 19:29:16'!
left
	^ North new
! !

!East methodsFor: 'turning' stamp: 'SG 10/7/2023 19:29:23'!
right
	^ South new.! !


!classDefinition: #North category: 'Mars Rover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!North methodsFor: 'moving' stamp: 'SG 10/7/2023 19:29:29'!
backward
	^ 0@-1! !

!North methodsFor: 'moving' stamp: 'SG 10/7/2023 19:29:33'!
forward
	^ 0@1! !


!North methodsFor: 'turning' stamp: 'SG 10/7/2023 19:29:37'!
left
	^ West new.! !

!North methodsFor: 'turning' stamp: 'SG 10/7/2023 19:29:41'!
right
	^ East new.! !


!classDefinition: #South category: 'Mars Rover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!South methodsFor: 'moving' stamp: 'SG 10/7/2023 19:29:46'!
backward
	^ 0@1! !

!South methodsFor: 'moving' stamp: 'SG 10/7/2023 19:29:49'!
forward
	^ 0@-1! !


!South methodsFor: 'turning' stamp: 'SG 10/7/2023 19:29:53'!
left
	^ East new.! !

!South methodsFor: 'turning' stamp: 'SG 10/7/2023 19:29:57'!
right
	^ West new.! !


!classDefinition: #West category: 'Mars Rover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!West methodsFor: 'moving' stamp: 'SG 10/7/2023 19:03:32'!
backward
	^1@0! !

!West methodsFor: 'moving' stamp: 'SG 10/7/2023 19:03:39'!
forward	
	^-1@0! !


!West methodsFor: 'turning' stamp: 'SG 10/7/2023 19:30:03'!
left
	^ South new.! !

!West methodsFor: 'turning' stamp: 'SG 10/7/2023 19:30:07'!
right
	^ North new.! !


!classDefinition: #MarsRover category: 'Mars Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position facing'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRover methodsFor: 'initialization' stamp: 'SG 10/7/2023 15:51:36'!
withPosition: aPosition facing: aCardinalPoint 
	position := aPosition.
	facing := aCardinalPoint.! !


!MarsRover methodsFor: 'running' stamp: 'SG 10/7/2023 19:31:13'!
moveBackwards
	^ position := position + (facing backward)! !

!MarsRover methodsFor: 'running' stamp: 'SG 10/7/2023 19:31:17'!
moveForward
	^ position := position + (facing forward)! !

!MarsRover methodsFor: 'running' stamp: 'VA 10/9/2023 00:56:11'!
runCommand: aCommand
	(MarsRoverCommand with: aCommand) runOver: self.
	
"
	aListOfCommands do: [:aCommand |
		(aCommand = $f) ifTrue: [self moveForward] ifFalse: [
			(aCommand = $b) ifTrue: [self moveBackwards] ifFalse:
						[(aCommand = $l) ifTrue: [self turnLeft] ifFalse: [
							(aCommand = $r) ifTrue: [	self turnRight] ifFalse: [^self].
					]
				]

			]
		]
"! !

!MarsRover methodsFor: 'running' stamp: 'VA 10/9/2023 00:51:10'!
runCommands: aListOfCommands
	aListOfCommands do: [:aCommand | self runCommand: aCommand ].
"
	aListOfCommands do: [:aCommand |
		(aCommand = $f) ifTrue: [self moveForward] ifFalse: [
			(aCommand = $b) ifTrue: [self moveBackwards] ifFalse:
						[(aCommand = $l) ifTrue: [self turnLeft] ifFalse: [
							(aCommand = $r) ifTrue: [	self turnRight] ifFalse: [^self].
					]
				]

			]
		]
"! !

!MarsRover methodsFor: 'running' stamp: 'SG 10/7/2023 19:31:20'!
turnLeft
	^ facing := facing left! !

!MarsRover methodsFor: 'running' stamp: 'SG 10/7/2023 19:31:23'!
turnRight
	^ facing := facing right! !


!MarsRover methodsFor: 'accessing' stamp: 'SG 10/7/2023 19:30:12'!
isInPosition: aPosition facing: aCardinalPoint
	^ (position = aPosition) and: (facing = aCardinalPoint).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:30:28'!
invalidCommandDescription
	^'Comando invalido'! !


!classDefinition: #MarsRoverCommand category: 'Mars Rover'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverCommand methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 11:59:06'!
runOver: aMarsRover
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: 'Mars Rover'!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:10:33'!
canHandle: aMarsRoverCommand
	self subclassResponsibility ! !

!MarsRoverCommand class methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 13:10:44'!
with: aMarsRoverCommand
	^(self allSubclasses detect:[:aMarsRoverCommandClass | aMarsRoverCommandClass canHandle: aMarsRoverCommand]) new.! !


!classDefinition: #InvalidCommand category: 'Mars Rover'!
MarsRoverCommand subclass: #InvalidCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!InvalidCommand methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:29:34'!
runOver: aMarsRover
	self error: (aMarsRover class invalidCommandDescription )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvalidCommand class' category: 'Mars Rover'!
InvalidCommand class
	instanceVariableNames: ''!

!InvalidCommand class methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:21:22'!
canHandle: aCommand
	^(aCommand = $b or: (aCommand = $f or: (aCommand = $l or: (aCommand = $r)) )) not.! !


!classDefinition: #ValidCommand category: 'Mars Rover'!
MarsRoverCommand subclass: #ValidCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!ValidCommand methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 13:00:19'!
runOver: aMarsRover
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ValidCommand class' category: 'Mars Rover'!
ValidCommand class
	instanceVariableNames: ''!

!ValidCommand class methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 13:12:21'!
canHandle: aMarsRoverCommand
	^false! !


!classDefinition: #BackwardCommand category: 'Mars Rover'!
ValidCommand subclass: #BackwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!BackwardCommand methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:23:07'!
runOver: aMarsRover
	aMarsRover moveBackwards .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BackwardCommand class' category: 'Mars Rover'!
BackwardCommand class
	instanceVariableNames: ''!

!BackwardCommand class methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:14:40'!
canHandle: aCommand
	^aCommand = $b.! !


!classDefinition: #ForwardCommand category: 'Mars Rover'!
ValidCommand subclass: #ForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!ForwardCommand methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:27:52'!
runOver: aMarsRover
	aMarsRover moveForward .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ForwardCommand class' category: 'Mars Rover'!
ForwardCommand class
	instanceVariableNames: ''!

!ForwardCommand class methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:18:09'!
canHandle: aCommand
	^aCommand = $f.! !


!classDefinition: #LeftCommand category: 'Mars Rover'!
ValidCommand subclass: #LeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!LeftCommand methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:28:06'!
runOver: aMarsRover
	aMarsRover turnLeft .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LeftCommand class' category: 'Mars Rover'!
LeftCommand class
	instanceVariableNames: ''!

!LeftCommand class methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:18:45'!
canHandle: aCommand
	^aCommand = $l.! !


!classDefinition: #RightCommand category: 'Mars Rover'!
ValidCommand subclass: #RightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!RightCommand methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:28:20'!
runOver: aMarsRover
	aMarsRover turnRight .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RightCommand class' category: 'Mars Rover'!
RightCommand class
	instanceVariableNames: ''!

!RightCommand class methodsFor: 'as yet unclassified' stamp: 'VA 10/9/2023 01:18:37'!
canHandle: aCommand
	^aCommand = $r.! !
