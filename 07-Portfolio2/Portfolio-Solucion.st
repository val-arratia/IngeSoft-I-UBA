!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #PortfolioTreeReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTreeReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:43:26'!
test01PortfolioTreeReportShowsPortfolioName
    | treereport portfolio expectedReport |
    portfolio := Portfolio withName: 'Portfolio individual'.
    treereport := PortfolioTreeReport of: portfolio.
		expectedReport := OrderedCollection new.
	expectedReport add:'Portfolio individual'.
    self assert:  expectedReport equals: treereport report.! !

!PortfolioTreeReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:40:34'!
test02PortfolioTreeReportShowsItsAccountsCorrectly
    | treereport portfolio account expectedReport |
    account := ReceptiveAccount withName: 'Cuenta Mia'.
    portfolio := Portfolio withName: 'Portfolio individual' with: account .
    treereport := PortfolioTreeReport of: portfolio.
	expectedReport := OrderedCollection new.
	expectedReport add:'Portfolio individual'.
	expectedReport add: '    ','Cuenta Mia'.
	
    self
        assert: expectedReport 
        equals: treereport report.! !

!PortfolioTreeReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:42:27'!
test03PortfolioTreeReportShowsItsAccountsAndPortfoliosCorrectly
    | treereport portfolio account anotherPortfolio expectedReport |
    account := ReceptiveAccount withName: 'Cuenta Mia'.
    anotherPortfolio :=Portfolio withName: 'Portfolio de Hijos'.
    portfolio := Portfolio withName: 'Portfolio de Familia' with: account with: anotherPortfolio .
    treereport := PortfolioTreeReport of: portfolio.
expectedReport := OrderedCollection new.
	expectedReport add:'Portfolio de Familia'.
	expectedReport add: '    ','Cuenta Mia'.
	expectedReport add: '    ', 'Portfolio de Hijos'.
	
    self
        assert: expectedReport
        equals: treereport report.! !

!PortfolioTreeReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:37:36'!
test04PortfolioTreeReportShowsItsAllItsAccountsAndPortfoliosCorrectly
    | treereport portfolio  expectedReport account anotherAccount anotherAccountToAdd anotherPortfolio |
    account := ReceptiveAccount withName: 'Cuenta Mia'.
    anotherAccount :=ReceptiveAccount withName:'Cuenta de Juan'.
    anotherAccountToAdd :=ReceptiveAccount withName:'Cuenta de Angeles'.
    anotherPortfolio :=Portfolio withName: 'Portfolio de Hijos' with: anotherAccount with: anotherAccountToAdd .
    portfolio := Portfolio withName: 'Portfolio de Familia' with: account with: anotherPortfolio .
    treereport := PortfolioTreeReport of: portfolio.
   
    expectedReport := OrderedCollection new.
	expectedReport add:'Portfolio de Familia'.
	expectedReport add: '    ','Cuenta Mia'.
	expectedReport add: '    ', 'Portfolio de Hijos'.
	expectedReport add: '        ','Cuenta de Juan'.
	expectedReport add: '        ','Cuenta de Angeles'.
        self assert: expectedReport equals: treereport report ! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #SummaryReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #SummaryReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:51:33'!
test01ReceptiveAccountEmptyHasBalanceZeroInSummaryReport
	| account summary |
	account := ReceptiveAccount new.
	summary := AccountSummary of: account .
	
	self assert:  'Balance = 0' equals: summary report.
	
	
! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:51:56'!
test02AccountWithDepositShowsInSummaryReport
	| account summary |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account .
	summary := AccountSummary of: account .
	
	self assert: 'Depósito por 100.' ,'Balance = 100' equals: summary report.
	
	
! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:52:09'!
test03AccountWithDepositAndWithdrawShowsInSummaryReport
	| account summary |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account .
	Withdraw register: 50 on: account .
	summary := AccountSummary of: account.
	self assert: 'Depósito por 100.' , 'Extracción por 50.' ,'Balance = 50' equals: summary report.
	
	
! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:52:23'!
test04AccountWithDepositAndWithdrawAndEntryTransferShowsInSummaryReport
	| account destinationAccount summary |
	account := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Deposit register: 100 on: account .
	Withdraw register: 50 on: account .
	Transfer from: account  to:  destinationAccount withAmount: 20.
	summary := AccountSummary of: account.
	self assert: 'Depósito por 100.' , 'Extracción por 50.', 'Salida por transferencia de 20.' ,'Balance = 30' equals: summary report.
	
	
! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:53:15'!
test05AccountWithDepositAndWithdrawAndEntryTransferAndExitTransferShowsInSummaryReport
	| account destinationAccount sourceAccount summary |
	account := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	sourceAccount := ReceptiveAccount new.
	Deposit register: 100 on: account .
	Withdraw register: 50 on: account .
	Transfer from: account  to:  destinationAccount withAmount: 20.
	Transfer from: sourceAccount  to: account withAmount: 30.
	summary := AccountSummary of: account .
	self assert: 'Depósito por 100.' , 'Extracción por 50.', 'Salida por transferencia de 20.', 'Entrada por transferencia de 30.'  ,'Balance = 60' equals: summary report.
	
	
! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:54:03'!
test06EmptyPortfolioHasBalanceZeroInSummaryReport
	| summary portfolio |
	
	portfolio:= Portfolio new. 
	summary := AccountSummary of: portfolio.
	self
		assert: 'Balance = 0'
		equals: summary report.! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:54:17'!
test07PortfolioWithAccountShowsCorrectTransactions
	| summary portfolio account |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account .
	portfolio := Portfolio with: account.
	summary := AccountSummary of: portfolio.
	self
		assert: 'Depósito por 100.' ,'Balance = 100'
		equals: summary report.! !

!SummaryReportTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 12:38:26'!
test08ReportOfPortfolioWithManyAccounts
	| summary portfolio account anotherAccount |
	account := ReceptiveAccount new.
	Deposit
		register: 100
		on: account.
	anotherAccount := ReceptiveAccount new.
	Deposit
		register: 1000
		on: account.
	Withdraw register: 500 on: anotherAccount .
	portfolio := Portfolio with: account with: anotherAccount .
	summary := AccountSummary of: portfolio.
	self
		assert: 'Depósito por 100.' ,'Depósito por 1000.','Extracción por 500.', 'Balance = 600'
		equals: summary report.! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:49:42'!
test01EmptyReceptiveAccountHas0TotalNet
	| account totalNet|
	
	account := ReceptiveAccount new.
	
	totalNet := TransferNet of: account.
	
	self assert:  0 equals: totalNet report.
	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:49:53'!
test02AccountWithOneIncomingTransferComputesTotalNet
	| sourceAccount destinationAccount totalNet|
	
	sourceAccount := ReceptiveAccount new.	
	destinationAccount := ReceptiveAccount new.
	
	Transfer from: sourceAccount  to:  destinationAccount withAmount: 20.

	totalNet := TransferNet of: destinationAccount.
	
	self assert: 20 equals: totalNet report.
	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:50:15'!
test03AccountWithOneIncomingAndExitTransferComputesTotalNet
	| sourceAccount destinationAccount totalNet|
	
	sourceAccount := ReceptiveAccount new.	
	destinationAccount := ReceptiveAccount new.
	
	Transfer from: sourceAccount  to:  destinationAccount withAmount: 20.
	Transfer from: destinationAccount  to:  sourceAccount withAmount: 5.
	totalNet := TransferNet of: destinationAccount.
	
	self assert: 15 equals: totalNet report.
	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:50:29'!
