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

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> changesSlotDefinition [
	<slotDefinition>
	^ LcsOrderedCollectionSlot new
		slotName: 'changes';
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> createdSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordTimestampSlot new
		slotName: 'created';
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsCollectionReferenceSlot new
		slotName: 'parent';
		addSlotType: LcsDomainObjectChangeRecords
		yourself
]

{ #category : #'slot definitions' }
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
