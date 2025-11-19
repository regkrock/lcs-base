Class {
	#name : 'LcsBlockSourceConverter',
	#superclass : 'LcsObject',
	#instVars : [
		'arguments'
	],
	#category : 'LcsBase-Core',
	#package : 'LcsBase',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LcsBlockSourceConverter class >> blockWithArguments: blockArguments innerSourceCode: innerBlockString toReplace: existingBlock [
	^ self  new 
		blockWithArguments: blockArguments innerSourceCode: innerBlockString toReplace: existingBlock
]

{ #category : 'instance creation' }
LcsBlockSourceConverter class >> blockWithInnerSourceCode: innerBlockString arguments: blockArguments [
	^ self
		blockWithArguments: blockArguments
		innerSourceCode: innerBlockString
		toReplace: [  ]
]

{ #category : 'instance creation' }
LcsBlockSourceConverter class >> blockWithInnerSourceCode: innerBlockString toReplace: existingBlock [
	^ self
		blockWithArguments: #()
		innerSourceCode: innerBlockString
		toReplace: existingBlock
]

{ #category : 'instance creation' }
LcsBlockSourceConverter class >> innerSourceCodeOf: aBlock [
	^ self innerSourceCodeOf: aBlock arguments: #()
]

{ #category : 'instance creation' }
LcsBlockSourceConverter class >> innerSourceCodeOf: aBlock arguments: aBlockArguments [
	^ self new
		innerSourceCodeOf: aBlock arguments: aBlockArguments
]

{ #category : 'accessing' }
LcsBlockSourceConverter >> arguments [
	^ arguments
]

{ #category : 'accessing' }
LcsBlockSourceConverter >> arguments: anObject [
	arguments := anObject
]

{ #category : 'converting' }
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

{ #category : 'converting' }
LcsBlockSourceConverter >> blockFromInnerSourceCode: aString replacing: aBlock [
	aString trimBoth = (self innerSourceCodeOf: aBlock) ifTrue: [ ^ aBlock ].
	^ self class compiler evaluate: (self blockFromInnerSourceCode: aString)
]

{ #category : 'converting' }
LcsBlockSourceConverter >> blockWithArguments: blockArguments innerSourceCode: innerBlockString toReplace: existingBlock [
	self arguments: blockArguments.
	^ self blockFromInnerSourceCode: innerBlockString replacing: existingBlock
]

{ #category : 'initialize' }
LcsBlockSourceConverter >> initialize [
	super initialize.
	self arguments: OrderedCollection new
]

{ #category : 'converting' }
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

{ #category : 'converting' }
LcsBlockSourceConverter >> innerSourceCodeOf: aBlock arguments: blockArguments [
	self arguments: blockArguments.
	^ self innerSourceCodeOf: aBlock
]
