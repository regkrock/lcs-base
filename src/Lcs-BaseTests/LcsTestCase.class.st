"
All application test classes should inherit from this class
"
Class {
	#name : #LcsTestCase,
	#superclass : #TestCase,
	#instVars : [
		'subject'
	],
	#category : #'Lcs-BaseTests-Tests'
}

{ #category : #running }
LcsTestCase >> abortTransaction [
	System abortTransaction
]

{ #category : #'as yet unclassified' }
LcsTestCase >> assertSortedCollection: actual equals: expected [
	self assert: actual equals: expected.
	actual with: expected do: [ :actualItem : expectedItem |
		self assert: actualItem equals: expectedItem ]
]

{ #category : #running }
LcsTestCase >> beginTransaction [
	System beginTransaction
]

{ #category : #accessing }
LcsTestCase >> classNamed: aString [
	^ [ aString asClass ] on: NotFound do: [ :ex | ex return: nil ]
]

{ #category : #running }
LcsTestCase >> commitTransaction [
	System commitTransaction
]

{ #category : #refactoring }
LcsTestCase >> createClassName: aString superclassName: aSuperclassName category: aCategory [
	(self classNamed: aString)
		ifNil: [ 
			(RBAddClassRefactoring
				addClass: aString asSymbol
				superclass: aSuperclassName asClass
				subclasses: #()
				category: aCategory asSymbol) execute ]
]

{ #category : #refactoring }
LcsTestCase >> removeClassName: aString [
	(self classNamed: aString)
		ifNotNil: [ (RBRemoveClassChange removeClassName: aString asSymbol) execute ]
]

{ #category : #refactoring }
LcsTestCase >> removeClassesNamed: aCollectionOfClassNaes [
	aCollectionOfClassNaes do: [ :eachClassName | self removeClassName: eachClassName ]
]

{ #category : #accessing }
LcsTestCase >> subject [
	^ subject
]

{ #category : #accessing }
LcsTestCase >> subject: anObject [
	subject := anObject
]
