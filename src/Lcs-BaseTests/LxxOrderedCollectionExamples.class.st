Class {
	#name : 'LxxOrderedCollectionExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-BaseTests-Examples',
	#package : 'Lcs-BaseTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LxxOrderedCollectionExamples >> newOrderedCollection [
	<gtExample>
	| anLxxCollection |
	anLxxCollection := LxxOrderedCollection new.
	self assert: anLxxCollection collection class equals: OrderedCollection.
	^ anLxxCollection
]

{ #category : 'examples' }
LxxOrderedCollectionExamples >> orderedCollectionTwoElements [
	| anLxxCollection result |
	result := OrderedCollection new.
	anLxxCollection := self newOrderedCollection.
	anLxxCollection 
		add: 1; 
		add: 2.
	anLxxCollection do: [:each | result add: each + 1 ].
	self assert: (result at: 1) equals: 2.
	self assert: (result at: 2) equals: 3.
	^ anLxxCollection
]

{ #category : 'examples' }
LxxOrderedCollectionExamples >> orderedCollectionWithElementsAdded [
	<gtExample>
	| anLxxCollection addedObject |
	anLxxCollection := self newOrderedCollection.
	self assert: anLxxCollection isEmpty.
	self assert: (anLxxCollection isNotEmpty) not.
	
	addedObject := anLxxCollection add: 1.
	
	self assert: addedObject equals: 1.
	self assert: (anLxxCollection isEmpty) not.
	self assert: anLxxCollection isNotEmpty.
	^ anLxxCollection
]

{ #category : 'examples' }
LxxOrderedCollectionExamples >> orderedCollectionWithElementsCollected [
	<gtExample>
	| anLxxCollection result |
	anLxxCollection := self newOrderedCollection.
	anLxxCollection 
		add: 1; 
		add: 2.
	result := anLxxCollection collect: [:each | each + 1 ].
	self assert: (result at: 1) equals: 2.
	self assert: (result at: 2) equals: 3.
	^ anLxxCollection
]

{ #category : 'examples' }
LxxOrderedCollectionExamples >> orderedCollectionWithElementsRejected [
	<gtExample>
	| anLxxCollection result |
	anLxxCollection := self newOrderedCollection.
	anLxxCollection 
		add: 1; 
		add: 2.
	result := anLxxCollection reject: [:each | each > 1 ].
	self assert: result size equals: 1.
	self assert: (result at: 1) equals: 1.
	^ anLxxCollection
]

{ #category : 'examples' }
LxxOrderedCollectionExamples >> orderedCollectionWithElementsRemoved [
	<gtExample>
	| anLxxCollection addedObject removedOjbect |
	anLxxCollection := self newOrderedCollection.
	addedObject := anLxxCollection add: 1.
	
	removedOjbect := anLxxCollection remove: 1.

	self assert: addedObject equals: 1.
	self assert: removedOjbect equals: 1.

	self assert: anLxxCollection isEmpty.
	self assert: (anLxxCollection isNotEmpty) not .
	
	self assert: (anLxxCollection remove: 1 ifAbsent: [ nil ]) isNil.
	anLxxCollection add: 1.
	self assert: (anLxxCollection remove: 1 ifAbsent: [ nil ]) = 1.
	^ anLxxCollection
]

{ #category : 'examples' }
LxxOrderedCollectionExamples >> orderedCollectionWithIncludes [
	<gtExample>
	| anLxxCollection result |
	anLxxCollection := self newOrderedCollection.
	anLxxCollection 
		add: 1; 
		add: 2.
	result := anLxxCollection select: [:each | each > 1 ].
	self assert: (anLxxCollection includes: 1).
	self assert: (anLxxCollection includes: 10) not.
	^ anLxxCollection
]

{ #category : 'examples' }
LxxOrderedCollectionExamples >> orderedCollectionWithSelect [
	<gtExample>
	| anLxxCollection result |
	anLxxCollection := self newOrderedCollection.
	anLxxCollection 
		add: 1; 
		add: 2.
	result := anLxxCollection select: [:each | each > 1 ].
	self assert: result size equals: 1.
	self assert: (result at: 1) equals: 2.
	^ anLxxCollection
]

{ #category : 'examples' }
LxxOrderedCollectionExamples >> orderedCollectionWithTwoElementsThatWereInjectedInto [
	<gtExample>
	| anLxxCollection result |
	anLxxCollection := self newOrderedCollection.
	anLxxCollection 
		add: 1; 
		add: 2.
	result := anLxxCollection inject: 0 into: [:total :each | total + each ].
	self assert: result equals: 3.
	^ anLxxCollection
]
