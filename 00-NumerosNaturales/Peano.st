!classDefinition: #I category: 'Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Peano'!
I class
	instanceVariableNames: 'next previous'!

!I class methodsFor: 'Comparators' stamp: 'val 9/4/2023 15:05:49'!
< aNaturalNumber
	aNaturalNumber = I 	ifTrue: [ ^false].
	^true.! !


!I class methodsFor: 'Operations' stamp: 'Val 9/2/2023 13:28:50'!
* aNaturalNumber
	^aNaturalNumber.! !

!I class methodsFor: 'Operations' stamp: 'Val 9/2/2023 13:24:39'!
+ aNaturalNumber
	^aNaturalNumber next.! !

!I class methodsFor: 'Operations' stamp: 'val 9/4/2023 15:04:18'!
- aNaturalNumber
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'Operations' stamp: 'val 9/4/2023 15:02:43'!
/ aNaturalNumber
	aNaturalNumber = I ifFalse: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	^I! !


!I class methodsFor: 'Error Messages' stamp: 'val 9/4/2023 15:03:16'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !

!I class methodsFor: 'Error Messages' stamp: 'val 9/4/2023 15:03:33'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Las operaciones para números negativos no están soportadas'.
! !


!I class methodsFor: 'Next' stamp: 'Val 9/2/2023 13:31:53'!
next
	II previous: self.
	^II.! !


!I class methodsFor: 'Auxiliary Operations' stamp: 'Val 9/2/2023 15:39:57'!
substractTo: aNaturalNumber
	^aNaturalNumber previous.! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'val 9/4/2023 15:28:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := nil.! !


!classDefinition: #II category: 'Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'Auxiliary Operations' stamp: 'Val 9/2/2023 13:39:20'!
previous: aNaturalNumber
	previous := aNaturalNumber.! !

!II class methodsFor: 'Auxiliary Operations' stamp: 'Val 9/2/2023 15:37:03'!
substractTo: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!II class methodsFor: 'Next and Previous' stamp: 'Val 9/2/2023 15:31:26'!
next
	next ifNotNil:[^next].
	next := II createChildNamed: self name,'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'Next and Previous' stamp: 'Val 9/2/2023 13:22:40'!
previous
	^previous.! !


!II class methodsFor: 'Comparators' stamp: 'val 9/4/2023 15:05:33'!
< aNaturalNumber
	aNaturalNumber = I 	ifTrue: [ ^false].
	^self previous < aNaturalNumber previous.! !


!II class methodsFor: 'Operations' stamp: 'val 9/4/2023 15:00:57'!
* aNaturalNumber
	^aNaturalNumber + (self previous * aNaturalNumber).! !

!II class methodsFor: 'Operations' stamp: 'val 9/4/2023 15:06:33'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!II class methodsFor: 'Operations' stamp: 'val 9/4/2023 15:01:07'!
- aNaturalNumber
	^aNaturalNumber substractTo: self! !

!II class methodsFor: 'Operations' stamp: 'val 9/4/2023 15:01:55'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^self].
	self = aNaturalNumber ifTrue: [^I].
	self < aNaturalNumber ifTrue:[self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	^I + (self - aNaturalNumber / aNaturalNumber).! !


!II class methodsFor: 'Error Messages' stamp: 'val 9/4/2023 15:04:55'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor'! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'val 9/4/2023 15:28:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Peano'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'val 9/4/2023 15:28:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Peano'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Peano'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'val 9/4/2023 15:28:05'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!