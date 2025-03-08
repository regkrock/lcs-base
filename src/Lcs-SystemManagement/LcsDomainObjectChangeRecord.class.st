Class {
	#name : #LcsDomainObjectChangeRecord,
	#superclass : #LcsSupportDomainObject,
	#instVars : [
		'userUuid',
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
		makeDirectVariableUpdate;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> createdSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordTimestampSlot new
		slotName: 'created';
		makeDirectVariableUpdate;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsCollectionReferenceSlot new
		slotName: 'parent';
		addSlotType: LcsDomainObjectChangeRecords;
		makeDirectVariableUpdate;
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectChangeRecord class >> userUuidSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordUserUuidSlot new
		makeDirectVariableUpdate;
		yourself
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
LcsDomainObjectChangeRecord >> userUuid [
	^ userUuid
]

{ #category : #accessing }
LcsDomainObjectChangeRecord >> userUuid: anObject [
	userUuid := anObject
]
