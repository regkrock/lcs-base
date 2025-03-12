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
		convertFromTarget: [ :userUuid | self currentSystem securityModule userWithUuid: userUuid ];
		convertToTarget: [ :user | user uuid ];
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectHistory class >> userUuidSlotDefinition [
	<slotDefinition>
	^ LcsChangeRecordUserUuidSlot new
		makeDirectVariableUpdate;
		yourself
]

{ #category : #'as yet unclassified' }
LcsDomainObjectHistory >> addChangesTo: aChangeRecord [ 
	self domainObject allSlotDefinitions
		do: [ :eachSlotDefinition | aChangeRecord createInitialSlotChangeFor: eachSlotDefinition ]
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

{ #category : #history }
LcsDomainObjectHistory >> creationDate [
	^ self created asDate
]

{ #category : #history }
LcsDomainObjectHistory >> creationTimestamp [
	^ self created
]

{ #category : #'domain object' }
LcsDomainObjectHistory >> domainObject [
	^ self parent
]

{ #category : #history }
LcsDomainObjectHistory >> lastUpdatedDate [
	^ self creationDate
]

{ #category : #history }
LcsDomainObjectHistory >> lastUpdatedTimestamp [
	^ self created
]

{ #category : #'as yet unclassified' }
LcsDomainObjectHistory >> newChangeRecord [
	^ self changeRecords newChangeRecord
]

{ #category : #'as yet unclassified' }
LcsDomainObjectHistory >> recordChanges [
	self changeRecords hasNoElements
		ifTrue: [ LcsError
				signal: 'Attempt to record changes to an object that has not been created' ].
	self newChangeRecord
		userUuid: self parent currentUser uuid;
		addChanges
]

{ #category : #'as yet unclassified' }
LcsDomainObjectHistory >> recordSlotChanges [
	self changeRecords hasElements 
		ifTrue: [ LcsError signal: 'Attempt to record creation when it has already been recorded' ].
	self userUuid: self parent currentUser uuid.
	self user: self parent currentUser.
	"self addChangesTo: self newChangeRecord"
]

{ #category : #accessing }
LcsDomainObjectHistory >> user [
	^ self slotVarNamed: 'user'
]

{ #category : #accessing }
LcsDomainObjectHistory >> user: aUser [
	self slotVarNamed: 'user' put: aUser
]

{ #category : #accessing }
LcsDomainObjectHistory >> userUuid [
	^ self slotVarNamed: 'userUuid'
]

{ #category : #accessing }
LcsDomainObjectHistory >> userUuid: aString [
	self slotVarNamed: 'userUuid' put: aString
]
