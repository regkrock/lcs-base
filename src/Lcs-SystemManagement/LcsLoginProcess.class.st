Class {
	#name : 'LcsLoginProcess',
	#superclass : 'LcsSupportDomainObject',
	#instVars : [
		'password',
		'userId'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsLoginProcess class >> passwordSlotDefinition [
	<accessorSlotDefinition>
	^ LcsPasswordSlot new
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : 'slot definitions' }
LcsLoginProcess class >> userIdSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'userId';
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : 'events' }
LcsLoginProcess >> loginUser [
	| user |
	user := (self currentSystem securityModule userWithId: self userId) ifNil: [ ^ false ].
	(user verifyPassword: self password) ifFalse: [ ^ false ].
	self currentSystem currentUser: user.
	^ true
]

{ #category : 'accessing' }
LcsLoginProcess >> password [
	^ self slotVarNamed: 'password'
]

{ #category : 'accessing' }
LcsLoginProcess >> password: anObject [
	self slotVarNamed: 'password' put: anObject
]

{ #category : 'accessing' }
LcsLoginProcess >> userId [
	^ self slotVarNamed: 'userId'
]

{ #category : 'accessing' }
LcsLoginProcess >> userId: anObject [
	self slotVarNamed: 'userId' put: anObject
]
