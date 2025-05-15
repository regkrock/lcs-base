Class {
	#name : #LcsDomainObjectSlotChanges,
	#superclass : #LcsSupportDomainObject,
	#traits : 'LtDictionaryDomainCollection',
	#classTraits : 'LtDictionaryDomainCollection classTrait',
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'slot definition\t' }
LcsDomainObjectSlotChanges class >> collectionSlotDefinition [
	<slotDefinition>
	^ LcsDictionarySlot new
		makeDirectUpdateOfVariable;
		yourself
]

{ #category : #testing }
LcsDomainObjectSlotChanges >> addSlotChangesOf: aSlotName to: slotChangeHistory [
	(self collection at: aSlotName ifAbsent: [ ^ self ])
		addSlotChangesOf: aSlotName to: slotChangeHistory

]

{ #category : #accessing }
LcsDomainObjectSlotChanges >> collection [
	^ self slotVarNamed: 'collection'
]

{ #category : #accessing }
LcsDomainObjectSlotChanges >> collection: aCollection [
	self slotVarNamed: 'collection' put: aCollection
]

{ #category : #'as yet unclassified' }
LcsDomainObjectSlotChanges >> createInitialSlotChangeFor: eachSlotDefinition [
	| changeRecord newObject |
	newObject := eachSlotDefinition persistedSlotVarIn: self domainObject.
	(newObject isDomainObject and: [ newObject isSupportDomainObject ])
		ifTrue: [ ^ self ].
	changeRecord := LcsDomainObjectSlotChange new
			parent: self;
			slotName: eachSlotDefinition slotName;
			newValue: (eachSlotDefinition changeHistoryRepresentationIn: newObject);
			yourself.
	^ self collection at: changeRecord slotName put: changeRecord
]

{ #category : #history }
LcsDomainObjectSlotChanges >> created [
	^ self parent created
]

{ #category : #'as yet unclassified' }
LcsDomainObjectSlotChanges >> domainObject [
	^ self parent domainObject
]

{ #category : #'as yet unclassified' }
LcsDomainObjectSlotChanges >> domainObjectHistory [
	^ self parent domainObjectHistory
]

{ #category : #testing }
LcsDomainObjectSlotChanges >> hasChangeHistoryFor: aSlotName [
	^ (self collection at: aSlotName ifAbsent: [ nil ]) notNil
]

{ #category : #'as yet unclassified' }
LcsDomainObjectSlotChanges >> newSlotChangeRecord: aSlotName [
	^ self collection at: aSlotName put: (
		LcsDomainObjectSlotChange new
			parent: self;
			slotName: aSlotName;
			yourself)
]

{ #category : #'as yet unclassified' }
LcsDomainObjectSlotChanges >> nexSlotChangeRecord [
	| changeRecord |
	changeRecord := 
		LcsDomainObjectSlotChange new
			parent: self;
			yourself.
	self collection add: changeRecord.
	^ changeRecord
]
