Class {
	#name : 'LcsDomainObjectChangeRecord',
	#superclass : 'LcsSupportDomainObject',
	#instVars : [
		'userUuid',
		'created',
		'changes'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsDomainObjectChangeRecord class >> changesSlotDefinition [
	<accessorSlotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'changes';
		addSlotType: LcsDomainObjectSlotChanges;
		addCollectionMemberType: LcsDomainObjectSlotChange;
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : 'slot definitions' }
LcsDomainObjectChangeRecord class >> createdSlotDefinition [
	<accessorSlotDefinition>
	^ LcsChangeRecordTimestampSlot new
		slotName: 'created';
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : 'slot definitions' }
LcsDomainObjectChangeRecord class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsCollectionReferenceSlot new
		slotName: 'parent';
		addSlotType: LcsDomainObjectChangeRecords;
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : 'slot definitions' }
LcsDomainObjectChangeRecord class >> userSlotDefinition [
	<facadeSlotDefinition>
	^ LcsUserToUserIdConversionSlot new
]

{ #category : 'slot definitions' }
LcsDomainObjectChangeRecord class >> userUuidSlotDefinition [
	<accessorSlotDefinition>
	^ LcsChangeRecordUserUuidSlot new
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : 'as yet unclassified' }
LcsDomainObjectChangeRecord >> addOriginalValueFor: aSlotName [
	self createInitialSlotChangeFor: (self domainObject slotDefinitionNamed: aSlotName) 
]

{ #category : 'history' }
LcsDomainObjectChangeRecord >> addSlotChangesOf: aSlotName to: slotChangeHistory [
	self changes addSlotChangesOf: aSlotName to: slotChangeHistory
]

{ #category : 'history' }
LcsDomainObjectChangeRecord >> changeForSlot: aSlotName [
	^ self changes changeForSlot: aSlotName
]

{ #category : 'accessing' }
LcsDomainObjectChangeRecord >> changes [
	^ changes
]

{ #category : 'accessing' }
LcsDomainObjectChangeRecord >> changes: anObject [
	changes := anObject
]

{ #category : 'history saving' }
LcsDomainObjectChangeRecord >> createInitialSlotChangeFor: eachSlotDefinition [ 
	self changes createInitialSlotChangeFor: eachSlotDefinition 
]

{ #category : 'accessing' }
LcsDomainObjectChangeRecord >> created [
	^ created
]

{ #category : 'accessing' }
LcsDomainObjectChangeRecord >> created: anObject [
	created := anObject
]

{ #category : 'domain object' }
LcsDomainObjectChangeRecord >> domainObject [
	^ self parent domainObject
]

{ #category : 'history' }
LcsDomainObjectChangeRecord >> domainObjectHistory [
	^ self parent domainObjectHistory
]

{ #category : 'testing' }
LcsDomainObjectChangeRecord >> hasChangeHistoryFor: aSlotName [
	^ self changes hasChangeHistoryFor: aSlotName
]

{ #category : 'accessing' }
LcsDomainObjectChangeRecord >> user [
	^ self slotVarNamed: 'user'
]

{ #category : 'accessing' }
LcsDomainObjectChangeRecord >> user: aUser [
	self slotVarNamed: 'user' put: aUser
]

{ #category : 'accessing' }
LcsDomainObjectChangeRecord >> userUuid [
	^ userUuid
]

{ #category : 'accessing' }
LcsDomainObjectChangeRecord >> userUuid: anObject [
	userUuid := anObject
]
