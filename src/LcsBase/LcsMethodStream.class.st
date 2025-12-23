Class {
	#name : 'LcsMethodStream',
	#superclass : 'LcsObject',
	#instVars : [
		'stream',
		'indentLevel'
	],
	#category : 'LcsBase-Core',
	#package : 'LcsBase',
	#tag : 'Core'
}

{ #category : 'building' }
LcsMethodStream >> addKeyword: aKeyword argument: aString [
	self newLine
		nextPutAll: aKeyword;
		nextPutAll: ': ';
		nextPutAll: aString;
		nextPutAll: ';'
]

{ #category : 'building' }
LcsMethodStream >> addKeyword: aKeyword argument: aString keyword: aKeyword2 argument: aString2 [ 
	self newLine
		nextPutAll: aKeyword;
		nextPutAll: ': ';
		nextPutAll: aString;
		space;
		nextPutAll: aKeyword2;
		nextPutAll: ': ';
		nextPutAll: aString2;
		nextPutAll: ';'
]

{ #category : 'building' }
LcsMethodStream >> addKeyword: aKeyword symbolArgument: aString [
	self newLine
		nextPutAll: aKeyword;
		nextPutAll: ': #';
		nextPutAll: aString;
		nextPutAll: ';'
]

{ #category : 'building' }
LcsMethodStream >> addKeyword: aKeyword withRenderedAction: anAction [
	self newLine
		nextPutAll: aKeyword;
		nextPutAll: ': ('.
	self indent.
	anAction addCodeGenerationDetailsTo: self.
	self nextPutAll: ');'.
	self outdent; outdent
]

{ #category : 'building' }
LcsMethodStream >> addKeywords: aKeywordSelectorName arguments: aCollectionOfStrings [ 
	| keywords count |
	keywords := aKeywordSelectorName substrings: { Character value: 58 }.
	self assert: keywords size equals: aCollectionOfStrings size.
	count := 0.
	
	self newLine.
	keywords with: aCollectionOfStrings do: [ :keyword :value |
		count := count + 1.
		self stream
			nextPutAll: keyword;
			nextPutAll: ': ';
			nextPutAll: value.
		keywords size = count 
			ifTrue: [ self stream nextPutAll: ';' ] 
			ifFalse: [ self stream space ] ]
]

{ #category : 'accessing' }
LcsMethodStream >> addSlotDefinitionClassCreatonLine: aSlotDefinitionClassName [
	self newLine
		nextPutAll: '^ ';
		nextPutAll: aSlotDefinitionClassName;
		nextPutAll: ' new'.
	self increaseIndentLevel
]

{ #category : 'accessing' }
LcsMethodStream >> addUnaryMessage: aString [
	self newLine nextPutAll: aString; nextPutAll: ';'
]

{ #category : 'building' }
LcsMethodStream >> addYourself [
	self newLine
		nextPutAll: 'yourself'

]

{ #category : 'stream' }
LcsMethodStream >> contents [
	^ self stream contents
]

{ #category : 'accessing' }
LcsMethodStream >> decrementIndentLevel [
	self indentLevel: self indentLevel - 1.
	self indentLevel < 0 ifTrue: [ self indentLevel: 0]
]

{ #category : 'accessing' }
LcsMethodStream >> increaseIndentLevel [
	self indentLevel: self indentLevel + 1
]

{ #category : 'accessing' }
LcsMethodStream >> indent [
	self increaseIndentLevel
]

{ #category : 'accessing' }
LcsMethodStream >> indentLevel [
	^ indentLevel
]

{ #category : 'accessing' }
LcsMethodStream >> indentLevel: anObject [ 
	indentLevel := anObject
]

{ #category : 'initialize' }
LcsMethodStream >> initialize [
	super initialize.
	self stream: (WriteStream on: String new).
	self indentLevel: 0
]

{ #category : 'testing' }
LcsMethodStream >> isLastCharacterLineTerminationCharacter [
	^ {Character lf.
		Character cr} includes: self stream contents last
]

{ #category : 'building' }
LcsMethodStream >> newLine [
	self stream contents isEmpty
		ifFalse: [ self isLastCharacterLineTerminationCharacter ifFalse: [ self stream cr ] ].
	self indentLevel timesRepeat: [ stream tab ].
	^ self stream
]

{ #category : 'building' }
LcsMethodStream >> nextPutAll: aString [
	self stream nextPutAll: aString
]

{ #category : 'accessing' }
LcsMethodStream >> outdent [
	self decrementIndentLevel
]

{ #category : 'building' }
LcsMethodStream >> startMethodSource: aSelector [
	self newLine nextPutAll: aSelector.
	self increaseIndentLevel
]

{ #category : 'building' }
LcsMethodStream >> startSlotDefinitionSource: aSelector pragmaName: aString [
	self startMethodSource: aSelector.
	self newLine 
		nextPutAll: '<';
		nextPutAll: aString;
		nextPutAll: '>'.
]

{ #category : 'accessing' }
LcsMethodStream >> stream [
	^ stream
]

{ #category : 'accessing' }
LcsMethodStream >> stream: anObject [
	stream := anObject
]

{ #category : 'stream' }
LcsMethodStream >> streamPosition [
	^ self stream position
]
