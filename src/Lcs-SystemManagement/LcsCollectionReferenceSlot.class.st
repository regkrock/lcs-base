Class {
	#name : #LcsCollectionReferenceSlot,
	#superclass : #LcsDomainObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #properties }
LcsCollectionReferenceSlot >> collectionSlotName [
	^ self propertyAt: 'collectionSlotName' ifAbsent: [ ]
]

{ #category : #properties }
LcsCollectionReferenceSlot >> collectionSlotName: anObject [
	self propertyAt: 'collectionSlotName' put: anObject
]

{ #category : #'gt views' }
LcsCollectionReferenceSlot >> gtSlotDefinitionAttributes [
	^ super gtSlotDefinitionAttributes
		"add: 'collectionSlotModuleName' -> self collectionSlotModuleName;"
		add: 'collectionSlotName' -> self collectionSlotName;
		yourself
]

{ #category : #'slot model' }
LcsCollectionReferenceSlot >> initializeSlotValueIn: aDomainObject [
	"The global collection is initialized by the module, not from the parent"
]

{ #category : #testing }
LcsCollectionReferenceSlot >> isGlobalCollectionRefenceSlot [
	^ false
]

{ #category : #'slot model' }
LcsCollectionReferenceSlot >> persistValue: aDomainObject contextObject: aContextDomainObject [
	aDomainObject instVarNamed: self slotName put: self targetCollection.
	self collectionSlot persistValue: aDomainObject in: self collectionSlotModule
]

{ #category : #accessing }
LcsCollectionReferenceSlot >> targetCollection [
	^self collectionSlotModule perform: self collectionSlotName asSymbol
]
