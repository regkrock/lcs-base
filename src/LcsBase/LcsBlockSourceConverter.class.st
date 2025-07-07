Class {
	#name : #LcsBlockSourceConverter,
	#superclass : #LcsObject,
	#instVars : [
		'arguments'
	],
	#category : #'LcsBase-Core'
}

{ #category : #'instance creation' }
LcsBlockSourceConverter class >> blockWithInnerSourceCode: aString replacing: aBlock [
	^ self new 
		blockFromInnerSourceCode: aString replacing: aBlock
]

{ #category : #'instance creation' }
LcsBlockSourceConverter class >> innerSourceCodeOf: aBlock [
	^ self new innerSourceCodeOf: aBlock
]

{ #category : #'instance creation' }
LcsBlockSourceConverter class >> innerSourceCodeOfSlotBlock: aBlock [
	^ self new 
		arguments: #('domainObject' 'slot');
		innerSourceCodeOf: aBlock
]

{ #category : #'instance creation' }
LcsBlockSourceConverter class >> slotBlockWithInnerSourceCode: aString replacing: aBlock [
	^ self new 
		arguments: #('domainObject' 'slot');
		blockFromInnerSourceCode: aString replacing: aBlock
]

{ #category : #accessing }
LcsBlockSourceConverter >> arguments [
	^ arguments
]

{ #category : #accessing }
LcsBlockSourceConverter >> arguments: anObject [
	arguments := anObject
]

{ #category : #converting }
LcsBlockSourceConverter >> blockFromInnerSourceCode: aString [
	| stream |
	stream := WriteStream on: String new.
	stream nextPutAll: '[ '.
	self arguments notEmpty ifTrue: [
		self arguments do: [ :each | stream nextPutAll: ':'; nextPutAll: each; space ].
		stream nextPutAll: '| '].
	stream 
		nextPutAll: aString trimBoth;
		nextPutAll: ' ]'.
	^ stream contents
]

{ #category : #converting }
LcsBlockSourceConverter >> blockFromInnerSourceCode: aString replacing: aBlock [
	aString trimBoth = (self innerSourceCodeOf: aBlock) ifTrue: [ ^ aBlock ].
	^ self class evaluate: (self blockFromInnerSourceCode: aString)
]

{ #category : #initialize }
LcsBlockSourceConverter >> initialize [
	super initialize.
	self arguments: OrderedCollection new
]

{ #category : #converting }
LcsBlockSourceConverter >> innerSourceCodeOf: aBlock [
	| sourceCode barIndex rightSquareBracketIndex leftSquareBracketIndex |
	sourceCode := aBlock asString.
	barIndex := sourceCode indexOf: $|.
	rightSquareBracketIndex := sourceCode indexOf: $].
	leftSquareBracketIndex := sourceCode indexOf: $[.
	barIndex = 0
		ifTrue: [ 
			(leftSquareBracketIndex + 1) = rightSquareBracketIndex ifTrue: [ ^ '' ].
			^ (sourceCode copyFrom: (leftSquareBracketIndex + 1) to: (rightSquareBracketIndex - 1)) trimBoth ].
	(barIndex + 1) = rightSquareBracketIndex ifTrue: [ ^ '' ].
	^ (sourceCode copyFrom: (barIndex + 1) to: (rightSquareBracketIndex - 1) ) trimBoth
]
