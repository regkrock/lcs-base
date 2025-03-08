"
This has the following information:
1) Created timestamp.
2) User who created the instance of a domain object.
3) Change Log - this is a log of all changes. For each change a new change log is created.
"
Class {
	#name : #LcsDomainObjectHistory,
	#superclass : #LcsSupportDomainObject,
	#instVars : [
		'created',
		'userUuid',
		'changeRecords'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot definitions' }
LcsDomainObjectHistory class >> changeRecordsSlotDefinition [
	<slotDefinition>
	^ LcsLocalCollectionSlot new
		slotName: 'changeRecords';
		addSlotType: LcsDomainObjectChangeRecords;
		addCollectionMemberType: LcsDomainObjectChangeRecord;
		beRequired;
		makeDirectVariableUpdate;
		"beReadOnly;"
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectHistory class >> createdSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordTimestampSlot new
		slotName: 'created';
		beRequired;
		makeDirectVariableUpdate;
		"beReadOnly;"
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectHistory class >> userSlotDefinition [
	<facadeSlotDefinition>
	^ LcsFacadeSlot new
		slotName: 'user';
		targetSlotName: 'userUuid';
		convertFromTarget: [ :userUuid | self accessControlModule userWithUuid: userUuid ];
		convertToTarget: [ :user | user userUuid ];
		"beReadOnly;"
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectHistory class >> userUuidSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordUserUuidSlot new
		makeDirectVariableUpdate;
		yourself
]

{ #category : #accessing }
LcsDomainObjectHistory >> changeRecords [
	^ self slotVarNamed: 'changeRecords'
]

{ #category : #accessing }
LcsDomainObjectHistory >> changeRecords: anObject [
	self slotVarNamed: 'changeRecords' put: anObject
]

{ #category : #accessing }
LcsDomainObjectHistory >> created [
	^ self slotVarNamed: 'created'
]

{ #category : #accessing }
LcsDomainObjectHistory >> created: anObject [
	self slotVarNamed: 'created' put: anObject
]

{ #category : #accessing }
LcsDomainObjectHistory >> userUuid [
	^ self slotVarNamed: 'userUuid'
]

{ #category : #accessing }
LcsDomainObjectHistory >> userUuid: aString [
	self slotVarNamed: 'userUuid' put: aString
]
