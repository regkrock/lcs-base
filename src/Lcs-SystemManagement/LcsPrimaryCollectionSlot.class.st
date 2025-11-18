Class {
	#name : #LcsPrimaryCollectionSlot,
	#superclass : #LcsDomainCollectionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsPrimaryCollectionSlot >> add: aDomainObject [
	self slotTypes do: [ :eachTypeClass | (aDomainObject inheritsFrom: eachTypeClass) ifTrue: [ ^ true ] ]
]

{ #category : #'gt views' }
LcsPrimaryCollectionSlot >> collectionMemberTypesList [
	| stream |
	stream := WriteStream on: String new.
	self collectionMemberTypes 
		do: [ :each | stream nextPutAll: each name ]
		separatedBy: [ stream nextPutAll: '; '].
	^ stream contents
]

{ #category : #initialize }
LcsPrimaryCollectionSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | slot newObjectWithParent: parentDomainObject ]
]

{ #category : #'gt views' }
LcsPrimaryCollectionSlot >> gtSlotDefinitionAttributes [
	| attributes |
	attributes := super gtSlotDefinitionAttributes.
	attributes detect: [ :each | each key = 'collectionClass' ] ifNone: [
		attributes add: 'collectionClass' -> nil].
	^ attributes
		add: 'collectionMemberTypes' -> self collectionMemberTypesList ;
		yourself
]

{ #category : #initialize }
LcsPrimaryCollectionSlot >> initialize [
	super initialize.
	self initialValueBlock: self defaultInitialValueBlock
]

{ #category : #testing }
LcsPrimaryCollectionSlot >> isGlobalCollectionSlot [
	^ true
]

{ #category : #'slot model' }
LcsPrimaryCollectionSlot >> persistValue: anObject contextObject: aContextDomainObject [
	(self _currentSlotVarIn: self slotName asString) persistValue: anObject contextObject: aContextDomainObject
]

{ #category : #'slot model' }
LcsPrimaryCollectionSlot >> persistValue: anObject in: aModule [
	(self _currentSlotVarIn: aModule) add: anObject
]

{ #category : #verification }
LcsPrimaryCollectionSlot >> verifyCollectionItemType: anObject [
	self collectionMemberTypes
		detect: [ :eachClass | anObject isKindOf: eachClass ]
		ifNone: [ self currentUnitOfWork removeAddOf: anObject.
			LcsInvalidSlotTypeError
				signalInvalidType: anObject
				forSlot: self
				for: nil ]
]
