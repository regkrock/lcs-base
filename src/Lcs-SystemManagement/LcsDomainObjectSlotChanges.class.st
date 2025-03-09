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
		makeDirectVariableUpdate;
		yourself
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
	| changeRecord |
	changeRecord := 
		LcsDomainObjectSlotChange new
			parent: self;
			slotName: eachSlotDefinition slotName;
			oldValue: nil;
			newValue:  eachSlotDefinition;
			yourself.
	^ self collection at: changeRecord slotName put: changeRecord
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
