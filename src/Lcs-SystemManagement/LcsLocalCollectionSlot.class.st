Class {
	#name : 'LcsLocalCollectionSlot',
	#superclass : 'LcsDomainCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'slot model' }
LcsLocalCollectionSlot >> add: anObject to: aDomainObject [
	(aDomainObject perform: self slotName asSymbol) add: anObject.
	self hasDependentCollection ifTrue: [
		self dependentCollection add: aDomainObject ]
]

{ #category : 'slot model' }
LcsLocalCollectionSlot >> dependentCollection [
	^ (self currentSystem moduleNamed: self dependentGlobalCollectionModuleName)
		perform: self dependentGlobalCollectionSlotName asSymbol
]

{ #category : 'properites' }
LcsLocalCollectionSlot >> dependentGlobalCollectionModuleName [
	^ self propertyAt: 'dependentGlobalCollectionModuleName' ifAbsent: [ nil ]
]

{ #category : 'properites' }
LcsLocalCollectionSlot >> dependentGlobalCollectionModuleName: aString [
	^ self propertyAt: 'dependentGlobalCollectionModuleName' put: aString
]

{ #category : 'properites' }
LcsLocalCollectionSlot >> dependentGlobalCollectionSlotName [
	^ self propertyAt: 'dependentGlobalCollectionSlotName' ifAbsent: [ nil ]
]

{ #category : 'properites' }
LcsLocalCollectionSlot >> dependentGlobalCollectionSlotName: aString [
	^ self propertyAt: 'dependentGlobalCollectionSlotName' put: aString
]

{ #category : 'slot model' }
LcsLocalCollectionSlot >> hasDependentCollection [
	^ self dependentGlobalCollectionModuleName notNil and: [ self dependentGlobalCollectionSlotName notNil ]
]

{ #category : 'testing' }
LcsLocalCollectionSlot >> isLocalCollectionSlot [
	^ true
]

{ #category : 'testing' }
LcsLocalCollectionSlot >> slotVarPut: anObject in: aDomainObject [
	super slotVarPut: anObject in: aDomainObject.
	self currentUnitOfWork changedCollections 
]
