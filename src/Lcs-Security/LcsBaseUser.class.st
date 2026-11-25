Class {
	#name : 'LcsBaseUser',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'userId',
		'securityRole',
		'password'
	],
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsBaseUser class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsSecurityModule defaultModuleName;
		collectionSlotName: 'users';
		addSlotType: LcsUsers;
		yourself
]

{ #category : 'slot definitions' }
LcsBaseUser class >> passwordSlotDefinition [
	<accessorSlotDefinition>
	^ LcsPasswordSlot new
]

{ #category : 'slot definitions' }
LcsBaseUser class >> securityRoleSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
			slotName: 'securityRole';
			addSlotType: LcsSecurityRole;
			collectionSlotName: 'securityRoles';
			collectionSlotModuleName: 'Security Module';
			yourself
]

{ #category : 'slot definitions' }
LcsBaseUser class >> userIdSlotDefinition [
	<accessorSlotDefinition>
	^ LcsUserIdSlot new
]

{ #category : 'permissions' }
LcsBaseUser >> hasPermissionToReadSlot: aSlotDefinition in: aDomainObject [
	^ true
]

{ #category : 'permissions' }
LcsBaseUser >> hasPermissionToWriteSlot: aSlotDefinition in: aDomainObject [
	^ true
]

{ #category : 'accessing' }
LcsBaseUser >> password [
	^ self slotVarNamed: 'password'
]

{ #category : 'accessing' }
LcsBaseUser >> password: anObject [
	self slotVarNamed: 'password' put: anObject
]

{ #category : 'accessing' }
LcsBaseUser >> securityRole [
	^ self slotVarNamed: 'securityRole'
]

{ #category : 'accessing' }
LcsBaseUser >> securityRole: anObject [
	self slotVarNamed: 'securityRole' put: anObject
]

{ #category : 'accessing' }
LcsBaseUser >> userId [
	^ self slotVarNamed: 'userId'
]

{ #category : 'accessing' }
LcsBaseUser >> userId: anObject [
	self slotVarNamed: 'userId' put: anObject
]

{ #category : 'testing' }
LcsBaseUser >> verifyPassword: aString [
	^ (LcsPasswordHasher verifyPassword: aString againstStoredHash: self password)
]
