!classDefinition: #TDDBabyStepsAnagramsTest category: 'TDDBabyStepsGameAnagrams'!
TestCase subclass: #TDDBabyStepsAnagramsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGameAnagrams'!

!TDDBabyStepsAnagramsTest methodsFor: 'tests' stamp: 'sg 10/2/2023 18:59:56'!
test01EmptyStringAnagramIsJustACollectionWithTheEmptyString

	self assert: (Set with: '') equals: '' anagrams
	! !

!TDDBabyStepsAnagramsTest methodsFor: 'tests' stamp: 'sg 10/2/2023 19:06:55'!
test02OneCharStringAnagramReturnsACollectionWithTheSameOneCharString

	self assert: (Set with:'a') equals: 'a' anagrams
	! !

!TDDBabyStepsAnagramsTest methodsFor: 'tests' stamp: 'sg 10/2/2023 19:10:17'!
test03TwoCharStringAnagramReturnsTheOriginalStringAndAnotherOneFlipped

	self assert: (Set with:'ab' with: 'ba') equals: 'ab' anagrams
	! !

!TDDBabyStepsAnagramsTest methodsFor: 'tests' stamp: 'sg 10/2/2023 19:26:28'!
test04ThreeCharStringAnagramReturnsAllThe6PossibleOrderCombinations

	| anagrams |
	
	anagrams := Set new.
	anagrams add: 'abc'.
	anagrams add: 'acb'.
	anagrams add: 'bac'.
	anagrams add: 'bca'.
	anagrams add: 'cab'.
	anagrams add: 'cba'.

	self assert: anagrams equals: 'abc' anagrams
	! !
