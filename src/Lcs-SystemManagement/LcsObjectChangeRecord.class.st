Class {
	#name : #LcsObjectChangeRecord,
	#superclass : #LcsObject,
	#instVars : [
		'domainObject',
		'parent'
	],
	#category : #'Lcs-SystemManagement-UnitOfWork'
}

{ #category : #accessing }
LcsObjectChangeRecord class >> newFor: aDomainObject parent: anObject [
	^self new
		initializeFor: aDomainObject parent: anObject;
		yourself
]

{ #category : #api }
LcsObjectChangeRecord >> applyChanges [
	self subclassResponsibility
]

{ #category : #system }
LcsObjectChangeRecord >> currentUser [
	^ self system currentUser
]

{ #category : #accessing }
LcsObjectChangeRecord >> domainObject [
	^ domainObject
]

{ #category : #accessing }
LcsObjectChangeRecord >> domainObject: anObject [
	anObject isDomainObject ifFalse: [ self error: 'Not a domain object'].
	domainObject := anObject
]

{ #category : #accessing }
LcsObjectChangeRecord >> gtUnitOfWorkChildren [
	^ LcsUnitOfWorkViewItem newLabel: self viewItemLabel item: self domainObject
]

{ #category : #initialize }
LcsObjectChangeRecord >> initializeFor: aDomainObject parent: anObject [
	self 
		domainObject: aDomainObject;
		parent: anObject
]

{ #category : #accessing }
LcsObjectChangeRecord >> isMemberOfGlobalCollectionIn: aSlotName [
	^ self domainObject isMemberOfGlobalCollectionIn: aSlotName
]

{ #category : #accessing }
LcsObjectChangeRecord >> parent [
	^ parent
]

{ #category : #accessing }
LcsObjectChangeRecord >> parent: anObject [
	parent := anObject
]

{ #category : #system }
LcsObjectChangeRecord >> system [
	^ self parent system
]
