Class {
	#name : 'LcsDeprecatedSlot',
	#superclass : 'LcsDomainSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'properties' }
LcsDeprecatedSlot >> changedSlotRecordFor: aDomainObject [
	^ nil
]

{ #category : 'defaults' }
LcsDeprecatedSlot >> defaultPragmaSelector [
	^'accessorSlotDefinition'
]

{ #category : 'initialize' }
LcsDeprecatedSlot >> initializeSlotValueIn: aDomainObject [
	"do nothing for the null sllot"
]

{ #category : 'testing' }
LcsDeprecatedSlot >> isLocalCollectionSlot [
	^ false
]

{ #category : 'properties' }
LcsDeprecatedSlot >> persistedSlotVarIn: aDomainObject [
	^'deprecated slot'
]

{ #category : 'slot model' }
LcsDeprecatedSlot >> slotVarNamed: anObject in: aDomainObject [
	LcsSlotUpdateNotAllowedError signal:  'This is a read only slot'
]
