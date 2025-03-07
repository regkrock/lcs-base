Class {
	#name : #LcsSecurityModule,
	#superclass : #LcsModule,
	#instVars : [
		'users',
		'currentUser'
	],
	#category : #'Lcs-Security-Core'
}

{ #category : #'slot definition' }
LcsSecurityModule class >> currentUserSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'currentUser';
		collectionSlotName: 'users';
		collectionSlotModuleName: self moduleName;
		initialValueBlock: [ :securityModule | securityModule users superUser ];
		addSlotType: LcsBaseUser;
		yourself
]

{ #category : #configuration }
LcsSecurityModule class >> moduleName [
	^ 'Security Module'
]

{ #category : #configuration }
LcsSecurityModule class >> owningModules [
	<owningModule: 'LcsMainSystem'>
	<owningModule: 'LcsWarRabbitLibrary'>
	<owningModule: 'LxxPrototypeSystem'>
	
]

{ #category : #'slot definitions' }
LcsSecurityModule class >> usersSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'users';
		addSlotType: LcsUsers;
		addCollectionMemberType: LcsBaseUser;
		yourself
]

{ #category : #accessing }
LcsSecurityModule >> currentUser [
	^ self slotVarNamed: 'currentUser' 
]

{ #category : #accessing }
LcsSecurityModule >> currentUser: anObject [
	self slotVarNamed: 'currentUser' put: anObject 
]

{ #category : #security }
LcsSecurityModule >> userWithUuid: aUserUuid [
	^ self users userWithUuid: aUserUuid
]

{ #category : #accessing }
LcsSecurityModule >> users [
	^ self slotVarNamed: 'users' 
]

{ #category : #accessing }
LcsSecurityModule >> users: anObject [
	self slotVarNamed: 'users' put: anObject 
]