test04DepositAndWithdrawDoesntAffectTotalNet
	| sourceAccount destinationAccount totalNet|
	
	sourceAccount := ReceptiveAccount new.	
	destinationAccount := ReceptiveAccount new.
	
	Transfer from: sourceAccount  to: destinationAccount withAmount: 20.
	Transfer from: destinationAccount  to:  sourceAccount withAmount: 5.
	Deposit register: 100 on: destinationAccount .
	Withdraw register: 50 on: destinationAccount .
	
	totalNet := TransferNet of: destinationAccount.
	
	self assert: 15 equals: totalNet report.
	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:46:36'!
test05EmptyPortfolioHas0TotalNet
    | portfolio totalNet|

    portfolio := Portfolio new.

    totalNet := TransferNet of: portfolio.

    self assert: 0 equals: totalNet report.
	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:46:54'!
test06PortfolioWithOneReceptiveAccountComputesTotalNetForOneTransfer
    | portfolio sourceAccount destinationAccount totalNet|

    sourceAccount := ReceptiveAccount new.
    destinationAccount := ReceptiveAccount new.
    portfolio := Portfolio with: destinationAccount.

    Transfer from: sourceAccount  to: destinationAccount withAmount: 20.
    Transfer from: destinationAccount  to:  sourceAccount withAmount: 5.

    totalNet := TransferNet of: portfolio.

    self assert: 15 equals: totalNet report. 

	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:47:15'!
test07PortfolioWithPortfolioWithReceptiveAccountComputesTotalNetForOneTransfer
    | portfolio anotherPortfolio sourceAccount destinationAccount totalNet|

    sourceAccount := ReceptiveAccount new.
    destinationAccount := ReceptiveAccount new.
    portfolio := Portfolio with: destinationAccount.
    anotherPortfolio := Portfolio with: portfolio. 

    Transfer from: sourceAccount  to: destinationAccount withAmount: 20.
    Transfer from: destinationAccount  to:  sourceAccount withAmount: 5.

    totalNet := TransferNet of: anotherPortfolio.

    self assert: 15 equals: totalNet report
	! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 16:51:21'!
test01AccountsOfTransferHaveCorrectBalance
	|transfer destinationAccount sourceAccount amount|
	destinationAccount := ReceptiveAccount new.
	sourceAccount := ReceptiveAccount new.
	amount := 100.

	transfer := Transfer from: sourceAccount to: destinationAccount withAmount: amount.

	self assert: -100 equals: sourceAccount balance.
	self assert: 100 equals: destinationAccount balance.
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'VA 10/24/2023 14:01:49'!
test02AccountsOfTransferHasRegisteredTransfer
	|transfer destinationAccount sourceAccount amount|
	destinationAccount := ReceptiveAccount new.
	sourceAccount := ReceptiveAccount new.
	amount := 100.

	transfer := Transfer from: sourceAccount to: destinationAccount withAmount: amount.

	self assert: (sourceAccount hasRegistered: transfer sourceLeg).
	self assert: (destinationAccount hasRegistered: transfer destinationLeg ).	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'VA 10/24/2023 14:25:05'!
test03TransferCanNavigateBetweenLegs
	|transfer destinationAccount sourceAccount amount|
	destinationAccount := ReceptiveAccount new.
	sourceAccount := ReceptiveAccount new.
	amount := 100.

	transfer := Transfer from: sourceAccount to: destinationAccount withAmount: amount.

	self assert: transfer sourceLeg navigate equals: transfer destinationLeg .
	self assert: transfer destinationLeg navigate equals: transfer sourceLeg .! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'VA 10/24/2023 15:57:06'!
test04CanNotTransferAZeroAmount
	|destinationAccount sourceAccount amount|
	destinationAccount := ReceptiveAccount new.
	sourceAccount := ReceptiveAccount new.
	amount := 0.

	self should: [Transfer from: sourceAccount to: destinationAccount withAmount: amount.]
	raise: Error
	withExceptionDo:[:anError | anError messageText = Transfer invalidAmountToTransferErrorMessage.]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'VA 10/24/2023 15:57:41'!
