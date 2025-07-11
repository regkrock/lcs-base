Class {
	#name : #LcsBlockSourceConverter,
	#superclass : #LcsObject,
	#instVars : [
		'arguments',
		'accessors',
		'sourceModel'
	],
	#category : #'LcsBase-Core'
}

{ #category : #'instance creation' }
LcsBlockSourceConverter class >> blockWithInnerSourceCode: aString replacing: aBlock [
	^ self blockWithInnerSourceCode: aString replacing: aBlock parameters: #()
]

{ #category : #'instance creation' }
LcsBlockSourceConverter class >> blockWithInnerSourceCode: aString replacing: aBlock parameters: anArray [
	^ self new
		arguments: anArray;
		blockFromInnerSourceCode: aString replacing: aBlock
]

{ #category : #'instance creation' }
LcsBlockSourceConverter class >> innerSourceCodeBlockIn: aModel accessors: aCollection parameters: anArray model: aBlock [
	^ self new
		innerSourceCodeBlockIn: nil
		accessors: aCollection
		parameters: anArray
		model: aBlock
]

{ #category : #'instance creation' }
LcsBlockSourceConverter class >> innerSourceCodeOf: aBlock [
	^ self
		innerSourceCodeBlockIn: nil
		accessors: nil
		parameters: #()
		model: aBlock
]

{ #category : #'instance creation' }
LcsBlockSourceConverter class >> innerSourceCodeOfBlockIn: aModel accessors: aCollection parameters: anArray [
	^ self new
		accessors: aCollection;
		arguments: anArray;
		innerSourceCodeOfBlockIn: aModel
]

{ #category : #'instance creation' }
LcsBlockSourceConverter class >> replaceBlockIn: aModel withInnerSourceCode: aString accessors: anAccessorsCollection parameters: aParametersCollection [
	self new
		accessors: anAccessorsCollection;
		arguments: aParametersCollection;
		sourceModel: aModel;
		replaceBlockInnerSourceCode: aString
]

{ #category : #converting }
LcsBlockSourceConverter >> accessors [
	^ accessors
]

{ #category : #accessing }
LcsBlockSourceConverter >> accessors: aCollection [ 
	accessors := aCollection
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
LcsBlockSourceConverter >> innerSourceCodeBlockIn: aModel accessors: aCollection parameters: anArray model: aBlock [
	self arguments: anArray.
	self accessors: aCollection.
	self sourceModel: aModel.
	^ self  innerSourceCodeOf: aBlock
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

{ #category : #converting }
LcsBlockSourceConverter >> innerSourceCodeOfBlockIn: aModel [
	self sourceModel: aModel.
	^ self innerSourceCodeOf: self originalBlock
]

{ #category : #converting }
LcsBlockSourceConverter >> innerSourceCodeOfBlockIn: aModel accessors: anAccessors parameters: anArray [
	| block |
	self arguments: anArray.
	self accessors: anAccessors.
	self sourceModel: aModel.
	block := anAccessors inject: aModel into: [ :currentModel :eachSelector | currentModel perform: eachSelector asSymbol ].
	^ self  innerSourceCodeOf: block
]

{ #category : #private }
LcsBlockSourceConverter >> originalBlock [
	^ self accessors
		inject: self sourceModel
		into: [ :targetModel :eachSelector | targetModel perform: eachSelector asSymbol ]
]

{ #category : #'instance creation' }
LcsBlockSourceConverter >> replaceBlockInnerSourceCode: aString [
	| newBlock |
	newBlock := self blockFromInnerSourceCode: aString replacing: self originalBlock.
	self targetModel perform: (self accessors last , ':') asSymbol with: newBlock
]

{ #category : #accessing }
LcsBlockSourceConverter >> sourceModel [
	^ sourceModel
]

{ #category : #accessing }
LcsBlockSourceConverter >> sourceModel: aModel [ 
	sourceModel := aModel
]

{ #category : #private }
LcsBlockSourceConverter >> targetModel [
	| pathAccessors |
	self accessors isEmpty ifTrue: [ ^ self sourceModel ].
	self accessors size = 1 ifTrue: [ ^ self sourceModel ].
	pathAccessors := self accessors copyFrom: 1 to: (self accessors size - 1).
	^ pathAccessors
		inject: self sourceModel
		into: [ :currentModel :eachSelector | currentModel perform: eachSelector asSymbol ]
]
