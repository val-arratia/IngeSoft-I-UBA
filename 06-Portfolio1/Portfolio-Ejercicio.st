!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/18/2023 11:50:38'!
test01PortfolioBalanceStartsWithZero
	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/18/2023 11:52:51'!
test02PortfolioWithAccountsBalanceIsAccountsBalance
	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	portfolio add: account .
		
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/18/2023 11:54:47'!
test03PortfolioWithPortfoliosAndAccountsBalanceIsSumOfAllAccountsBalance
	| portfolio portfolioWithPortfolioAndAccount account anotherAccount |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	portfolio add: account .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 50 on: anotherAccount .
	Withdraw register: 20 on: anotherAccount .
	
	portfolioWithPortfolioAndAccount := Portfolio new.
	portfolioWithPortfolioAndAccount add: anotherAccount.
	portfolioWithPortfolioAndAccount add: portfolio.
		
	self assert: (anotherAccount balance + portfolio balance) equals: portfolioWithPortfolioAndAccount balance! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/18/2023 11:56:18'!
test04PortfolioWithoutAccountsHasNotRegisteredTransactions
	| portfolio account deposit |
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit:= Deposit register: 50 on: account.
	
	self deny: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/18/2023 12:23:06'!
test05PortfolioHasRegisteredItsAccountsTransactions
	| portfolio account deposit |
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	deposit:= Deposit register: 50 on: account.
	portfolio add: account .
	
	self assert: (portfolio hasRegistered: deposit).
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/18/2023 12:26:46'!
test06PortfolioHasRegisteredItsAccountsAndPortfoliosTransactions
	| portfolio portfolioWithPortfolioAndAccount account anotherAccount deposit |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 50 on: account.
	portfolio add: account .
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 50 on: anotherAccount .
	Withdraw register: 20 on: anotherAccount .
	
	portfolioWithPortfolioAndAccount := Portfolio new.
	portfolioWithPortfolioAndAccount add: anotherAccount.
	portfolioWithPortfolioAndAccount add: portfolio.
	
	self assert: (portfolioWithPortfolioAndAccount hasRegistered: deposit).
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/18/2023 12:32:03'!
test07PortfolioWithoutAccountsHasNotTransactions
	self assert: (Portfolio new transactions isEmpty ).
	! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/18/2023 12:46:55'!
test08PortfolioWithAccountsHasItsTransactions
	| portfolio account deposit withdraw |
	account := ReceptiveAccount new.
	deposit := Deposit register: 50 on: account.
	withdraw := Withdraw register: 20 on: account.
	
	portfolio := Portfolio new add: account.

	self assert: 2 equals: portfolio transactions size.
	self assert: portfolio transactions includes: deposit .
	self assert: portfolio transactions includes: withdraw .! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/18/2023 12:59:56'!
test09PortfolioHasItsAccountsAndPortfoliosTransactions
	| portfolio portfolioWithPortfolioAndAccount account anotherAccount deposit anotherDeposit withdraw |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 50 on: account.
	portfolio add: account .
	
	anotherAccount := ReceptiveAccount new.
	anotherDeposit := Deposit register: 50 on: anotherAccount .
	withdraw := Withdraw register: 20 on: anotherAccount .
	
	portfolioWithPortfolioAndAccount := Portfolio new.
	portfolioWithPortfolioAndAccount add: anotherAccount.
	portfolioWithPortfolioAndAccount add: portfolio.

	self assert: 3 equals: portfolioWithPortfolioAndAccount transactions size.
	self assert: portfolioWithPortfolioAndAccount transactions includes: deposit .
	self assert: portfolioWithPortfolioAndAccount transactions includes: anotherDeposit .
	self assert: portfolioWithPortfolioAndAccount transactions includes: withdraw .! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/19/2023 13:11:47'!
test10PortfoliosCanNotAddRepeatedAccounts
	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	portfolio add: account .

	self should:[ portfolio add: account.] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accounts size.
			self assert: (portfolio accounts includes: account) 
			]
		! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/19/2023 13:11:47'!
test11PortfoliosCanNotAddExistingAccountsInItsPortfolios
	| portfolio account anotherPortfolio |
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	anotherPortfolio add: account .
	
	portfolio add: anotherPortfolio .
	
	self should:[ portfolio add: account.] 
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accounts size.
			self assert: (portfolio accounts includes: anotherPortfolio ) 
			]
		! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/19/2023 13:11:47'!
test12PortfoliosCanNotAddItself
	| portfolio |
	portfolio := Portfolio new.

	self
		should: [ portfolio add: portfolio ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: Portfolio canNotAddAccountErrorMessage
				equals: anError messageText.
			 ].! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/19/2023 13:11:47'!
test13PortfoliosCanNotAddExistingAccountInItsRoot
	| portfolio portfolioRoot account |
	portfolio := Portfolio new.
	portfolioRoot := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	portfolioRoot add: account .
	portfolioRoot add: portfolio.
	
	self
		should: [ portfolio add: account ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: Portfolio canNotAddAccountErrorMessage
				equals: anError messageText ].! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/19/2023 13:25:29'!
