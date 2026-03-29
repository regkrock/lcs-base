Class {
	#name : 'LcsUser',
	#superclass : 'LcsBaseUser',
	#instVars : [
		'userid',
		'password',
		'person',
		'securityRole'
	],
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsUser class >> passwordSlotDefinition [
	<accessorSlotDefinition>
	^ LcsPasswordSlot new
]

{ #category : 'slot definitions' }
LcsUser class >> personSlotDefinition [
	<accessorSlotDefinition>
	^ LcsPersonSlot new
			addSlotType: LcsPerson;
			addSlotType: LcsUnknownPerson;
			beAllowInitialNil;
			initialValueBlock: [ :parentDomainObject :slot | nil ];
			required: true;
			yourself
]

{ #category : 'slot definitions' }
LcsUser class >> securityRoleSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
			slotName: 'securityRole';
			addSlotType: LcsSecurityRole;
			collectionSlotName: 'securityRoles';
			collectionSlotModuleName: 'Security Module';
			yourself
]

{ #category : 'slot definitions' }
LcsUser class >> useridSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'userid';
		required: true;
		beAllowInitialNull;
		addValidationRule: (LcsValidationRule new
								conditionBlock: [ :value :domainObject : oldValue | value notEmpty];
								description: 'userid is required');
		yourself
]

{ #category : 'accessing' }
LcsUser >> password [
	^ self slotVarNamed: 'password'
]

{ #category : 'accessing' }
LcsUser >> password: anObject [
	self slotVarNamed: 'password' put: anObject
]

{ #category : 'accessing' }
LcsUser >> person [
	^ self slotVarNamed: 'person'
]

{ #category : 'accessing' }
LcsUser >> person: anObject [
	self slotVarNamed: 'person' put: anObject
]

{ #category : 'accessing' }
LcsUser >> securityRole [
	^ self slotVarNamed: 'securityRole'
]

{ #category : 'accessing' }
LcsUser >> securityRole: anObject [
	self slotVarNamed: 'securityRole' put: anObject
]

{ #category : 'accessing' }
LcsUser >> userid [
	^ self slotVarNamed: 'userid'
]

{ #category : 'accessing' }
LcsUser >> userid: anObject [
	self slotVarNamed: 'userid' put: anObject
]
