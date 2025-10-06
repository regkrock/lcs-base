Class {
	#name : #LcsInvalidSlotTypeError,
	#superclass : #LcsSlotModelError,
	#instVars : [
		'object',
		'slotDefinition',
		'target'
	],
	#category : #'Lcs-SystemManagement-Error'
}

{ #category : #'instance  creation' }
LcsInvalidSlotTypeError class >> signalInvalidType: anObject forSlot: aSlotDefinition for: aDomainObject [
	self new
		signalInvalidType: anObject
		forSlot: aSlotDefinition
		for: aDomainObject
]

{ #category : #signal }
LcsInvalidSlotTypeError >> domainClassName [
	^ self slotDefinition domainClass name
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> gtNewValueViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'New Value';
		priority: 20;
		object: [ self object ];
		view: #gtRawFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect ' , self object printString
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: self object ];
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse ' , self object class name
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: self object class ]
		"view: #gtViewsFor:"
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> gtSlotAttributesViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Slot Attributes';
		priority: 15;
		object: [ self slotDefinition ];
		view: #gtSlotAttributesViewFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect ' , self slotDefinition printString
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: self slotDefinition ];
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse ' , self slotDefinition class name
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: self slotDefinition class ]

]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> gtSlotDefinitionMethods: aView [
	<gtView>
	<gtExceptionView>
	^ aView explicit
		title: 'Slot Definition Method' translated;
		priority: 16;
		stencil: [  GtPharoMethodsCoder forItems: self slotDefinitionMethods ];
		actionButtonIcon: BrGlamorousVectorIcons repair 
			tooltip: 'Install ' , self slotName , ' Slot Definition'
			action: [ :aButton :aTab | self reinstallSlotDefinition ]

]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> gtSlotTypesViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Valid Slot Types';
		priority: 15.5;
		object: [ slotDefinition ];
		view: #gtSlotTypesViewFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect ' , self slotDefinition printString
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: self slotDefinition ];
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse ' , self slotDefinition class name
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: self slotDefinition class ];
		actionUpdateButton
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> gtTargetViewsFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Target';
		priority: 20;
		object: [ self target ];
		view: #gtRawFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			tooltip: 'Inspect ' , self target printString
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: self target ];
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse ' , self target class name
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: self target class ]
		"view: #gtViewsFor:"
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> gtUpdateSlotModelFor: anAction [
	<gtAction>
	^ anAction button
		priority: 11;
		tooltip: 'Update Slot Model';
		icon: BrGlamorousVectorIcons play;
		action: [ :aButton | self reinstallSlotDefinition ]
]

{ #category : #signal }
LcsInvalidSlotTypeError >> invalidAuditMessage [
	^ self slotName printString , '  slot("'
		, self slotDefinition class name , '") in '
		, self slotDefinition domainClass name , ' contains invalid: ' , self object printString
]

{ #category : #signal }
LcsInvalidSlotTypeError >> invalidSlotTypeMessage [
	^ 'Attempt to update ' , self slotName printString , '  slot("'
		, self slotDefinition class name , '") in '
		, self slotDefinition domainClass name , ' with: ' , self object printString
]

{ #category : #accessing }
LcsInvalidSlotTypeError >> object [
	^ object
]

{ #category : #accessing }
LcsInvalidSlotTypeError >> object: anObject [ 
	object := anObject
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> reinstallSlotDefinition [
	^ self target class installSlotDefinition: self slotDefinitionSelector
]

{ #category : #signal }
LcsInvalidSlotTypeError >> signalInvalidType: anObject forSlot: aSlotDefinition for: aDomainObject [
	self object: anObject.
	self slotDefinition: aSlotDefinition.
	self target: aDomainObject.
	self messageText: self invalidSlotTypeMessage.
	self signal: self messageText
]

{ #category : #signal }
LcsInvalidSlotTypeError >> slotClassName [
	^ self slotDefinition class name
]

{ #category : #accessing }
LcsInvalidSlotTypeError >> slotDefinition [
	^ slotDefinition
]

{ #category : #accessing }
LcsInvalidSlotTypeError >> slotDefinition: aSlotDefinition [ 
	slotDefinition := aSlotDefinition
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> slotDefinitionMethods [
	| method |
	method := self target class class lookupSelector: self slotDefinitionSelector.
	method ifNil: [ ^ self error: '#' , self slotDefinitionSelector , ' method not found' ].
	^ Array with: method
]

{ #category : #'gt view' }
LcsInvalidSlotTypeError >> slotDefinitionSelector [
	^ (self slotName , 'SlotDefinition')  asSymbol
]

{ #category : #signal }
LcsInvalidSlotTypeError >> slotName [
	^ self slotDefinition slotName
]

{ #category : #accessing }
LcsInvalidSlotTypeError >> target [
	^ target
]

{ #category : #signal }
LcsInvalidSlotTypeError >> target: aDomainObject [ 
	target := aDomainObject
]
