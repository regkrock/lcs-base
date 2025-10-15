Class {
	#name : #LcsSecurityModule,
	#superclass : #LcsModule,
	#instVars : [
		'users',
		'currentUser'
	],
	#category : #'Lcs-Security-Core'
}

{ #category : #'slot definitions' }
LcsSecurityModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: self moduleConfigurationClass
]

{ #category : #'slot definitions' }
LcsSecurityModule class >> currentUserSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotName: 'currentUser';
		collectionSlotName: 'users';
		collectionSlotModuleName: self defaultModuleName;
		initialValueBlock: [ :securityModule | securityModule users superUser ];
		addSlotType: LcsBaseUser;
		priority: 60;
		yourself
]

{ #category : #configuration }
LcsSecurityModule class >> defaultModuleName [
	^ 'Security Module'
]

{ #category : #configuration }
LcsSecurityModule class >> moduleConfigurationClass [
	^ LcsSecurityModuleConfiguration
]

{ #category : #configuration }
LcsSecurityModule class >> owningModules [
	<owningModule: 'LcsMainSystem' priority: 1>
	<owningModule: 'LcsWarRabbitLibrary' priority: 1>
	<owningModule: 'LxxPrototypeSystem' priority: 1>
	
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
