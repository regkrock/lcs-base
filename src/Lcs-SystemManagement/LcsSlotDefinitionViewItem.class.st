Class {
	#name : 'LcsSlotDefinitionViewItem',
	#superclass : 'LcsObject',
	#instVars : [
		'slotDefinition'
	],
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'instance creation' }
LcsSlotDefinitionViewItem class >> on: aSlotDefinition [
	^ (self volunteerFor: aSlotDefinition pragmaSelectorBasedOnSlotDefinitionMethod) new
		initializeOn: aSlotDefinition;
		yourself
]

{ #category : 'private' }
LcsSlotDefinitionViewItem class >> volunteerFor: aSlotCategory [
	self allSubclassesDo: [ :eachClass | (eachClass volunteerFor: aSlotCategory) ifTrue: [ ^ eachClass ] ].
	self error: 'No class found'
]

{ #category : 'as yet unclassified' }
LcsSlotDefinitionViewItem >> domainClass [
	^ self slotDefinition domainClass
]

{ #category : 'slot definition' }
LcsSlotDefinitionViewItem >> getterSelector [
	^ self slotDefinition getterSelector
]

{ #category : 'initialize' }
LcsSlotDefinitionViewItem >> initialize [
	super initialize.
]

{ #category : 'initialize' }
LcsSlotDefinitionViewItem >> initializeOn: aSlotDefinition [ 
	self slotDefinition: aSlotDefinition
]

{ #category : 'accessing' }
LcsSlotDefinitionViewItem >> instVarName [
	^ ''
]

{ #category : 'testing' }
LcsSlotDefinitionViewItem >> isAccessorSlot [
	^ false
]

{ #category : 'testing' }
LcsSlotDefinitionViewItem >> isSlotDefinitionFor: anInstVarName [
	^ false
]

{ #category : 'testing' }
LcsSlotDefinitionViewItem >> isVirtualSlot [
	^ false
]

{ #category : 'slot definition' }
LcsSlotDefinitionViewItem >> pragmaSelectorBasedOnSlotDefinitionMethod [
	^ self slotDefinition pragmaSelector
]

{ #category : 'slot definition' }
LcsSlotDefinitionViewItem >> priority [
	^ self slotDefinition priority
]

{ #category : 'slot definition' }
LcsSlotDefinitionViewItem >> slotClass [
	^ self slotDefinition class
]

{ #category : 'accessing' }
LcsSlotDefinitionViewItem >> slotDefinition [
	^ slotDefinition
]

{ #category : 'accessing' }
LcsSlotDefinitionViewItem >> slotDefinition: anObject [
	slotDefinition := anObject
]

{ #category : 'as yet unclassified' }
LcsSlotDefinitionViewItem >> slotDefinitionInformation [
	^ self slotDefinition
]

{ #category : 'slot definition' }
LcsSlotDefinitionViewItem >> slotKind [
	^ self slotDefinition slotKind
]

{ #category : 'slot definition' }
LcsSlotDefinitionViewItem >> slotName [
	^ self slotDefinition slotName
]

{ #category : 'slot definition' }
LcsSlotDefinitionViewItem >> slotTypesList [
	^ self slotDefinition slotTypesList
]
