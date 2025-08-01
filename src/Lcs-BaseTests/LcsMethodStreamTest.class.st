Class {
	#name : #LcsMethodStreamTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-BaseTests-Tests'
}

{ #category : #test }
LcsMethodStreamTest >> testCreateEmptySelectorSourceCode [
	self subject: LcsMethodStream new.
	self subject startMethodSource: 'testMethod'.
	self assert: subject indentLevel equals: 1.
	self assert: self subject contents equals: 'testMethod'
]

{ #category : #test }
LcsMethodStreamTest >> testCreateSlotDefinitionSelectorSourceCode [
	self subject: LcsMethodStream new.
	self subject startSlotDefintionSource: 'testMethod'.
	self assert: subject indentLevel equals: 1.
	self assert: self subject contents equals: 
'testMethod
	<slotDefinition>'
]

{ #category : #test }
LcsMethodStreamTest >> testCreateSlotDefinitionSelectorSourceCodeWithBuilderClass [
	self subject: LcsMethodStream new.
	self subject startSlotDefintionSource: 'testMethod'.
	self subject addSlotDefinitionClassCreatonLine: 'LcsStringSlot'.
	self assert: subject indentLevel equals: 2.
	self assert: self subject contents equals: 
'testMethod
	<slotDefinition>
	^ LcsStringSlot new'
]

{ #category : #test }
LcsMethodStreamTest >> testCreation [
	self subject: LcsMethodStream new.
	self assert: self subject indentLevel equals: 0.
	self assert: (self subject stream isKindOf: WriteStream).
	self assert: self subject stream isEmpty.
	self assert: self subject contents equals: ''
]

{ #category : #test }
LcsMethodStreamTest >> testKeywordArgumentKeywordArgumentMessage [
	self subject: LcsMethodStream new.
	self assert: self subject stream isEmpty.
	self subject addKeyword: 'test' argument: '''aValue1''' keyword: 'test' argument: '''aValue2'''.
	self assert: subject contents equals: 'test: ''aValue1'' test: ''aValue2'';'
]

{ #category : #test }
LcsMethodStreamTest >> testKeywordArgumentMessage [
	self subject: LcsMethodStream new.
	self assert: self subject stream isEmpty.
	self subject addKeyword: 'test' argument: '''aValue1'''.
	self assert: subject contents equals: 'test: ''aValue1'';'
]

{ #category : #test }
LcsMethodStreamTest >> testKeywordsMessage [
	self subject: LcsMethodStream new.
	self assert: self subject stream isEmpty.
	self subject addKeywords: 'test:test:' arguments: (Array with: '''aValue1''' with: '''aValue2''').
	self assert: subject contents equals: 'test: ''aValue1'' test: ''aValue2'';'
]

{ #category : #test }
LcsMethodStreamTest >> testKeywordsMessage2 [
	self subject: LcsMethodStream new.
	self assert: self subject stream isEmpty.
	self subject addKeywords: 'test:test:' arguments: (Array with: 1 asString with: 2 asString).
	self assert: subject contents equals: 'test: 1 test: 2;'
]

{ #category : #test }
LcsMethodStreamTest >> testKeywordsMessage3 [
	self subject: LcsMethodStream new.
	self assert: self subject stream isEmpty.
	self subject addKeywords: 'test:test:' arguments: (Array with: 'anArray' with: 'anOrderedCollection').
	self assert: subject contents equals: 'test: anArray test: anOrderedCollection;'
]

{ #category : #test }
LcsMethodStreamTest >> testUnaryMessage [
	self subject: LcsMethodStream new.
	self subject addUnaryMessage: 'test'.
	self assert: subject contents equals: 'test;'
]

{ #category : #test }
LcsMethodStreamTest >> testYourself [
	self subject: LcsMethodStream new.
	self subject addYourself.
	self assert: subject contents equals: 'yourself'
]
