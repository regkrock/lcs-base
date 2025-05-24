"
This is used to define a global collection slot. All of the items stored in this collection are rooted in this collection.
"
Class {
	#name : #LcsGlobalCollectionSlot,
	#superclass : #LcsPrimaryCollectionSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'as yet unclassified' }
LcsGlobalCollectionSlot >> add: aDomainObject [
	self slotTypes do: [ :eachTypeClass | (aDomainObject inheritsFrom: eachTypeClass) ifTrue: [ ^ true ] ]
]

{ #category : #'gt views' }
LcsGlobalCollectionSlot >> collectionMemberTypesList [
	| stream |
	stream := WriteStream on: String new.
	self collectionMemberTypes 
		do: [ :each | stream nextPutAll: each name ]
		separatedBy: [ stream nextPutAll: '; '].
	^ stream contents
]

{ #category : #'gt views' }
LcsGlobalCollectionSlot >> gtSlotDefinitionAttributes [
	^ super gtSlotDefinitionAttributes
		add: 'collectionClass' -> (self collectionClass ifNil: [ '<undefined>' ] ifNotNil: [ self collectionClass name]);
		add: 'collectionMemberTypes' -> self collectionMemberTypesList ;
		yourself
]

{ #category : #'as yet unclassified' }
LcsGlobalCollectionSlot >> initialize [ 
	super initialize.
	self initialValueBlock: [ :parentDomainObject :slotDefinition | slotDefinition newObjectWithParent: parentDomainObject ]
]

{ #category : #accessing }
LcsGlobalCollectionSlot >> isGlobalCollectionSlot [
	^ true
]

{ #category : #'slot model' }
LcsGlobalCollectionSlot >> persistValue: anObject contextObject: aContextDomainObject [
	(self currentSlotVarIn: self slotName asString) persistValue: anObject contextObject: aContextDomainObject
]

{ #category : #'slot model' }
LcsGlobalCollectionSlot >> persistValue: anObject in: aModule [
	(self currentSlotVarIn: aModule) add: anObject
]

{ #category : #'as yet unclassified' }
LcsGlobalCollectionSlot >> verifyCollectionItemType: anObject [
	self collectionMemberTypes
		detect: [ :eachClass | anObject isKindOf: eachClass ]
		ifNone: [ self currentUnitOfWork removeAddOf: anObject.
			LcsInvalidSlotTypeError
				signalInvalidType: anObject
				forSlot: self
				for: nil ]
]
