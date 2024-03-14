Class {
	#name : #LcsGlobalCollectionSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsGlobalCollectionSlotDefinition >> beIdentitySetCollection [
	self slotTypes isEmpty ifTrue: [
		self addSlotType: LcsSmalltalkConfiguration identitySetClass.
		^ self ].
	self slotTypes size = 1 ifFalse: [
		(self slotTypes includes: LcsSmalltalkConfiguration identitySetClass) ifTrue: [ ^ self ] ].
	self initializeSlotTypes.
	self addSlotType: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #configuration }
LcsGlobalCollectionSlotDefinition >> clearSlotTypes [
	self initializeSlotTypes.
]

{ #category : #model }
LcsGlobalCollectionSlotDefinition >> persistValue: anObject [
	(self getValueIn: self slotName asString) persistValue: anObject
]

{ #category : #model }
LcsGlobalCollectionSlotDefinition >> persistValue: anObject in: aModule [
	(self getValueIn: aModule) add: anObject
]
