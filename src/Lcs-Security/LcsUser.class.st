Class {
	#name : 'LcsUser',
	#superclass : 'LcsBaseUser',
	#instVars : [
		'userId',
		'password',
		'person',
		'securityRole'
	],
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsUser class >> fullNameSlotDefinition [
	<virtualSlotDefinition>
	^ LcsDelegatorSlot new
			slotName: 'fullName';
			addSlotType: String;
			targetSlotPath: #(#person #fullName) asOrderedCollection;
			yourself
]

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
		initialValueBlock: [ :parentDomainObject :slot | 
			| personClass |
			personClass := LcsObject classNamed: #LcsUnknownPerson.
			(personClass isNil or: [ personClass hasSlotModel not ]) 
				ifTrue: [ nil ]
				ifFalse: [ 
					LcsUnknownPerson new 
						parent: parentDomainObject; 
						yourself ] ];
		required: true;
		comment: 'When bootstrapping, the Legal Entitites module is not necessarily loaded. If not loaded or initialized, the person slot is set to nil. Otherwise it set to a new instance of LcsUnknownPerson'
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
LcsUser class >> userIdSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUserIdSlot new
]

{ #category : 'accessing' }
LcsUser >> fullName [
	^ self slotVarNamed: 'fullName'
]

{ #category : 'accessing' }
LcsUser >> fullName: anObject [
	self slotVarNamed: 'fullName' put: anObject
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
LcsUser >> userId [
	^ self slotVarNamed: 'userId'
]

{ #category : 'accessing' }
LcsUser >> userId: anObject [
	self slotVarNamed: 'userId' put: anObject
]
