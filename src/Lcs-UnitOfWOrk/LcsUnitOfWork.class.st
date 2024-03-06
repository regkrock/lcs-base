Class {
	#name : #LcsUnitOfWork,
	#superclass : #LcsBaseUnitOfWork,
	#category : #'Lcs-UnitOfWOrk'
}

{ #category : #accessing }
LcsUnitOfWork >> applyChanges [
	self addedObjects values do: [:each | each applyChanges].
	self changedObjects do: [:each | each applyChanges ].
	self clearUnitOfWork
]

{ #category : #accessing }
LcsUnitOfWork >> changedSlotRecordFor: aDomainObject slotNamed: aSlotName [
	^ (self changedRecordFor: aDomainObject)
		ifNil: [nil]
		ifNotNil: [:changedObjectRecord | changedObjectRecord changedSlotRecordFor: aSlotName]
]

{ #category : #accessing }
LcsUnitOfWork >> hasChanges [
	self changedObjects notEmpty ifTrue: [^true].
	self deletedObjects notEmpty ifTrue: [^true].
	^self addedObjects notEmpty
]

{ #category : #accessing }
LcsUnitOfWork >> hasNoChanges [
	self changedObjects isEmpty ifTrue: [^true].
	self deletedObjects isEmpty ifTrue: [^true].
	^self addedObjects isEmpty
]
