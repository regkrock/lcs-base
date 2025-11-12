Class {
	#name : #LcsSecurityModule,
	#superclass : #LcsModule,
	#instVars : [
		'users',
		'currentUser',
		'securityRoles'
	],
	#category : #'Lcs-Security-Core'
}

{ #category : #'slot definitions' }
LcsSecurityModule class >> configurationSlotDefinition [
	<slotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
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
	<owningModule: 'LcsSailingClub' priority: 1>
]

{ #category : #'slot definitions' }
LcsSecurityModule class >> securityRolesSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'securityRoles';
		addSlotType: LcsSecurityRoles;
		addCollectionMemberType: LcsSecurityRole;
		loaderClass: LcsSecurityRolesLoader;
		yourself
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
LcsSecurityModule >> hasPermissionToReadSlot: aSlotDefinition in: aDomainObject [ 
	^ true
]

{ #category : #security }
LcsSecurityModule >> hasPermissionToWriteSlot: aSlotDefinition in: aDomainObject [ 
	^ true
]

{ #category : #accessing }
LcsSecurityModule >> securityRoles [
	^ self slotVarNamed: 'securityRoles' 
]

{ #category : #accessing }
LcsSecurityModule >> securityRoles: anObject [
	self slotVarNamed: 'securityRoles' put: anObject 
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
