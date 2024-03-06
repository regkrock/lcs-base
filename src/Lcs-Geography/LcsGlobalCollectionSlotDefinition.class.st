Class {
	#name : #LcsGlobalCollectionSlotDefinition,
	#superclass : #LcsSlotDefinition,
	#category : #'Lcs-Geography'
}

{ #category : #accessing }
LcsGlobalCollectionSlotDefinition >> beIdentitySetCollection [
	self slotTypes isEmpty ifTrue: [
		self addSlotType: LcsSmalltalkConfiguration identitySetClass.
		^self].
	self slotTypes size = 1 ifFalse: [
		(self slotTypes includes: LcsSmalltalkConfiguration identitySetClass) ifTrue: [^self]].
	self initializeSlotTypes.
	self addSlotType: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #accessing }
LcsGlobalCollectionSlotDefinition >> clearSlotTypes [
	self initializeSlotTypes.
]

{ #category : #accessing }
LcsGlobalCollectionSlotDefinition >> persistValue: anObject [
	(self getValueIn: self slotName asString) persistValue: anObject
]

{ #category : #accessing }
LcsGlobalCollectionSlotDefinition >> persistValue: anObject in: aModule [
	(self getValueIn: aModule) add: anObject
]
