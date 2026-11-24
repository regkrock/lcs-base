Class {
	#name : 'LcsLoginProcess',
	#superclass : 'LcsSupportDomainObject',
	#instVars : [
		'password',
		'email'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsLoginProcess class >> emailSlotDefinition [
	<accessorSlotDefinition>
	^ LcsEmailSlot new
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : 'slot definitions' }
LcsLoginProcess class >> passwordSlotDefinition [
	<accessorSlotDefinition>
	^ LcsPasswordSlot new
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : 'accessing' }
LcsLoginProcess >> email [
	^ self slotVarNamed: 'email'
]

{ #category : 'accessing' }
LcsLoginProcess >> email: anObject [
	self slotVarNamed: 'email' put: anObject
]

{ #category : 'events' }
LcsLoginProcess >> loginUser [
	| user |
	user := (self currentSystem securityModule userWithId: self email) ifNil: [ ^self ].
	(user passwordMatches: self password) ifFalse: [ ^ self ].
	self currentSystem securityModule currentUser: user
		
]

{ #category : 'accessing' }
LcsLoginProcess >> password [
	^ self slotVarNamed: 'password'
]

{ #category : 'accessing' }
LcsLoginProcess >> password: anObject [
	self slotVarNamed: 'password' put: anObject
]
