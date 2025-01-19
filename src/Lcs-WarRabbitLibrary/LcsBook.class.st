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

{ #category : #'slot definition' }
LcsBook class >> authorsSlotDefinition [
	<slotDefinition>
	^LcsStringSlot new
		slotName: 'authors';
		yourself
]

{ #category : #'slot definition' }
LcsBook class >> titleSlotDefinition [
	<slotDefinition>
	^LcsStringSlot new
		slotName: 'title';
		yourself
]

{ #category : #'slot definition' }
LcsBook class >> yearPublishedSlotDefinition [
	<slotDefinition>
	^LcsIntegerSlot new
		slotName: 'yearPublished';
		yourself
]

{ #category : #'as yet unclassified' }
LcsBook >> authors [
	^ self getValueOfSlotNamed: 'authors'
]

{ #category : #'as yet unclassified' }
LcsBook >> authors: anObject [
	^ self setValueOfSlotNamed: 'authors' to: anObject
]

{ #category : #'as yet unclassified' }
LcsBook >> title [
	^ self getValueOfSlotNamed: 'title'
]

{ #category : #'as yet unclassified' }
LcsBook >> title: anObject [
	^ self setValueOfSlotNamed: 'title' to: anObject
]

{ #category : #'as yet unclassified' }
LcsBook >> yearPublished [
	^ self getValueOfSlotNamed: 'yearPublished'
]

{ #category : #'as yet unclassified' }
LcsBook >> yearPublished: aYear [
	^ self setValueOfSlotNamed: 'yearPublished' to: aYear
]
