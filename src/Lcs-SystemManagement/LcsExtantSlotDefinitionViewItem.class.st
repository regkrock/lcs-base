Class {
	#name : #LcsExtantSlotDefinitionViewItem,
	#superclass : #LcsSlotDefinitionViewItem,
	#instVars : [
		'slotDefinition'
	],
	#category : #'Lcs-SystemManagement-Core'
}

{ #category : #'as yet unclassified' }
LcsExtantSlotDefinitionViewItem class >> on: aSlotDefinition [
	^ self new
		initializeOn: aSlotDefinition;
		yourself
]

{ #category : #'as yet unclassified' }
LcsExtantSlotDefinitionViewItem >> domainClass [
	^ self slotDefinition domainClass
]

{ #category : #'slot definition' }
LcsExtantSlotDefinitionViewItem >> getterSelector [
	^ self slotDefinition getterSelector
]

{ #category : #'instance creation' }
LcsExtantSlotDefinitionViewItem >> initializeOn: aSlotDefinition [ 
	self slotDefinition: aSlotDefinition
]

{ #category : #testing }
LcsExtantSlotDefinitionViewItem >> isAccessorSlot [
	^ self slotDefinition isAccessorSlot
]

{ #category : #testing }
LcsExtantSlotDefinitionViewItem >> isVirtualSlot [
	^ self slotDefinition isVirtualSlot
]

{ #category : #'slot definition' }
LcsExtantSlotDefinitionViewItem >> priority [
	^ self slotDefinition priority
]

{ #category : #'slot model' }
LcsExtantSlotDefinitionViewItem >> remove [
	self domainClass removeDomainSlotNamed: self slotName
]

{ #category : #'slot definition' }
LcsExtantSlotDefinitionViewItem >> setterSelector [
	^ self slotDefinition isVirtualSlot 
		ifTrue: [ 'n/a' ]
		ifFalse: [ self slotDefinition getterSelector ]
]

{ #category : #accessing }
LcsExtantSlotDefinitionViewItem >> slotDefinition [
	^ slotDefinition
]

{ #category : #accessing }
LcsExtantSlotDefinitionViewItem >> slotDefinition: anObject [
	slotDefinition := anObject
]

{ #category : #'as yet unclassified' }
LcsExtantSlotDefinitionViewItem >> slotDefinitionInformation [
	^ self slotDefinition
]

{ #category : #'slot definition' }
LcsExtantSlotDefinitionViewItem >> slotKind [
	^ self slotDefinition slotKind
]

{ #category : #'slot definition' }
LcsExtantSlotDefinitionViewItem >> slotName [
	^ self slotDefinition slotName
]

{ #category : #'slot definition' }
LcsExtantSlotDefinitionViewItem >> slotTypesList [
	^ self slotDefinition slotTypesList
]
