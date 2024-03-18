Class {
	#name : #LcsUnitOfWork,
	#superclass : #LcsBaseUnitOfWork,
	#classVars : [
		'Singleton'
	],
	#category : #'Lcs-UnitOfWOrk'
}

{ #category : #initialize }
LcsUnitOfWork class >> releaseEnvironment [
	#LcsUnitOfWorkManager asClass releaseEnvironment.
	self singleton ifNil: [ ^ self ].
	self singleton releaseEnvironment.
	self singleton: nil
]

{ #category : #initialize }
LcsUnitOfWork class >> singleton [
	^ Singleton
]

{ #category : #initialize }
LcsUnitOfWork class >> singleton: anUndefinedObject [ 
	Singleton := anUndefinedObject
]

{ #category : #api }
LcsUnitOfWork >> applyChanges [
	self addedObjects valuesDo: [ :each | each applyChanges ].
	self changedObjects do: [ :each | each applyChanges ].
	self clearUnitOfWork
]

{ #category : #api }
LcsUnitOfWork >> changedSlotRecordFor: aDomainObject slotNamed: aSlotName [
	^ (self changedRecordFor: aDomainObject)
		ifNil: [ nil ]
		ifNotNil: [ :changedObjectRecord | changedObjectRecord changedSlotRecordFor: aSlotName ]
]

{ #category : #testing }
LcsUnitOfWork >> hasChanges [
	self changedObjects notEmpty ifTrue: [ ^ true ].
	self deletedObjects notEmpty ifTrue: [ ^ true ].
	^ self addedObjects notEmpty
]

{ #category : #testing }
LcsUnitOfWork >> hasNoChanges [
	self changedObjects isEmpty ifTrue: [ ^ true ].
	self deletedObjects isEmpty ifTrue: [ ^ true ].
	^ self addedObjects isEmpty
]