test14PortfoliosCanNotAddExistingAccountInItsRoots
	| portfolio portfolioRoot anotherPortfolioRoot account |
	portfolio := Portfolio new.
	portfolioRoot := Portfolio new.
	anotherPortfolioRoot := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit
		register: 50
		on: account.
	portfolioRoot add: account.
	
	portfolioRoot add: portfolio.
	anotherPortfolioRoot add: portfolio.
	
	self
		should: [ portfolio add: account ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: Portfolio canNotAddAccountErrorMessage
				equals: anError messageText ].! !

!PortfolioTest methodsFor: 'testing' stamp: 'VA 10/19/2023 15:14:59'!
test15PortfoliosCanNotAddPortfolioWithAnAlreadyExistingAccount
	| portfolio portfolioRoot anotherPortfolio account |
	portfolio := Portfolio new.
	portfolioRoot := Portfolio new.
	anotherPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit
		register: 50
		on: account.
	portfolioRoot add: account.
	portfolioRoot add: anotherPortfolio.
	portfolio add: account.
	self
		should: [ anotherPortfolio add: portfolio ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: Portfolio canNotAddAccountErrorMessage
				equals: anError messageText ].! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'as yet unclassified' stamp: 'VA 10/18/2023 11:44:58'!
balance
	self subclassResponsibility ! !

!Account methodsFor: 'as yet unclassified' stamp: 'VA 10/18/2023 11:45:32'!
hasRegistered: aTransaction
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts padre parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'VA 10/18/2023 11:41:14'!
balance
	^accounts sum:[:anAccount | anAccount  balance] ifEmpty: [0].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'VA 10/19/2023 13:38:05'!
initialize
	accounts := OrderedCollection new.
	parents:= OrderedCollection new.! !


!Portfolio methodsFor: 'accessing' stamp: 'VA 10/19/2023 00:19:52'!
accounts
	^accounts ! !

!Portfolio methodsFor: 'accessing' stamp: 'VA 10/19/2023 13:13:03'!
add: anAccount
	(self isOrAccountsIncludes: anAccount ) ifTrue: [ self signalCanNotAddAccount ].
	
	anAccount addedTo: self.
	accounts add: anAccount.! !

!Portfolio methodsFor: 'accessing' stamp: 'VA 10/19/2023 13:32:39'!
addedTo: aPortfolio
	parents add: aPortfolio.! !

!Portfolio methodsFor: 'accessing' stamp: 'VA 10/18/2023 11:39:01'!
hasRegistered: aTransaction
	^ accounts anySatisfy:[:anAccount | anAccount hasRegistered: aTransaction ].! !

!Portfolio methodsFor: 'accessing' stamp: 'VA 10/19/2023 16:25:00'!
isOrAccountsIncludes: anAccount

	^ (accounts anySatisfy: [ :anElement |
		(((anElement isOrAccountsIncludes: anAccount ) 
	or: [ self = anAccount ]) 
	or: [ anAccount isOrAccountsIncludes: anElement ])])
	 or: [
		parents
			ifEmpty: [ ^ false ]
			ifNotEmpty: [
				parents anySatisfy: [ :aParent |
					(aParent isOrAccountsIncludes: anAccount) ]]].
	! !

!Portfolio methodsFor: 'accessing' stamp: 'VA 10/19/2023 13:24:20'!
isOrIncludesThisAccount: anAccount

	^ (self accounts includes: anAccount)! !

!Portfolio methodsFor: 'accessing' stamp: 'VA 10/19/2023 13:13:03'!
signalCanNotAddAccount

	^ self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'transactions' stamp: 'VA 10/18/2023 18:53:07'!
addTransactionsTo: aTransactionsList
	accounts do: [ :anAccount | anAccount addTransactionsTo: aTransactionsList ].! !

!Portfolio methodsFor: 'transactions' stamp: 'VA 10/18/2023 18:51:26'!
transactions
	| transactions |
	transactions := OrderedCollection new.
	accounts do:[:anAccount | anAccount addTransactionsTo: transactions ].
	^transactions .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'VA 10/19/2023 13:11:47'!
canNotAddAccountErrorMessage
	^'No se puede agregar cuenta que ya se encuentra en el portfolio '! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'VA 10/18/2023 18:54:01'!
addTransactionsTo: aTransactionsList

	aTransactionsList addAll: transactions.
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'VA 10/19/2023 15:33:46'!
isOrAccountsIncludes: anAccount
	^self = anAccount ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'VA 10/16/2023 21:08:13'!
balance
	
	^transactions inject: 0 into: [:temporalBalance :aTransaction | aTransaction affectBalance: temporalBalance ].
	! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'VA 10/19/2023 13:10:38'!
addedTo: aPortfolio
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'VA 10/16/2023 21:13:57'!
affectBalance: aBalance

	self subclassResponsibility! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'VA 10/16/2023 21:16:13'!
affectBalance: aBalance
	^aBalance + value .! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'VA 10/16/2023 21:16:18'!
affectBalance: aBalance
	^ aBalance - value .! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