test05CanNotTransferANegativeAmount
	|destinationAccount sourceAccount amount|
	destinationAccount := ReceptiveAccount new.
	sourceAccount := ReceptiveAccount new.
	amount := -100.

	self should: [Transfer from: sourceAccount to: destinationAccount withAmount: amount.]
	raise: Error
	withExceptionDo:[:anError | anError messageText = Transfer invalidAmountToTransferErrorMessage.]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 12:45:09'!
test06CanNotTransferWithinSameAccount
	| destinationAndSourceAccount amount |
	destinationAndSourceAccount := ReceptiveAccount new.
	amount := 100.
	self
		should: [
			Transfer
				from: destinationAndSourceAccount
				to: destinationAndSourceAccount
				withAmount: amount ]
		raise: Error
		withExceptionDo: [ :anError |
			anError messageText = Transfer invalidTransferErrorMessage ].! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name account anotherAccount_CHANGE_ME'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'VA 10/26/2023 15:20:10'!
accounts
	
	^accounts! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'VA 10/26/2023 15:09:01'!
initializeWithName: aName 
	
	name := aName.! !

!Portfolio methodsFor: 'initialization' stamp: 'VA 10/26/2023 15:24:54'!
initializeWithName: aName with: anAccount 
	
	name := aName.
	accounts add:anAccount.! !

!Portfolio methodsFor: 'initialization' stamp: 'VA 10/26/2023 15:38:12'!
initializeWithName: aName with: anAccount with: anotherAccount 
	name := aName.
	accounts add: anAccount.
	accounts add: anotherAccount.! !

!Portfolio methodsFor: 'initialization' stamp: 'VA 10/26/2023 15:22:52'!
name
	^name! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'report' stamp: 'VA 10/26/2023 15:05:31'!
