Class {
	#name : #LcsInstanceInLocalCollectionSlot,
	#superclass : #LcsMemberOfCollectionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsInstanceInLocalCollectionSlot >> _currentSlotVarIn: aDomainObject [
	^ (aDomainObject perform: self collectionSlotName asSymbol)
		findItemMatchingAddressType: self typeCode
]

{ #category : #properties }
LcsInstanceInLocalCollectionSlot >> collectionSlotName [
	^ self propertyAt: 'collectionSlotName' ifAbsent: []
]

{ #category : #properties }
LcsInstanceInLocalCollectionSlot >> collectionSlotName: aString [ 
	self propertyAt: 'collectionSlotName' put: aString
]

{ #category : #defaults }
LcsInstanceInLocalCollectionSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | 
	(parentDomainObject perform: self collectionSlotName asSymbol)
		findItemMatchingAddressType: slot typeCode ]
]

{ #category : #'slot model' }
LcsInstanceInLocalCollectionSlot >> hasPermissionToWriteSlotOf: aDomainObject [
	self securityModule
		ifNotNil: [ :securityModule | securityModule hasPermissionToAddToSlot: (aDomainObject perform: self collectionSlotName asSymbol) in: aDomainObject ]
]

{ #category : #asking }
LcsInstanceInLocalCollectionSlot >> targetCollectionIn: aDomainObject [
	^ aDomainObject perform: self collectionSlotName asSymbol
]

{ #category : #properties }
LcsInstanceInLocalCollectionSlot >> typeCode [
	^ self propertyAt: 'typeCode' ifAbsent: [ '' ]
]

{ #category : #properties }
LcsInstanceInLocalCollectionSlot >> typeCode: aString [ 
	self propertyAt: 'typeCode' put: aString
]

{ #category : #'slot model' }
LcsInstanceInLocalCollectionSlot >> updateVariableIn: aDomainObject oldValue: anExistingObject with: aTransformedObject [
	self currentUnitOfWork
		addPendingAddOf: aTransformedObject
		to: (self targetCollectionIn: aDomainObject)
]
