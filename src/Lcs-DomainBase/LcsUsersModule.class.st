Class {
	#name : #LcsUsersModule,
	#superclass : #LcsModule,
	#instVars : [
		'users'
	],
	#category : #'Lcs-DomainBase-Core'
}

{ #category : #configuration }
LcsUsersModule class >> moduleName [
	^ 'Users Module'
]

{ #category : #'slot definition' }
LcsUsersModule class >> usersSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionSlot new
		slotName: 'users';
		addSlotType: LcsUsers;
		collectionClass: IdentitySet;
		addCollectionMemberType: LcsUser;
		yourself
]

{ #category : #accessing }
LcsUsersModule >> users [
	^ self slotVarNamed: 'users'
]

{ #category : #accessing }
LcsUsersModule >> users: anObject [
	self slotVarNamed: 'users' put: anObject
]