addTransactionToReport: aReport
	accounts do: [ :anAccount |
		anAccount addTransactionToReport: aReport ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'class initialization' stamp: 'VA 10/26/2023 15:08:53'!
withName: aName
	^self new initializeWithName:aName .! !

!Portfolio class methodsFor: 'class initialization' stamp: 'VA 10/26/2023 15:12:32'!
withName: aName with: anAccount 
	^self new initializeWithName: aName with:anAccount! !

!Portfolio class methodsFor: 'class initialization' stamp: 'VA 10/26/2023 15:37:46'!
withName: aName with: anAccount with: anotherAccount
	^self new initializeWithName:aName with: anAccount with: anotherAccount .! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'VA 10/26/2023 15:12:03'!
initializeWithName: aName 
	
	name := aName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'VA 10/26/2023 14:53:28'!
addTransactionToReport: aReport
	transactions do: [ :aTransaction |
		aTransaction isReportedIn: aReport ].! !

!ReceptiveAccount methodsFor: 'report' stamp: 'SG 10/26/2023 14:26:28'!
computeTransactionsForTransferNet: aTransferNet
	
	transactions do: [ :aTransaction | aTransaction isReportedInForNet: aTransferNet .].
	
! !

!ReceptiveAccount methodsFor: 'report' stamp: 'VA 10/25/2023 20:00:59'!
summaryReport
	| report |
	report := OrderedCollection new.
	transactions do: [ :aTransaction | 
		(aTransaction isKindOf: Deposit) ifTrue: [ report addLast: 'Depósito por ' , aTransaction value asString , '.' ].
		(aTransaction isKindOf: Withdraw) ifTrue: [ report addLast: 'Extracción por ' , aTransaction value asString , '.' ].
		(aTransaction isKindOf: TransferSourceLeg) ifTrue: [ report addLast: 'Salida por transferencia de ' , aTransaction value asString , '.' ].
		(aTransaction isKindOf: TransferDestinationLeg) ifTrue: [ report addLast: 'Entrada por transferencia de ' , aTransaction value asString , '.' ]].
	report add: 'Balance = ' , self balance asString.
	^ report fold: [ :currentString :nextString |
		currentString , nextString ].! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 15:31:40'!
name 
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'class initialization' stamp: 'VA 10/26/2023 15:11:55'!
withName: aName
	^self new initializeWithName: aName ! !


!classDefinition: #AccountReport category: 'Portfolio-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReport methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 15:05:59'!
initializeOf: anAccount
	self subclassResponsibility.! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 15:07:03'!
reporstAPorfolio: aPortfolio
	self subclassResponsibility.! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 14:56:37'!
report
	self subclassResponsibility ! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 15:06:33'!
reportsADeposit: aDeposit
	self subclassResponsibility.! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 15:06:45'!
reportsAWithdraw: aWithdraw
	self subclassResponsibility.! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'VA 10/26/2023 15:03:03'!
initializeOf: anAccount
	account := anAccount.
	report := OrderedCollection new.! !


!AccountSummary methodsFor: 'report' stamp: 'VA 10/26/2023 11:46:14'!
reporstAPorfolio: aPortfolio 
	^report ! !

!AccountSummary methodsFor: 'report' stamp: 'VA 10/26/2023 14:57:18'!
report
	account addTransactionToReport: self.
	report add: 'Balance = ' , account balance asString.
	^ report fold: [ :currentString :nextString |
		currentString , nextString ].! !

!AccountSummary methodsFor: 'report' stamp: 'VA 10/26/2023 11:07:09'!
reportsADeposit: aDeposit
	report add: 'Depósito por ' , aDeposit value asString , '.'.! !

!AccountSummary methodsFor: 'report' stamp: 'VA 10/26/2023 11:11:49'!
reportsATransferDestinationAccount: aTransferDestinationLeg 
	report add:  'Entrada por transferencia de ' , aTransferDestinationLeg value asString , '.'! !

!AccountSummary methodsFor: 'report' stamp: 'VA 10/26/2023 11:10:01'!
reportsATransferSourceAccount: aTransferSourceLeg 
	report add: 'Salida por transferencia de ' , aTransferSourceLeg value asString , '.'! !

!AccountSummary methodsFor: 'report' stamp: 'VA 10/26/2023 11:07:02'!
reportsAWithdraw: aWithdraw 
	report add: 'Extracción por ' , aWithdraw value asString , '.'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'class initialization' stamp: 'VA 10/26/2023 15:03:04'!
of: anAccount 
	^self new initializeOf: anAccount.! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
AccountReport subclass: #TransferNet
	instanceVariableNames: 'account receptiveAccount totalNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'SG 10/26/2023 14:16:16'!
initializeOf: aReceptiveAccount 
	account := aReceptiveAccount.
	totalNet := 0.! !


!TransferNet methodsFor: 'accessing' stamp: 'VA 10/26/2023 14:57:32'!
report
	account addTransactionToReport: self.
	^ totalNet.! !

!TransferNet methodsFor: 'accessing' stamp: 'VA 10/26/2023 14:59:38'!
reportsADeposit: aDeposit 
	^self! !

!TransferNet methodsFor: 'accessing' stamp: 'VA 10/26/2023 15:02:14'!
reportsATransferDestinationAccount: aTransferLeg
	totalNet := totalNet + aTransferLeg value.! !

!TransferNet methodsFor: 'accessing' stamp: 'VA 10/26/2023 15:02:00'!
reportsATransferSourceAccount: aTransferLeg
	totalNet := totalNet - aTransferLeg value.
! !

!TransferNet methodsFor: 'accessing' stamp: 'VA 10/26/2023 14:59:56'!
reportsAWithdraw: aWithdraw 
	^self! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'SG 10/26/2023 13:48:12'!
of: aReceptiveAccount 
	^self new initializeOf: aReceptiveAccount ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'VA 10/26/2023 14:58:33'!
isReportedIn: aReport
	aReport reportsADeposit: self.! !

!Deposit methodsFor: 'report' stamp: 'VA 10/26/2023 14:51:18'!
isReportedInForNet: aTransferNet
	^ aTransferNet reportsADepositForNet: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Transfer
	instanceVariableNames: 'sourceAccount destinationAccount amount destinationLeg sourceLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'VA 10/26/2023 12:46:17'!
initializeFrom: aSourceAccount to: aDestinationAccount withAmount: anAmount
	destinationLeg := TransferDestinationLeg of: self.
	sourceLeg := TransferSourceLeg of: self.
	anAmount <= 0 ifTrue: [ self signalInvalidAmountToTransfer ].
	 (aSourceAccount = aDestinationAccount) ifTrue: [self signalInvalidTransfer].
	amount := anAmount.
	self
		performTransferFrom: aSourceAccount
		to: aDestinationAccount.! !

!Transfer methodsFor: 'initialization' stamp: 'VA 10/24/2023 15:56:39'!
signalInvalidAmountToTransfer

	^ self error:self class invalidAmountToTransferErrorMessage! !

!Transfer methodsFor: 'initialization' stamp: 'VA 10/26/2023 12:46:55'!
signalInvalidTransfer
	   ^ self error:self class invalidTransferErrorMessage! !


!Transfer methodsFor: 'transaction' stamp: 'VA 10/24/2023 14:25:34'!
navigate
	self subclassResponsibility ! !

!Transfer methodsFor: 'transaction' stamp: 'VA 10/24/2023 14:01:35'!
performTransferFrom: aSourceAccount to: aDestinationAccount 
	aSourceAccount register: self sourceLeg .
	aDestinationAccount register: self destinationLeg.! !


!Transfer methodsFor: 'accessing' stamp: 'VA 10/24/2023 12:57:33'!
destinationLeg
	^destinationLeg .! !

!Transfer methodsFor: 'accessing' stamp: 'VA 10/24/2023 12:57:42'!
sourceLeg
	^sourceLeg .! !

!Transfer methodsFor: 'accessing' stamp: 'VA 10/25/2023 01:00:43'!
value
	^amount .! !


!Transfer methodsFor: 'balance' stamp: 'VA 10/24/2023 14:00:47'!
affectBalance: aTemporalBalance

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'class initialization' stamp: 'VA 10/20/2023 23:09:57'!
from: aSourceAccount to: aDestinationAccount withAmount: anAmount 
	^self new initializeFrom: aSourceAccount to: aDestinationAccount withAmount: anAmount .! !

!Transfer class methodsFor: 'class initialization' stamp: 'VA 10/24/2023 14:36:28'!
invalidAmountToTransferErrorMessage
	^'Cantidad a transferir invalida'! !


!Transfer class methodsFor: 'error messages' stamp: 'VA 10/26/2023 12:41:55'!
invalidTransferErrorMessage
	 ^'No se puede transferir dentro de la misma cuenta'! !


!classDefinition: #TransferDestinationLeg category: 'Portfolio-Solucion'!
Transfer subclass: #TransferDestinationLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDestinationLeg methodsFor: 'initialization' stamp: 'VA 10/24/2023 12:36:34'!
initializeWith: aTransfer 
	
	transfer := aTransfer.! !


!TransferDestinationLeg methodsFor: 'balance' stamp: 'VA 10/25/2023 00:48:42'!
affectBalance: aTemporalBalance
	^ aTemporalBalance + transfer value.! !


!TransferDestinationLeg methodsFor: 'transaction' stamp: 'VA 10/24/2023 14:26:50'!
navigate
	^transfer sourceLeg .! !


!TransferDestinationLeg methodsFor: 'accessing' stamp: 'VA 10/25/2023 01:00:23'!
value
	^transfer value.! !


!TransferDestinationLeg methodsFor: 'report' stamp: 'VA 10/26/2023 11:11:15'!
isReportedIn: anAccountSummary 
	anAccountSummary reportsATransferDestinationAccount: self.! !

!TransferDestinationLeg methodsFor: 'report' stamp: 'SG 10/26/2023 14:29:52'!
isReportedInForNet: aTransferNet
	aTransferNet reportsAnIncomingTransferForNet: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDestinationLeg class' category: 'Portfolio-Solucion'!
TransferDestinationLeg class
	instanceVariableNames: ''!

!TransferDestinationLeg class methodsFor: 'class initialization' stamp: 'VA 10/24/2023 12:36:19'!
of: aTransfer 
	^self new initializeWith: aTransfer .! !


!classDefinition: #TransferSourceLeg category: 'Portfolio-Solucion'!
Transfer subclass: #TransferSourceLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferSourceLeg methodsFor: 'initialization' stamp: 'VA 10/24/2023 12:39:56'!
initializeWith: aTransfer 
	
	transfer := aTransfer.! !


!TransferSourceLeg methodsFor: 'balance' stamp: 'VA 10/25/2023 00:48:24'!
affectBalance: aTemporalBalance 
	^aTemporalBalance - transfer value.! !


!TransferSourceLeg methodsFor: 'transaction' stamp: 'VA 10/24/2023 14:26:32'!
navigate
	^transfer destinationLeg ! !


!TransferSourceLeg methodsFor: 'accessing' stamp: 'VA 10/25/2023 01:00:34'!
value
	^ transfer value.! !


!TransferSourceLeg methodsFor: 'as yet unclassified' stamp: 'VA 10/26/2023 11:09:28'!
isReportedIn: anAccountSummary 
	anAccountSummary reportsATransferSourceAccount: self.! !

!TransferSourceLeg methodsFor: 'as yet unclassified' stamp: 'SG 10/26/2023 14:32:46'!
isReportedInForNet: aTransferNet
	aTransferNet reportsAnExitTransferForNet: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferSourceLeg class' category: 'Portfolio-Solucion'!
TransferSourceLeg class
	instanceVariableNames: ''!

!TransferSourceLeg class methodsFor: 'class initialization' stamp: 'VA 10/24/2023 12:39:47'!
of: aTransfer 
	^self new initializeWith: aTransfer .! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report' stamp: 'VA 10/26/2023 11:06:01'!
isReportedIn: anAccountSummary 
	anAccountSummary reportsAWithdraw: self.! !

!Withdraw methodsFor: 'report' stamp: 'VA 10/26/2023 14:51:39'!
isReportedInForNet: aTransferNet
	^aTransferNet reportsAWithdrawForNet: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioTreeReport category: 'Portfolio-Solucion'!
Object subclass: #PortfolioTreeReport
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeReport methodsFor: 'initialization' stamp: 'VA 10/26/2023 15:09:44'!
initializeOf: aPortfolio 
	
	portfolio := aPortfolio.! !


!PortfolioTreeReport methodsFor: 'report' stamp: 'VA 10/26/2023 16:33:59'!
report
	| treeReport |
	treeReport := OrderedCollection new.
	treeReport add: portfolio name.
	portfolio accounts do: [ :anAccount |
		(anAccount isKindOf: ReceptiveAccount)
			ifTrue: [ treeReport add: '    ' , anAccount name ]
			ifFalse: [
				(PortfolioTreeReport of: anAccount) report do: [ :stringReport |
					treeReport add: '    ' , stringReport ]]].
	^ treeReport ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreeReport class' category: 'Portfolio-Solucion'!
PortfolioTreeReport class
	instanceVariableNames: ''!

!PortfolioTreeReport class methodsFor: 'class initialization' stamp: 'VA 10/26/2023 15:09:27'!
of: aPortfolio 
	^self new initializeOf: aPortfolio .! !
