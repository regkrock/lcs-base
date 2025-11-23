Class {
	#name : 'LcsUnitOfWork',
	#superclass : 'LcsBaseUnitOfWork',
	#category : 'Lcs-SystemManagement-UnitOfWork',
	#package : 'Lcs-SystemManagement',
	#tag : 'UnitOfWork'
}

{ #category : 'api' }
LcsUnitOfWork >> applyChanges [
	self addedObjects valuesDo: [ :each | each applyChanges ].
	self changedObjects do: [ :each | each applyChanges ].
	self changedCollections keysAndValuesDo: [ :eachCollection :values | self applyChanges: values to: eachCollection ].
	self clearUnitOfWork
]

{ #category : 'api' }
LcsUnitOfWork >> applyChanges: aDictionary to: eachCollection [ 
		(aDictionary at: 'add') do: [ :eachItem | eachCollection directAdd: eachItem ].
		(aDictionary at: 'delete') do: [ :eachItem | eachCollection delete: eachItem ]

]

{ #category : 'api' }
LcsUnitOfWork >> changedSlotRecordFor: aDomainObject slotNamed: aSlotName [
	^ (self changedRecordFor: aDomainObject)
		ifNil: [ nil ]
		ifNotNil: [ :changedObjectRecord | changedObjectRecord changedSlotRecordFor: aSlotName ]
]

{ #category : 'testing' }
LcsUnitOfWork >> hasAddedRecordFor: aDomainObject [
	^ (self addedObjects at: aDomainObject ifAbsent: [ nil ]) notNil
]

{ #category : 'testing' }
LcsUnitOfWork >> hasChangeRecordFor: anItem [
	self changedObjects at: anItem ifAbsent: [ ^ false ].
	^ true
]

{ #category : 'testing' }
LcsUnitOfWork >> hasChanges [
	self changedObjects notEmpty ifTrue: [ ^ true ].
	self deletedObjects notEmpty ifTrue: [ ^ true ].
	^ self addedObjects notEmpty
]

{ #category : 'testing' }
LcsUnitOfWork >> hasNoChanges [
	self changedObjects isEmpty ifTrue: [ ^ true ].
	self deletedObjects isEmpty ifTrue: [ ^ true ].
	^ self addedObjects isEmpty
]

{ #category : 'testing' }
LcsUnitOfWork >> hasRemovalRecordFor: aDomainObject [
	^ (self deletedObjects at: aDomainObject ifAbsent: [ nil ]) notNil
]

{ #category : 'testing' }
LcsUnitOfWork >> pendingAddsFor: anItem [
	^ self addedObjects
		select: [ :eachAddRecord | 
			eachAddRecord isMemberOfGlobalCollectionIn: anItem label ]
]

{ #category : 'query' }
LcsUnitOfWork >> pendingDeletesFor: anItem [
	^ self deletedObjects
		select: [ :eachDeletedRecord | 
			eachDeletedRecord isMemberOfGlobalCollectionIn: anItem label ]
]

{ #category : 'api' }
LcsUnitOfWork >> removeAddOf: anObject [
	(self hasAddedRecordFor: anObject) ifFalse: [ ^ self ].
	anObject instVarNamed: 'parent' put: nil.
	self addedObjects removeKey: anObject ifAbsent: [ nil ]
]
