Class {
	#name : #LcsExtantSlotDefinitionViewItem,
	#superclass : #LcsAccessorSlotDefinitionViewItem,
	#category : #'Lcs-SystemManagement-Core'
}

{ #category : #initialize }
LcsExtantSlotDefinitionViewItem >> initializeOn: aSlotDefinition [ 
	super initializeOn: aSlotDefinition.
	self instVarName: (
		(self domainClass allInstVarNames includes: self slotName)
			ifTrue: [  self slotName ]
			ifFalse: [ '***missing***' ])
]

{ #category : #testing }
LcsExtantSlotDefinitionViewItem >> isAccessorSlot [
	^ self slotDefinition isAccessorSlot
]

{ #category : #testing }
LcsExtantSlotDefinitionViewItem >> isSlotDefinitionFor: anInstVarName [
	^ self slotName asString = anInstVarName asString
]

{ #category : #testing }
LcsExtantSlotDefinitionViewItem >> isVirtualSlot [
	^ self slotDefinition isVirtualSlot
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
