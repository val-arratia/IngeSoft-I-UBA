!classDefinition: #TDDDoorsFlipperTests category: 'EjercicioPuertas'!
TestCase subclass: #TDDDoorsFlipperTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioPuertas'!

!TDDDoorsFlipperTests methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:40:55'!
test01AllDoorsAreClosed
	|doors|
	doors := TDDDoorsFlipper with:1.
	"No hace falta:
	self assertThat: doors size isEqualTo: 100.
	
	Empezar solo con una puerta tambien puede estar bien. Modelar solo la puerta.
	Nada a isEqualTo --	> Estamos testeando la inicializacion
	"
	self assert: (doors isClosed: 1). ! !

!TDDDoorsFlipperTests methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:42:50'!
test02FlipOneDoor
	|doors|
	doors := TDDDoorsFlipper with:1.
	"No hace falta:
	self assertThat: doors size isEqualTo: 100.
	
	Empezar solo con una puerta tambien puede estar bien. Modelar solo la puerta.
	Nada a isEqualTo --	> Estamos testeando la inicializacion
	"
	doors flipBy:1.
	self deny: (doors isClosed: 1). ! !

!TDDDoorsFlipperTests methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:44:52'!
test03DoubleFlip
	|doors|
	doors := TDDDoorsFlipper with: 2.
	
	doors flipAll.
	self deny: (doors isClosed: 1). 
	self deny: (doors isClosed: 2).! !

!TDDDoorsFlipperTests methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:10:25'!
test04 
"testear el estado de las cosas vs el comportamiento
Estado vs Comportamiento
no es necesario testear el estado una vez que creamos el doorsFli
no nos importa el estado inicial
este va a estar testeado cuando haga el flip

¿Por qué testea con 2 y no 100?
Porque es 

HundredDoors no es buen nombre"
	|doors|
	doors := TDDDoorsFlipper with: 2.

	self assert: (doors isClosed: 1). 
	self assert: (doors isClosed: 2).! !

!TDDDoorsFlipperTests methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:09:43'!
test05
	|doors|
	doors := TDDDoorsFlipper with: 4.
	
	doors flipBy: 2.
	self assert: (doors isClosed: 1). 
	self deny: (doors isClosed: 2).! !

!TDDDoorsFlipperTests methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:29:31'!
test06
	|doors|
	doors := TDDDoorsFlipper with: 4.
	
	doors flipAll.
	self deny: (doors isClosed: 1).
	self assert: (doors isClosed: 2). 
	self deny: (doors isClosed: 3).! !

!TDDDoorsFlipperTests methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:46:52'!
test08

	Assert should.! !


!classDefinition: #TDDDoorsFlipper category: 'EjercicioPuertas'!
Object subclass: #TDDDoorsFlipper
	instanceVariableNames: 'closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EjercicioPuertas'!

!TDDDoorsFlipper methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 20:52:48'!
flip
	closed := closed not.! !

!TDDDoorsFlipper methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:28:03'!
flipAll
	1 to: closed size do: [:aDoorNumber | self flipBy: aDoorNumber ]
	! !

!TDDDoorsFlipper methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:34:14'!
flipBy: aStep
	(aStep < 1) ifTrue:[self error: self class errorCannotFlipByNegativeNumber].
	
	aStep to: closed size by: aStep do:[:aDoorNumber | closed at: aDoorNumber put: (closed at: aDoorNumber) not ].! !

!TDDDoorsFlipper methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:12:52'!
initializeWith: aNumberOfDoors
	closed := Array new: aNumberOfDoors withAll: false. ! !

!TDDDoorsFlipper methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:27:00'!
isClosed: aDoorNumber
	^closed at: aDoorNumber .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDDoorsFlipper class' category: 'EjercicioPuertas'!
TDDDoorsFlipper class
	instanceVariableNames: ''!

!TDDDoorsFlipper class methodsFor: 'as yet unclassified' stamp: 'sg 10/2/2023 21:05:07'!
with: aNumberDoors
	^self new initializeWith: aNumberDoors .! !
