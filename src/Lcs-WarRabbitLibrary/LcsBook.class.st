Class {
	#name : #LcsBook,
	#superclass : #LcsLibraryItem,
	#instVars : [
		'authors',
		'title',
		'yearPublished'
	],
	#category : #'Lcs-WarRabbitLibrary'
}

{ #category : #'slot definitions' }
LcsBook class >> authorsSlotDefinition [
	<slotDefinition>
	^LcsStringSlot new
		slotName: 'authors';
		yourself
]

{ #category : #'slot definitions' }
LcsBook class >> titleSlotDefinition [
	<slotDefinition>
	^LcsStringSlot new
		slotName: 'title';
		yourself
]

{ #category : #'slot definitions' }
LcsBook class >> yearPublishedSlotDefinition [
	<slotDefinition>
	^LcsIntegerSlot new
		slotName: 'yearPublished';
		yourself
]

{ #category : #'as yet unclassified' }
LcsBook >> authors [
	^ self slotVarNamed: 'authors'
]

{ #category : #'as yet unclassified' }
LcsBook >> authors: anObject [
	^ self slotVarNamed: 'authors' put: anObject
]

{ #category : #'as yet unclassified' }
LcsBook >> title [
	^ self slotVarNamed: 'title'
]

{ #category : #'as yet unclassified' }
LcsBook >> title: anObject [
	^ self slotVarNamed: 'title' put: anObject
]

{ #category : #'as yet unclassified' }
LcsBook >> yearPublished [
	^ self slotVarNamed: 'yearPublished'
]

{ #category : #'as yet unclassified' }
LcsBook >> yearPublished: aYear [
	^ self slotVarNamed: 'yearPublished' put: aYear
]
