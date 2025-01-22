"
All application test classes should inherit from this class
"
Class {
	#name : #LcsTestCase,
	#superclass : #TestCase,
	#instVars : [
		'subject'
	],
	#category : #'Lcs-BaseTests'
}

{ #category : #subject }
LcsTestCase class >> subjectClass [
	^ self subclassResponsibility
]

{ #category : #running }
LcsTestCase >> abortTransaction [
	System abortTransaction
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

{ #category : #subject }
LcsTestCase >> createNewSubject [
	self subject: self newSubject
]

{ #category : #subject }
LcsTestCase >> newSubject [
	^ self subjectClass new
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

{ #category : #subject }
LcsTestCase >> subjectClass [
	^ self class subjectClass
]
