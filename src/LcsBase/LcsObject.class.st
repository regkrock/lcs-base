"
This is the root class for application classes and tool and general utitlity classes.

Another root class is LcsTestCase - all test case classes should inherit from there
"
Class {
	#name : #LcsObject,
	#superclass : #Object,
	#category : #'LcsBase-Core'
}

{ #category : #transactions }
LcsObject class >> abortTransaction [
	System abortTransaction
]

{ #category : #transactions }
LcsObject class >> beginTransaction [
	System beginTransaction
]

{ #category : #transactions }
LcsObject class >> commitTransaction [
	System commitTransaction
]

{ #category : #testing }
LcsObject class >> isApplicationSystemClass [
	^ false
]

{ #category : #testing }
LcsObject class >> isDomainClass [
	^ false
]

{ #category : #testing }
LcsObject >> isApplicationSystem [
	^ false
]

{ #category : #testing }
LcsObject >> isDomainClass [
	^self class isDomainClass
]

{ #category : #printing }
LcsObject >> printOn: aStream [
	super printOn: aStream.
	"aStream 
		nextPutAll: ' (objectId: ';
		nextPutAll: self hash displayString;
		nextPutAll: ')'"

]

{ #category : #pirvate }
LcsObject >> removerProtoObjectFrom: classes [
	([ 'ProtoObject' asClass ] on: NotFound do: [ nil ])
		ifNotNil: [ :class | classes remove: class ifAbsent: [  ] ]
]

{ #category : #convenience }
LcsObject >> selectorNameFrom: aString [
	| newString |
	newString := aString displayString asCamelCase.
	(newString at: 1) isLowercase ifTrue: [ ^ newString ].
	^ (newString at: 1) asLowercase asString , (newString copyFrom: 2 to: newString size)
]

{ #category : #testing }
LcsObject >> testGemstone [
	^ 1 = 2
]
