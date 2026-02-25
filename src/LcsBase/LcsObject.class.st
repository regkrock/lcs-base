"
This is the root class for application classes and tool and general utitlity classes.

Another root class is LcsTestCase - all test case classes should inherit from there
"
Class {
	#name : 'LcsObject',
	#superclass : 'Object',
	#category : 'LcsBase-Core',
	#package : 'LcsBase',
	#tag : 'Core'
}

{ #category : 'transactions' }
LcsObject class >> abortTransaction [
	System abortTransaction
]

{ #category : 'slot model' }
LcsObject class >> addClassMethodNamed: aSelectorName to: collection [ 
	(self class includesSelector: aSelectorName) ifTrue: [
		collection add: (self class methodDict at: aSelectorName)].
	self = LcsObject ifFalse: [		
		self superclass addClassMethodNamed: aSelectorName to: collection ] 
]

{ #category : 'slot model' }
LcsObject class >> addInstanceMethodNamed: aSelectorName to: collection [ 
	(self includesSelector: aSelectorName) ifTrue: [
		collection add: (self methodDict at: aSelectorName)].
	self = LcsObject ifFalse: [		
		self superclass addInstanceMethodNamed: aSelectorName to: collection ] 
]

{ #category : 'transactions' }
LcsObject class >> beginTransaction [
	System beginTransaction
]

{ #category : 'transactions' }
LcsObject class >> commitTransaction [
	System commitTransaction
]

{ #category : 'testing' }
LcsObject class >> isApplicationSystemClass [
	^ false
]

{ #category : 'testing' }
LcsObject class >> isDomainClass [
	^ false
]

{ #category : 'slot model' }
LcsObject class >> slotDefinitionMethodsNamed: aSelectorName [ 
	| collection |
	collection := OrderedCollection new.
	self addClassMethodNamed: aSelectorName to: collection.
	^ collection
]

{ #category : 'query' }
LcsObject >> classFor: aStringOrClass [
	aStringOrClass isClass ifTrue: [ ^ aStringOrClass ].
	^ [ aStringOrClass asClass ] on: NotFound do: [ :s | s return: nil ]
]

{ #category : 'printing' }
LcsObject >> gtPrint: anObject on: stream [ 
	self printOn: stream.
	stream 
		nextPutAll: '(';
		nextPutAll: anObject asString;
		nextPutAll: ')'
]

{ #category : 'testing' }
LcsObject >> isApplicationSystem [
	^ false
]

{ #category : 'testing' }
LcsObject >> isDomainClass [
	^self class isDomainClass
]

{ #category : 'private' }
LcsObject >> removeProtoObjectFrom: classes [
	([ 'ProtoObject' asClass ] on: NotFound do: [ ^ self ])
		ifNotNil: [ :class | classes remove: class ifAbsent: [  ] ]
]

{ #category : 'convenience' }
LcsObject >> selectorNameFrom: aString [
	| newString |
	newString := aString displayString asCamelCase.
	(newString at: 1) isLowercase ifTrue: [ ^ newString ].
	^ (newString at: 1) asLowercase asString , (newString copyFrom: 2 to: newString size)
]

{ #category : 'testing' }
LcsObject >> testGemstone [
	^ 1 = 2
]
