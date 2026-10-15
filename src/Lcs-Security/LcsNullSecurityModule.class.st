Class {
	#name : 'LcsNullSecurityModule',
	#superclass : 'LcsBaseSecurityModule',
	#instVars : [
		'users',
		'currentUser',
		'securityRoles'
	],
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsNullSecurityModule class >> configurationSlotDefinition [
	<accessorSlotDefinition>
	^ self configurationSlotDefinitionOn: self moduleConfigurationClass
]

{ #category : 'slot definitions' }
LcsNullSecurityModule class >> currentUserSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		slotName: 'currentUser';
		collectionSlotName: 'users';
		collectionSlotModuleName: self defaultModuleName;
		initialValueBlock: [ :securityModule | securityModule users superUser ];
		addSlotType: LcsBaseUser;
		priority: 60;
		yourself
]

{ #category : 'configuration' }
LcsNullSecurityModule class >> defaultModuleName [
	^ 'Security Module'
]

{ #category : 'configuration' }
LcsNullSecurityModule class >> moduleConfigurationClass [
	^ LcsSecurityModuleConfiguration
]

{ #category : 'slot definitions' }
LcsNullSecurityModule class >> securityRolesSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'securityRoles';
		addSlotType: LcsSecurityRoles;
		addCollectionMemberType: LcsSecurityRole;
		loaderClass: LcsSecurityRolesLoader;
		yourself
]

{ #category : 'slot definitions' }
LcsNullSecurityModule class >> usersSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'users';
		addSlotType: LcsUsers;
		addCollectionMemberType: LcsBaseUser;
		yourself
]

{ #category : 'accessing' }
LcsNullSecurityModule >> currentUser [
	^ self slotVarNamed: 'currentUser' 
]

{ #category : 'accessing' }
LcsNullSecurityModule >> currentUser: anObject [
	self slotVarNamed: 'currentUser' put: anObject 
]

{ #category : 'security' }
LcsNullSecurityModule >> hasPermissionToAddToSlot: aSlotDefinition in: aDomainObject [ 
	^ true
]

{ #category : 'security' }
LcsNullSecurityModule >> hasPermissionToReadSlot: aSlotDefinition in: aDomainObject [ 
	^ true
]

{ #category : 'security' }
LcsNullSecurityModule >> hasPermissionToWriteSlot: aSlotDefinition in: aDomainObject [ 
	^ true
]

{ #category : 'accessing' }
LcsNullSecurityModule >> securityRoles [
	^ self slotVarNamed: 'securityRoles' 
]

{ #category : 'accessing' }
LcsNullSecurityModule >> securityRoles: anObject [
	self slotVarNamed: 'securityRoles' put: anObject 
]

{ #category : 'security' }
LcsNullSecurityModule >> userWithUuid: aUserUuid [
	^ self users userWithUuid: aUserUuid
]

{ #category : 'accessing' }
LcsNullSecurityModule >> users [
	^ self slotVarNamed: 'users' 
]

{ #category : 'accessing' }
LcsNullSecurityModule >> users: anObject [
	self slotVarNamed: 'users' put: anObject 
]
