Class {
	#name : 'LcsTableColumnDefinition',
	#superclass : 'LcsTableDefinitionObject',
	#instVars : [
		'slotName',
		'label',
		'justification'
	],
	#category : 'Lcs-SystemManagement-Domain',
	#package : 'Lcs-SystemManagement',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsTableColumnDefinition class >> justificationSlotDefinition [
	<accessorSlotDefinition>
	^ LcsMemberOfGlobalCollectionSlot new
		addSlotType: LcsJustification;
		slotName: 'justification';
		collectionSlotName: 'justifications';
		collectionSlotModuleName: LcsSystemSupportModule defaultModuleName;
		prevalidationTransformBlock: [ :value :slot | slot targetCollection findWithKey: value ifNone: [ value ] ]
		yourself
]

{ #category : 'slot definitions' }
LcsTableColumnDefinition class >> labelSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'label';
		required: true;
		yourself
]

{ #category : 'instance creation' }
LcsTableColumnDefinition class >> newOn: aSlotDefinition [
	^ self new
		initializeOn: aSlotDefinition;
		yourself
]

{ #category : 'slot definitions' }
LcsTableColumnDefinition class >> slotNameSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'slotName';
		required: true;
		yourself
]

{ #category : 'commands' }
LcsTableColumnDefinition >> beCentered [
	self justification: 'center'
]

{ #category : 'commands' }
LcsTableColumnDefinition >> beLeftJustified [
	self justification: 'left'
]

{ #category : 'commands' }
LcsTableColumnDefinition >> beRightJustified [
	self justification: 'right'
]

{ #category : 'instance creation' }
LcsTableColumnDefinition >> initializeOn: aSlotDefinition [ 
	self slotName: aSlotDefinition slotName.
	self label: aSlotDefinition label
]

{ #category : 'testing' }
LcsTableColumnDefinition >> isCenterJustified [
	^ self justification code = 'center'
]

{ #category : 'testing' }
LcsTableColumnDefinition >> isLeftJustified [
	^ self justification code = 'left'
]

{ #category : 'testing' }
LcsTableColumnDefinition >> isRightJustified [
	^ self justification code = 'right'
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> justification [
	^ self slotVarNamed: 'justification'
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> justification: anObject [
	self slotVarNamed: 'justification' put: anObject
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> label [
	^ self slotVarNamed: 'label'
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> label: anObject [
	self slotVarNamed: 'label' put: anObject
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> slotName [
	^ self slotVarNamed: 'slotName'
]

{ #category : 'accessing' }
LcsTableColumnDefinition >> slotName: anObject [
	self slotVarNamed: 'slotName' put: anObject
]
