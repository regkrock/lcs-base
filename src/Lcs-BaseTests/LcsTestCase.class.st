"
All application test classes should inherit from this class
"
Class {
	#name : #LcsTestCase,
	#superclass : #TestCase,
	#category : #'Lcs-BaseTests'
}

{ #category : #running }
LcsTestCase >> abortTransaction [
	LcsSmalltalkConfiguration gsSystemClass abortTransaction
]

{ #category : #running }
LcsTestCase >> beginTransaction [
	LcsSmalltalkConfiguration gsSystemClass beginTransaction
]

{ #category : #accessing }
LcsTestCase >> classNamed: aString [
	^ [ aString asClass ] on: NotFound do: [ nil ]
]

{ #category : #running }
LcsTestCase >> commitTransaction [
	LcsSmalltalkConfiguration gsSystemClass commitTransaction
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
