Class {
	#name : 'LcsBaseRule',
	#superclass : 'LcsApplicationObject',
	#traits : 'LtParentTrait',
	#classTraits : 'LtParentTrait classTrait',
	#instVars : [
		'conditionBlock',
		'errorMessage',
		'description'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'comparing' }
LcsBaseRule >> = anObject [
	anObject class name = self class name ifFalse: [ ^ false ].
	anObject conditionBlock asString = self conditionBlock asString ifFalse: [ ^ false ].
	^ anObject description = self description
]

{ #category : 'accessing' }
LcsBaseRule >> conditionBlock [
	^ conditionBlock
]

{ #category : 'accessing' }
LcsBaseRule >> conditionBlock: anObject [
	conditionBlock := anObject
]

{ #category : 'magritte' }
LcsBaseRule >> conditionBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: ('Condition [:<1s> :<2s> :<3s> | '
				expandMacrosWithArguments: LcsAccessorSlot valueDomainObjectOldValueBlockArguments);
		priority: 10;
		default: '';
		accessor: (LcsMABlockPluggableAccessor
				accessors: #(#conditionBlock)
				arguments: LcsAccessorSlot valueDomainObjectOldValueBlockArguments);
		addCondition: [ :aValue | aValue trimBoth isNotEmpty ]
			labelled: 'Enter a Smalltalk expression';
		addCondition: [ :aValue | (aValue = 'true') not ]
			labelled: 'Enter a new value, this will always evaluate to show the error message';
		addCondition: [ :aValue | (aValue = 'false') not ]
			labelled: 'Enter a new value, this will always evaluate to never show the error message';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'defaults' }
LcsBaseRule >> defaultConditionBlock [
	^ [ :value | true ]
]

{ #category : 'defaults' }
LcsBaseRule >> defaultDescription [
	^ ''
]

{ #category : 'defaults' }
LcsBaseRule >> defaultErrorMessage [
	^ nil
]

{ #category : 'accessing' }
LcsBaseRule >> description [
	^ description
]

{ #category : 'accessing' }
LcsBaseRule >> description: anObject [
	description := anObject
]

{ #category : 'magritte' }
LcsBaseRule >> descriptionDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Description';
		priority: 9;
		accessor: #description;
		default: '';
		addCondition: [:aValue | aValue trimBoth isNotEmpty ] labelled: 'A description is required';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'accessing' }
LcsBaseRule >> errorMessage [
	^ errorMessage
]

{ #category : 'accessing' }
LcsBaseRule >> errorMessage: aStringOrBlock [
	errorMessage := aStringOrBlock 
]

{ #category : 'validation' }
LcsBaseRule >> evaluateWith: aValidator [
	(self conditionBlock value: aValidator domainObject) ifFalse: [
		aValidator addErrorDescription: self descriptionDescription in: self ]
]

{ #category : 'printing' }
LcsBaseRule >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: self description;
		nextPutAll: ')'
]

{ #category : 'comparing' }
LcsBaseRule >> hash [
	^ self conditionBlock hash bitXor: self description hash
]

{ #category : 'initialize' }
LcsBaseRule >> initialize [
	super initialize.
	self conditionBlock: self defaultConditionBlock.
	self description: self defaultDescription.
	self errorMessage: self defaultErrorMessage.
]

{ #category : 'initialize' }
LcsBaseRule >> initializeOn: anObject [ 
	self parent: anObject
]

{ #category : 'testing' }
LcsBaseRule >> isNilRule [
	^ false
]

{ #category : 'magritte' }
LcsBaseRule >> magritteAcceptAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 10;
		label: 'Accept';
		isLabelVisible: false;
		blocIcon: BrGlamorousVectorIcons accept;
		action: (GtMagritteAction new
				beInFutureProcess;
				beWithFutureResponse;
				action: [ :aModel :aButton :aMemento :aDescription | aMemento commit ]);
		beEnabledAndChangedAndValidAndInactiveOverallStatus;
		beToolbarAction
]

{ #category : 'magritte' }
LcsBaseRule >> magritteInspectAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 30;
		label: 'Inspect Memento';
		isLabelVisible: false;
		blocIcon: BrGlamorousVectorIcons inspect;
		action: (GtMagritteAction new
				beInUIProcess;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aButton phlow spawnObject: aMemento ]);
		beToolbarAction
]

{ #category : 'accessing' }
LcsBaseRule >> rule: anObject [
	^ self description: anObject
]

{ #category : 'error signalling' }
LcsBaseRule >> signalValidationError: aValue context: aDomainObject oldValue: anOldValue [
	^ LcsSlotValidationError
		signalInvalidValue: aValue
		forCondition: self
		inSlot: self slotDefinition
		oldValue: anOldValue
		context: aDomainObject
]

{ #category : 'slot model' }
LcsBaseRule >> slotDefinition [
	^ self parent ifNotNil: [:p | p slotDefinition ]
]

{ #category : 'validation' }
LcsBaseRule >> validate: aValue [
	^ self validate: aValue context: nil oldValue: nil
]

{ #category : 'validation' }
LcsBaseRule >> validate: aValue context: aDomainObject [
	^ self validate: aValue context: aDomainObject oldValue: nil
]

{ #category : 'validation' }
LcsBaseRule >> validate: aValue context: aDomainObject oldValue: anOldValue [
	| result |
	[ result := self conditionBlock cull: aValue cull: aDomainObject cull: anOldValue cull: self slotDefinition ]
		on: Error
		do: [ :exception | 
					LcsSlotValidationExecutionError
						signalInvalidValue: aValue
						forRule: self
						inSlot: self slotDefinition
						context: aDomainObject
						oldValue: anOldValue
						parentException: exception ].
	^ result 
		ifTrue: [ result ]
		ifFalse: [ self signalValidationError: aValue context: aDomainObject oldValue: anOldValue ]
]

{ #category : 'accessing' }
LcsBaseRule >> validationErrorMessage [
	^ self errorMessage 
		ifNil: [ self description ] 
		ifNotNil: [ self errorMessage value ]
]
