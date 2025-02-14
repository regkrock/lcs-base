Class {
	#name : #LcsDomainObjectChangeRecord,
	#superclass : #LcsSupportDomainObject,
	#instVars : [
		'userId',
		'created',
		'changes'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'application environment' }
LcsDomainObjectChangeRecord class >> addToUnitOfWork: newObject [
	"this is not saved in the Unit of Work as it is part of the unit of work"
]

{ #category : #'slot definition' }
LcsDomainObjectChangeRecord class >> changesSlotDefinition [
	<slotDefinition>
	^ LcsOrderedCollectionSlot new
		slotName: 'changes';
		yourself
]

{ #category : #'slot definition' }
LcsDomainObjectChangeRecord class >> createdSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordTimestampSlot new
		slotName: 'created';
		yourself
]

{ #category : #'instance  creation' }
LcsDomainObjectChangeRecord class >> new [ 
	self traceCr: ' new ' , self name.
	^ super new
]

{ #category : #'slot definition' }
LcsDomainObjectChangeRecord class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsCollectionReferenceSlot new
		slotName: 'parent';
		addSlotType: LcsDomainObjectChangeRecords
		yourself
]

{ #category : #'slot definition' }
LcsDomainObjectChangeRecord class >> userIdSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordUserIdSlot new
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> changes [
	^ changes
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> changes: anObject [
	changes := anObject
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> created [
	^ created
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> created: anObject [
	created := anObject
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> userId [
	^ userId
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> userId: anObject [
	userId := anObject
]
