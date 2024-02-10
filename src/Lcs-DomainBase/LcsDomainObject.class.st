Class {
	#name : #LcsDomainObject,
	#superclass : #LcsObject,
	#instVars : [
		'parent'
	],
	#classInstVars : [
		'SlotDefinitions'
	],
	#category : #'Lcs-DomainBase'
}

{ #category : #'unit of work' }
LcsDomainObject class >> addToUnitOfWork: newObject [
	self currentUnitOfWork addObject: newObject
]

{ #category : #'slot definitions' }
LcsDomainObject class >> buildSlotDefinitions [

	self allSubclasses do: [:each |
		each initializeSlotDefinitions]
]

{ #category : #'unit of work' }
LcsDomainObject class >> currentUnitOfWork [
	^self currentSystem currentUnitOfWork
]

{ #category : #'slot definitions' }
LcsDomainObject class >> initializeSlotDefinitions [
		self slotDefinitions: (LcsSlotDefinitions newOn: self)
]

{ #category : #'instance creation\t' }
LcsDomainObject class >> new [
	| newObject |
	newObject := self basicNew initialize.
	self addToUnitOfWork: newObject.
	^ newObject
]

{ #category : #accessing }
LcsDomainObject class >> slotDefinitions [
	^ SlotDefinitions
]

{ #category : #accessing }
LcsDomainObject class >> slotDefinitions: anObject [
	SlotDefinitions := anObject
]

{ #category : #accessing }
LcsDomainObject >> addToUnitOfWork: aDomainObject [

	self currentUnitOfWork addObject: aDomainObject
]

{ #category : #'unit of work' }
LcsDomainObject >> currentUnitOfWork [

	^self class currentUnitOfWork
]

{ #category : #'unit of work' }
LcsDomainObject >> delete [

	self currentUnitOfWork deleteObject: self
]

{ #category : #accessing }
LcsDomainObject >> new [
]

{ #category : #accessing }
LcsDomainObject >> parent [
	^ parent
]

{ #category : #accessing }
LcsDomainObject >> parent: anObject [
	parent := anObject
]
