Class {
	#name : #LcsDomainObjectHistory,
	#superclass : #LcsDomainObject,
	#instVars : [
		'created',
		'userid',
		'changeLog'
	],
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot definitions' }
LcsDomainObjectHistory class >> userIdSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'userId';
		beRequired;
		"beReadOnly;"
		yourself
]

{ #category : #'slot definitions' }
LcsDomainObjectHistory class >> userSlotDefinition [
	<slotDefinition>
	^ LcsFacadeSlot new
		slotName: 'user';
		targetSlotName: 'userId';
		convertFromTarget: [ :userId | self accessControlModule userWithId: userId ];
		convertToTarget: [ :user | user userId ];
		"beReadOnly;"
		yourself
]

{ #category : #acccessing }
LcsDomainObjectHistory >> user [
	^ self slotVarNamed: 'user'
]

{ #category : #accessing }
LcsDomainObjectHistory >> user: aUser [
	self slotVarNamed: 'user' put: aUser
]

{ #category : #acccessing }
LcsDomainObjectHistory >> userId [
	^ self slotVarNamed: 'userId'
]

{ #category : #accessing }
LcsDomainObjectHistory >> userId: aString [
	self slotVarNamed: 'userId' put: aString
]
