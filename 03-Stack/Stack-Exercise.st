!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptyStack stackWithFourSentences sentenceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 16:37:00'!
assertThatPrefix: aPrefix onStack: aStack raisesErrorWithDescription: anErrorDescription
	self
		should: [
			sentenceFinder 
				findSentenceWithPrefix: aPrefix
				inStack: aStack ]
		raise: Error
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: anErrorDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 15:03:00'!
setUp
	emptyStack := OOStack new..
	sentenceFinder := SentenceFinderByPrefix new.
	stackWithFourSentences := OOStack new.
	stackWithFourSentences push: 'winter is coming'.
	stackWithFourSentences push: 'winning is everything'.
	stackWithFourSentences push: 'The winds of Winter'.
	stackWithFourSentences push: 'Winter is here'.	! !


!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'v 9/18/2023 15:43:44'!
assertThat: aStack hasSameOrderAndElementsThan: anotherStack
	aStack size timesRepeat: [self assert: aStack pop = anotherStack pop]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'v 9/18/2023 12:40:59'!
test01PrefixCanNotBeEmpty
	self assertThatPrefix: ''		onStack: emptyStack 		raisesErrorWithDescription: SentenceFinderByPrefix emptyPrefixErrorDescription.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'v 9/18/2023 12:45:33'!
test02PrefixCanNotHaveWhitespaces
	self assertThatPrefix: 'Win t'		onStack: emptyStack 		raisesErrorWithDescription: SentenceFinderByPrefix whitespaceInPrefixErrorDescription .! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'v 9/18/2023 16:51:56'!
test03SentenceFinderFindsCorrectSentenceWithThePrefix

	| foundSentences  |
	foundSentences := sentenceFinder findSentenceWithPrefix: 'Wint' inStack: stackWithFourSentences.
	
	self assert: foundSentences size equals: 1.
	self assert: foundSentences includes: 'Winter is here'.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'v 9/18/2023 16:52:33'!
test04SentenceFinderFindsMoreThanOneSentenceWithThePrefixAndStackKeepsHisOrderAndElements

	| foundSentences sentencesToFind  stackWithFourSentencesAtTheBeggining |
	stackWithFourSentencesAtTheBeggining := stackWithFourSentences .
	sentencesToFind := OrderedCollection new	 add: 'winning is everything'; add:'winter is coming'; yourself.
	foundSentences := sentenceFinder findSentenceWithPrefix: 'win' inStack: stackWithFourSentences.
	
	self assert: foundSentences size equals: 2.
	self assert: foundSentences equals: sentencesToFind.
	"self assertThat: stackWithFourSentences hasSameOrderAndElementsThan: stackWithFourSentencesAtTheBeggining"! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'v 9/18/2023 16:45:18'!
test05SentenceFinderDoesNotFindSentenceInEmptyStack
	| foundSentences |

	foundSentences := sentenceFinder findSentenceWithPrefix: 'Wint' inStack: emptyStack .
	self assert: foundSentences isEmpty.
	self assert: emptyStack isEmpty.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topComponent size base'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 01:21:06'!
initialize
	base := OOStackBase new initializeWithStack: self.
	topComponent := base.
	size := 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 00:56:29'!
isEmpty
	^size=0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 10:56:58'!
pop
	| previousTopComponent|
	previousTopComponent := topComponent.
	topComponent := topComponent previousComponent.
	size:= size - 1.
	^previousTopComponent value.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 00:48:16'!
push: anElement
	|elementToPush|
	elementToPush := OOStackElement new initializeWithElement: anElement andWithPreviousComponent: topComponent.
	topComponent := elementToPush.
	size:=size+1.
	
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 01:39:17'!
signalStackEmptyErrorDescription
	^ self error: self class stackEmptyErrorDescription .! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 00:44:43'!
size
	^size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 01:17:25'!
top
	^topComponent value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackComponent category: 'Stack-Exercise'!
Object subclass: #OOStackComponent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStackComponent subclass: #OOStackBase
	instanceVariableNames: 'theStackWithThisBase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 01:15:08'!
initializeWithStack: anEmptyStack

	theStackWithThisBase := anEmptyStack.! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 11:00:06'!
previousComponent
	theStackWithThisBase signalStackEmptyErrorDescription.! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 01:38:36'!
value
	theStackWithThisBase signalStackEmptyErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackBase class' category: 'Stack-Exercise'!
OOStackBase class
	instanceVariableNames: ''!

!OOStackBase class methodsFor: 'as yet unclassified' stamp: 'v 9/17/2023 21:57:51'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
OOStackComponent subclass: #OOStackElement
	instanceVariableNames: 'value previousComponent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 01:33:09'!
initializeWithElement: anElement andWithPreviousComponent: aComponent
	previousComponent := aComponent.
	value := anElement.! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 01:40:11'!
previousComponent
	^ previousComponent.! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'v 9/18/2023 01:17:43'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: 'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'as yet unclassified' stamp: 'v 9/17/2023 22:08:33'!
With: value
	^self new initializeWith: value.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'signal' stamp: 'v 9/18/2023 16:31:57'!
signalPrefixCannotBeEmpty
	self error: self class emptyPrefixErrorDescription 
	

	
	! !

!SentenceFinderByPrefix methodsFor: 'signal' stamp: 'v 9/18/2023 16:31:54'!
signalPrefixCannotHaveWhitespace
	self error: self class whitespaceInPrefixErrorDescription 
	
	

	
	! !


!SentenceFinderByPrefix methodsFor: 'finder' stamp: 'v 9/18/2023 16:25:13'!
findSentenceWithPrefix: aPrefix inStack: aStack
	
	| auxiliarStack collectionWithSentencesWithPrefix |
	
	self preconditionsOfThePrefix: aPrefix.
	
	auxiliarStack := OOStack new.
	collectionWithSentencesWithPrefix:= OrderedCollection new.
	
	self popAllElementsFrom: aStack to: auxiliarStack andAddSentenceWithPrefix: aPrefix ToCollection:collectionWithSentencesWithPrefix.
	self popAllElementsFrom: auxiliarStack to: aStack.
	
	^ collectionWithSentencesWithPrefix 
	! !


!SentenceFinderByPrefix methodsFor: 'auxiliar' stamp: 'v 9/18/2023 16:16:50'!
popAllElementsFrom: aStack to: anotherStack

	| sentence |
	[aStack isEmpty ] whileFalse: [
		sentence := aStack pop.
		anotherStack push: sentence.
		].

	
	! !

!SentenceFinderByPrefix methodsFor: 'auxiliar' stamp: 'v 9/18/2023 16:22:00'!
popAllElementsFrom: aStack to: anotherStack andAddSentenceWithPrefix: aPrefix ToCollection: aCollection

	| aSentence |
	[aStack isEmpty ] whileFalse: [
		aSentence := aStack pop.
		(aSentence beginsWith: aPrefix) ifTrue: [ aCollection add: aSentence].
		anotherStack push: aSentence.
		].

	
	! !

!SentenceFinderByPrefix methodsFor: 'auxiliar' stamp: 'v 9/18/2023 12:23:54'!
preconditionsOfThePrefix: aPrefix.
	
	(aPrefix = '' ) ifTrue: [self signalPrefixCannotBeEmpty] .
	(aPrefix includesSubString: ' ' ) ifTrue: [self signalPrefixCannotHaveWhitespace] .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'v 9/18/2023 09:40:08'!
emptyPrefixErrorDescription
	^ 'The prefix can not be empty '.! !

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'v 9/18/2023 09:52:50'!
whitespaceInPrefixErrorDescription
	^ 'Can not have a whitespace in the prefix'.! !
