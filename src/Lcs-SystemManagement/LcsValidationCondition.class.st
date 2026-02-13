Class {
	#name : 'LcsValidationCondition',
	#superclass : 'LcsApplicationObject',
	#traits : 'LtParentTrait',
	#classTraits : 'LtParentTrait classTrait',
	#instVars : [
		'conditionBlock',
		'validationDescription',
		'errorMessage'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'comparing' }
LcsValidationCondition >> = anObject [
	anObject class name = self class name ifFalse: [ ^ false ].
	anObject conditionBlock asString = self conditionBlock asString ifFalse: [ ^ false ].
	^ anObject validationDescription = self validationDescription
]

{ #category : 'accessing' }
LcsValidationCondition >> conditionBlock [
	^ conditionBlock
]

{ #category : 'accessing' }
LcsValidationCondition >> conditionBlock: anObject [
	conditionBlock := anObject
]

{ #category : 'magritte' }
LcsValidationCondition >> conditionBlockDescription [
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

{ #category : 'accessing' }
LcsValidationCondition >> errorMessage [
	^ errorMessage
]

{ #category : 'accessing' }
LcsValidationCondition >> errorMessage: aStringOrBlock [
	errorMessage := aStringOrBlock 
]

{ #category : 'validation' }
LcsValidationCondition >> evaluateWith: aValidator [
	(self conditionBlock value: aValidator domainObject) ifFalse: [
		aValidator addErrorDescription: self validationDescriptionDescription in: self ]
]

{ #category : 'printing' }
LcsValidationCondition >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: (self validationDescription ifNil: ['']);
		nextPutAll: ')'
]

{ #category : 'comparing' }
LcsValidationCondition >> hash [
	^ self conditionBlock hash bitXor: self validationDescription hash
]

{ #category : 'initialize' }
LcsValidationCondition >> initialize [
	super initialize.
	self conditionBlock: [ :value | true ]
]

{ #category : 'initialize' }
LcsValidationCondition >> initializeOn: anObject [ 
	self parent: anObject
]

{ #category : 'magritte' }
LcsValidationCondition >> magritteAcceptAction [
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
LcsValidationCondition >> magritteInspectAction [
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

{ #category : 'slot model' }
LcsValidationCondition >> slotDefinition [
	^ self parent ifNotNil: [:p | p slotDefinition ]
]

{ #category : 'validation' }
LcsValidationCondition >> validate: aValue [
	| isError |
	isError := [ self conditionBlock cull: aValue ]
			on: Error
			do: [ :s | 
				LcsSlotValidationExecutionError
					signalInvalidValue: aValue
					forCondition: self
					inSlot: self slotDefinition
					context: nil
					oldValue: nil
					message: s message ].
	isError isBoolean
		ifFalse: [ LcsSlotValidationNonBooleanResultError
				signalBooleanNotReturnedFor: aValue
				condition: self
				inSlot: self slotDefinition
				context: nil
				oldValue: nil ].

	isError == true
		ifTrue: [ LcsSlotValidationError
				signalInvalidValue: aValue
				forCondition: self
				inSlot: self slotDefinition
				oldValue: nil
				context: nil ].
	^ isError
]

{ #category : 'validation' }
LcsValidationCondition >> validate: aValue context: aDomainObject [
	| isError oldValue |
	oldValue := nil.
	isError := [ self conditionBlock
			cull: aValue
			cull: aDomainObject
			cull: oldValue ]
			on: Error
			do: [ :s | 
				LcsSlotValidationExecutionError
					signalInvalidValue: aValue
					forCondition: self
					inSlot: self slotDefinition
					context: aDomainObject
					oldValue: oldValue
					message: s message asString ].
	isError isBoolean
		ifFalse: [ LcsSlotValidationNonBooleanResultError
				signalBooleanNotReturnedFor: aValue
				condition: self
				inSlot: self slotDefinition
				context: aDomainObject
				oldValue: oldValue ].

	isError == true
		ifTrue: [ LcsSlotValidationError
				signalInvalidValue: aValue
				forCondition: self
				inSlot: self slotDefinition
				oldValue: oldValue
				context: aDomainObject ].
	^ isError
]

{ #category : 'validation' }
LcsValidationCondition >> validate: aValue context: aDomainObject oldValue: anOldValue [
	| isError |
	isError := 
		[ self conditionBlock cull: aValue cull: aDomainObject cull: anOldValue ]
			on: Error
			do: [ :s | 
				LcsSlotValidationExecutionError
					signalInvalidValue: aValue
					forCondition: self
					inSlot: self slotDefinition
					context: aDomainObject
					oldValue: anOldValue
					message: s message asString ].
	isError isBoolean
		ifFalse: [ LcsSlotValidationNonBooleanResultError
				signalBooleanNotReturnedFor: aValue
				condition: self
				inSlot: self slotDefinition
				context: aDomainObject
				oldValue: anOldValue ].

	isError == true
		ifTrue: [ LcsSlotValidationError
				signalInvalidValue: aValue
				forCondition: self
				inSlot: self slotDefinition
				oldValue: anOldValue
				context: aDomainObject ].
	^ isError
]

{ #category : 'accessing' }
LcsValidationCondition >> validationDescription [
	^ validationDescription
]

{ #category : 'accessing' }
LcsValidationCondition >> validationDescription: anObject [
	validationDescription := anObject
]

{ #category : 'magritte' }
LcsValidationCondition >> validationDescriptionDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Description';
		priority: 9;
		accessor: #validationDescription;
		default: '';
		addCondition: [:aValue | aValue trimBoth isNotEmpty ] labelled: 'A description is required';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : 'accessing' }
LcsValidationCondition >> validationErrorMessage [
	^ self errorMessage 
		ifNil: [ self validationDescription ifNil: [ '' ] ] 
		ifNotNil: [ self errorMessage value ]
]
