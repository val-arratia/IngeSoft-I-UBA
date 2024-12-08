!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'VA 11/6/2023 16:15:53'!
defaultCatalog
	
	^ Dictionary new at: self itemSellByTheStore put:  self itemPriceSellByTheStore ;yourself .! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'VA 11/6/2023 16:16:09'!
itemPriceSellByTheStore
	
	^ 50! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'todayTest debitFromCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 11:40:46'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 15:36:52'!
createCartWithItems

	^ self createCart add: self itemSellByTheStore withOcurrences: 3! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 13:22:22'!
debit: anAmount from: aCreditCard
	debitFromCreditCard value: anAmount value:aCreditCard .! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 11:58:15'!
defaultCatalog
	
	^ Dictionary new at: self itemSellByTheStore put:  self itemPriceSellByTheStore ;yourself .! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 12:51:30'!
expiredCreditCard
	| monthOfYear |
	monthOfYear := Month month: todayTest monthIndex - 1 year: todayTest yearNumber.
	^CreditCard withExpiration: monthOfYear .
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 11:46:42'!
itemPriceSellByTheStore
	
	^ 50! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 11:41:09'!
itemSellByTheStore
	
	^ 'validBook'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 15:05:02'!
setUp
	todayTest := DateAndTime today.
	debitFromCreditCard :=  [:anAmount :aCreditCard | ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 15:30:10'!
test01CannotCheckoutAnEmptyCart
	| sales |
	sales := OrderedCollection new.
	self should: [ Cashier toCheckout: self createCart payingWith: self validCreditCard using:self theDate: todayTest registeringOn: sales. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cannotCheckoutAnEmptyCartErrorMessage ]
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 15:37:00'!
test02CheckoutACartWithItemsCalculateTheTotalCorrectly
	| cart cashier sales |
	cart := self createCartWithItems.
	sales := OrderedCollection new.
	
	cashier:= Cashier toCheckout: cart payingWith: self validCreditCard using: self theDate: todayTest registeringOn: sales.
	self assert: cashier checkout equals:(self itemPriceSellByTheStore * 3).! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 15:37:37'!
test03CannotPayWithAnExpiredCreditCard
	| cart sales |
	cart := self createCartWithItems .
	sales := OrderedCollection new.
	
	self should:[Cashier toCheckout: cart payingWith: self expiredCreditCard using: self theDate: todayTest registeringOn: sales ]
		raise:Error
		withExceptionDo:[:anError |
			self assert: anError messageText = Cashier cannotPayWithExpiredCreditCardErrorMessage ].
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 15:38:05'!
test04PayWithCreditCardUsingMerchantProcessor
	| cart creditCard cashier debitedAmount debitedCreditCard total sales|
	cart := self createCartWithItems.
	creditCard := self validCreditCard.
	sales := OrderedCollection new.
	cashier := Cashier toCheckout: cart payingWith: creditCard using: self theDate: todayTest registeringOn: sales.
	
	debitFromCreditCard := [ :anAmount :aCreditCard |  
		debitedAmount := anAmount.
		debitedCreditCard := aCreditCard ].
	total:= cashier checkout .
	self assert: debitedCreditCard equals: creditCard.
	self assert: debitedAmount equals: total .
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 15:38:20'!
test05CannotPayWithCreditCardHasNotCredit
	| cart creditCard cashier sales |
	cart := self createCartWithItems.
	creditCard := self validCreditCard.
	sales := OrderedCollection new.
	cashier := Cashier toCheckout: cart payingWith: creditCard using: self theDate: todayTest registeringOn: sales.
	
	debitFromCreditCard := [ :anAmount :aCreditCard |  self error: Cashier creditCardHasNotCreditErrorMessage ].
	
	self should: [cashier checkout ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNotCreditErrorMessage. ]
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 15:38:29'!
test06CashierRegisterTheSales
	| cart creditCard cashier sales total |
	cart := self createCartWithItems.
	creditCard := self validCreditCard.
	sales := OrderedCollection new.
	cashier := Cashier toCheckout: cart payingWith: creditCard using: self theDate: todayTest registeringOn: sales.
	total:=  cashier checkout.				
	self assert: sales first equals: total.
	self assert: sales size = 1.
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'VA 11/6/2023 12:52:07'!
validCreditCard
	| monthOfYear |
	monthOfYear := Month month: todayTest monthIndex year: todayTest yearNumber.
	^CreditCard withExpiration: monthOfYear .
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'VA 11/6/2023 11:58:00'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'VA 11/6/2023 12:12:22'!
total
	^items sum:[:anItem | catalog at: anItem  ]
	! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !


!Cart methodsFor: 'accessing' stamp: 'VA 11/6/2023 12:03:35'!
catalog
	
	^catalog! !

!Cart methodsFor: 'accessing' stamp: 'VA 11/6/2023 12:03:55'!
items
	
	^items! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart date merchantProcessor creditCard salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'VA 11/6/2023 12:25:51'!
initializeToCheckout: aCart payingWith: aCard theDate: aDate.
	cart := aCart.
	card:=aCard .
	date:= aDate.! !

!Cashier methodsFor: 'initialization' stamp: 'VA 11/6/2023 13:23:55'!
initializeToCheckout: aCart payingWith: aCreditCard using: aMerchantProcessor theDate: aDate 
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	date := aDate.! !

!Cashier methodsFor: 'initialization' stamp: 'VA 11/6/2023 15:23:14'!
initializeToCheckout: aCart payingWith: aCreditCard using: aMerchantProcessor theDate: aDate registeringOn: aSalesBook 
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	date := aDate.
	salesBook := aSalesBook.! !


!Cashier methodsFor: 'checkout' stamp: 'VA 11/6/2023 15:24:56'!
checkout
	|total|
	total := cart total.
	merchantProcessor debit: total from: creditCard.
	salesBook add: total.
	^total
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'class initialization' stamp: 'VA 11/6/2023 14:59:26'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue:[self error: self cannotCheckoutAnEmptyCartErrorMessage.]! !

!Cashier class methodsFor: 'class initialization' stamp: 'VA 11/6/2023 15:00:18'!
assertIsNotExpired: aCreditCard toDate: aDate

	^ (aCreditCard isExpiredToDate: aDate) ifTrue: [self error: self cannotPayWithExpiredCreditCardErrorMessage ]! !

!Cashier class methodsFor: 'class initialization' stamp: 'VA 11/6/2023 12:27:25'!
toCheckout: aCart payingWith: aCard theDate: aDate  
	aCart isEmpty ifTrue:[self error: self cannotCheckoutAnEmptyCartErrorMessage.].
	(aCard isExpiredToDate: aDate) ifTrue: [self error: self cannotPayWithExpiredCreditCardErrorMessage ].
	^self new initializeToCheckout: aCart payingWith: aCard theDate: aDate.
	! !

!Cashier class methodsFor: 'class initialization' stamp: 'VA 11/6/2023 15:00:18'!
toCheckout: aCart payingWith: aCreditCard using: aMerchantProcessor theDate: aDate
	self assertCartIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard toDate: aDate.
	^self new initializeToCheckout: aCart payingWith: aCreditCard using: aMerchantProcessor theDate: aDate .! !

!Cashier class methodsFor: 'class initialization' stamp: 'VA 11/6/2023 15:25:44'!
toCheckout: aCart payingWith: aCreditCard using: aMerchantProcessor theDate: aDate registeringOn: aSalesBook
	self assertCartIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard toDate: aDate.
	^self new initializeToCheckout: aCart  payingWith: aCreditCard using: aMerchantProcessor theDate:aDate registeringOn: aSalesBook .! !


!Cashier class methodsFor: 'error messages' stamp: 'VA 11/6/2023 11:43:06'!
cannotCheckoutAnEmptyCartErrorMessage
	^'No se puede hacer checkout de un carrito vacio'! !

!Cashier class methodsFor: 'error messages' stamp: 'VA 11/6/2023 12:22:40'!
cannotPayWithExpiredCreditCardErrorMessage
	^'La tarjeta está expirada'! !

!Cashier class methodsFor: 'error messages' stamp: 'VA 11/6/2023 14:58:03'!
creditCardHasNotCreditErrorMessage
	^'La tarjeta no tiene credito'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'monthOfYear expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'VA 11/6/2023 12:22:19'!
initializeWithExpiration: aMonthOfYear 
	
	expiration := aMonthOfYear.! !

!CreditCard methodsFor: 'initialization' stamp: 'VA 11/6/2023 12:40:31'!
isExpiredToDate: aDate
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber)start! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'class initialization' stamp: 'VA 11/6/2023 12:22:01'!
withExpiration: aMonthOfYear 
	^self new initializeWithExpiration: aMonthOfYear .! !
