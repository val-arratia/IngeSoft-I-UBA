!classDefinition: #CartTest category: 'Ejercicio-Tus-Libros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Tus-Libros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'mf 10/30/2023 19:36:51'!
test01CartIsCreatedEmpty

	|cart|

	cart := Cart new.

	self assert: cart isEmpty! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'VA 11/2/2023 16:42:29'!
test02CartAddsABookCorrectly

	|cart book stock|
	book := '1234'.
	stock := Stock with:(OrderedCollection with: book).
	cart := Cart withStock: stock.
	
	cart addBook: book times: 1.
	
	self assert: (cart hasBook: book).
	self assert: cart size equals: 1.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'VA 11/2/2023 16:42:14'!
test03CartAddsManyBooksCorrectly

	|cart book anotherBook stock |
	book := '1234'.
	anotherBook :='1111'.
	stock := Stock with:(OrderedCollection with: book with: anotherBook).
	cart := Cart withStock: stock.
	
	cart addBook: book.
	cart addBook: anotherBook .
	
	self assert: (cart hasBook: book).
	self assert: (cart hasBook: anotherBook ).
	self assert: cart size equals: 2.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'VA 11/2/2023 16:37:16'!
test04AssertThatCartCanAddTheSameBookManyTimes
	|cart book anotherBook stock |
	book := '1234'.
	anotherBook :='1111'.
	stock := Stock with:(OrderedCollection with: book with: anotherBook).
	cart := Cart withStock: stock.
	cart addBook: book times: 3.
	cart addBook: anotherBook times:1.
	
	self assert: (cart hasBook: book times: 3).
	self assert: (cart hasBook: anotherBook times: 1).
	self assert: cart size equals: 4.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'VA 11/2/2023 16:42:02'!
test05CartDisplaysCorrectly
	|cart book anotherBook stock |
	book := '1234'.
	anotherBook :='1111'.
	stock := Stock with:(OrderedCollection with: book with: anotherBook).
	cart := Cart withStock: stock.
	cart addBook: book times: 2.
	cart addBook: anotherBook times:1.
	
	self assert: cart display equals: (OrderedCollection with: book with: book with: anotherBook ) .
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'VA 11/2/2023 16:42:07'!
test06CannotAddABookThatHasNotStock
	|cart  stock book anotherBook bookNotInStock |
	book := '1234'.
	anotherBook :='1111'.
	stock := Stock with:(OrderedCollection with: book with: anotherBook).
	cart := Cart withStock: stock.
	bookNotInStock := '1235'.	
	
	self should: [cart addBook: bookNotInStock times: 1.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Stock bookIsNotInStockErrorMessage equals: anError messageText.
			self assert: 0 equals: cart size.
			]
	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'VA 11/2/2023 16:49:34'!
test07CannotAddABookWithNegativeQuantity
	|cart  stock book |
	book := '1234'.
	stock := Stock with:(OrderedCollection with: book).
	cart := Cart withStock: stock.
	
	self should: [cart addBook: book times: -1.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Cart negativeQuantityErrorMessage equals: anError messageText.
			self assert: 0 equals: cart size.
			]
	! !


!classDefinition: #Cart category: 'Ejercicio-Tus-Libros'!
Object subclass: #Cart
	instanceVariableNames: 'bookCollection stock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Tus-Libros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'mf 10/30/2023 19:54:18'!
addBook: aBook 
	bookCollection add: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'mf 10/30/2023 19:55:14'!
hasBook: aBook 
	^bookCollection includes: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'mf 10/30/2023 19:54:34'!
initialize
	bookCollection := OrderedCollection new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'mf 10/30/2023 19:54:54'!
isEmpty
	^bookCollection isEmpty. ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'mf 10/30/2023 19:55:47'!
size
	^bookCollection size! !


!Cart methodsFor: 'accessing' stamp: 'VA 11/2/2023 16:47:23'!
addBook: aBookToAdd times: aQuantity 
	self assertBookIsInStock: aBookToAdd .
	self assertQuantityIsPositive:aQuantity .
	aQuantity timesRepeat:[ bookCollection add: aBookToAdd ].! !

!Cart methodsFor: 'accessing' stamp: 'VA 11/2/2023 16:29:05'!
assertBookIsInStock: aBookToAdd 
	stock hasThisBook: aBookToAdd .! !

!Cart methodsFor: 'accessing' stamp: 'VA 11/2/2023 16:48:18'!
assertQuantityIsPositive:aQuantity .
	(aQuantity < 0)ifTrue: [self error: self class 	negativeQuantityErrorMessage]! !

!Cart methodsFor: 'accessing' stamp: 'mf 10/30/2023 20:38:26'!
display
	^ bookCollection ! !

!Cart methodsFor: 'accessing' stamp: 'mf 10/30/2023 20:35:57'!
hasBook: aBook times: aNumberOfTimes
	|temporalCollection|
	temporalCollection := bookCollection select:[:aBookInIt| aBook = aBookInIt ] .
	^temporalCollection size 	 = aNumberOfTimes.! !


!Cart methodsFor: 'initialization' stamp: 'VA 11/2/2023 15:55:05'!
initializeWithStock: aStock 
	bookCollection := OrderedCollection new.	
	stock := aStock.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Ejercicio-Tus-Libros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'VA 11/2/2023 16:48:41'!
negativeQuantityErrorMessage
	^'Cantidad a añadir negativa'! !


!Cart class methodsFor: 'class initialization' stamp: 'VA 11/2/2023 15:53:24'!
withStock: aStock 
	^self new initializeWithStock: aStock.! !


!classDefinition: #Stock category: 'Ejercicio-Tus-Libros'!
Object subclass: #Stock
	instanceVariableNames: 'listOfBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Tus-Libros'!

!Stock methodsFor: 'initialize' stamp: 'VA 11/2/2023 16:33:42'!
hasThisBook: aBook
	(listOfBooks includes: aBook )ifFalse: [self error: self class bookIsNotInStockErrorMessage]! !

!Stock methodsFor: 'initialize' stamp: 'VA 11/2/2023 15:52:54'!
initializeWith: aListOfBooks 
	
	listOfBooks := aListOfBooks.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stock class' category: 'Ejercicio-Tus-Libros'!
Stock class
	instanceVariableNames: ''!

!Stock class methodsFor: 'class initialization' stamp: 'VA 11/2/2023 16:31:59'!
bookIsNotInStockErrorMessage
	^'No hay disponibilidad de este libro'! !

!Stock class methodsFor: 'class initialization' stamp: 'VA 11/2/2023 15:52:41'!
with: aListOfBooks
	^self new initializeWith: aListOfBooks 
	! !
