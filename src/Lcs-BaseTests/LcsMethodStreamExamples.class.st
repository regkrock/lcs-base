Class {
	#name : 'LcsMethodStreamExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-BaseTests-Examples',
	#package : 'Lcs-BaseTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsMethodStreamExamples >> methodStreamWithKeywordArgumentKeywordArgumentMessage [
	<gtExample>
	self subject: self newMethodStream.
	self assert: self subject stream isEmpty.
	self subject addKeyword: 'test' argument: '''aValue1''' keyword: 'test' argument: '''aValue2'''.
	self assert: subject contents equals: 'test: ''aValue1'' test: ''aValue2'';'.
	^ self subject
]

{ #category : 'examples' }
LcsMethodStreamExamples >> methodStreamWithKeywordArgumentMessage [
	<gtExample>
	self subject: self newMethodStream.
	self assert: self subject stream isEmpty.
	self subject addKeyword: 'test' argument: '''aValue1'''.
	self assert: subject contents equals: 'test: ''aValue1'';'.
	^ self subject
]

{ #category : 'examples' }
LcsMethodStreamExamples >> methodStreamWithKeywordsMessage [
	<gtExample>
	self subject: self newMethodStream.
	self assert: self subject stream isEmpty.
	self subject addKeywords: 'test:test:' arguments: (Array with: '''aValue1''' with: '''aValue2''').
	self assert: subject contents equals: 'test: ''aValue1'' test: ''aValue2'';'.
	^ self subject
]

{ #category : 'examples' }
LcsMethodStreamExamples >> methodStreamWithKeywordsMessage2 [
	<gtExample>
	self subject: self newMethodStream.
	self assert: self subject stream isEmpty.
	self subject addKeywords: 'test:test:' arguments: (Array with: 1 asString with: 2 asString).
	self assert: subject contents equals: 'test: 1 test: 2;'.
	^ self subject
]

{ #category : 'examples' }
LcsMethodStreamExamples >> methodStreamWithKeywordsMessage3 [
	<gtExample>
	self subject: self newMethodStream.
	self assert: self subject stream isEmpty.
	self subject addKeywords: 'test:test:' arguments: (Array with: 'anArray' with: 'anOrderedCollection').
	self assert: subject contents equals: 'test: anArray test: anOrderedCollection;'.
	^ self subject
]

{ #category : 'examples' }
LcsMethodStreamExamples >> methodStreamWithSelectorOnly [
	<gtExample>
	self subject: self newMethodStream.
	self subject startMethodSource: 'testMethod'.
	self assert: subject indentLevel equals: 1.
	self assert: self subject contents equals: 'testMethod'.
	^ self subject
]

{ #category : 'examples' }
LcsMethodStreamExamples >> methodStreamWithSlotDefinitionSelectorSourceCode [
	<gtExample>
	self subject: self newMethodStream.
	self subject startSlotDefinitionSource: 'testMethod' pragmaName: LcsBaseSlot accessorSlotDefinitionName.
	self assert: subject indentLevel equals: 1.
	self
		assert: self subject contents
		equals: 'testMethod
	<accessorSlotDefinition>'.
	^ self subject
]

{ #category : 'examples' }
LcsMethodStreamExamples >> methodStreamWithSlotDefinitionSelectorSourceCodeWithBuilderClass [
	<gtExample>
	self subject: self newMethodStream.
	self subject startSlotDefinitionSource: 'testMethod' pragmaName: LcsBaseSlot accessorSlotDefinitionName.
	self subject addSlotDefinitionClassCreatonLine: 'LcsStringSlot'.
	self assert: subject indentLevel equals: 2.
	self
		assert: self subject contents
		equals: 'testMethod
	<accessorSlotDefinition>
	^ LcsStringSlot new'.
	^ self subject
]

{ #category : 'examples' }
LcsMethodStreamExamples >> methodStreamWithUnaryMessage [
	<gtExample>
	self subject: self newMethodStream.
	self subject addUnaryMessage: 'test'.
	self assert: subject contents equals: 'test;'.
	^ self subject
]

{ #category : 'examples' }
LcsMethodStreamExamples >> methodStreamWithYourself [
	<gtExample>
	self subject: self newMethodStream.
	self subject addYourself.
	self assert: subject contents equals: 'yourself'.
	self subject
]

{ #category : 'examples' }
LcsMethodStreamExamples >> newMethodStream [
	<gtExample>
	self subject: LcsMethodStream new.
	self assert: self subject indentLevel equals: 0.
	self assert: (self subject stream isKindOf: WriteStream).
	self assert: self subject stream isEmpty.
	self assert: self subject contents equals: ''.
	^ self subject
]
