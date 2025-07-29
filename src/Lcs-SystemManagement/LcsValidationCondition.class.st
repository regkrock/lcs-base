Class {
	#name : #LcsValidationCondition,
	#superclass : #LcsApplicationObject,
	#traits : 'LtParentTrait',
	#classTraits : 'LtParentTrait classTrait',
	#instVars : [
		'conditionBlock',
		'validationDescription'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #accessing }
LcsValidationCondition >> conditionBlock [
	^ conditionBlock
]

{ #category : #accessing }
LcsValidationCondition >> conditionBlock: anObject [
	conditionBlock := anObject
]

{ #category : #magritte }
LcsValidationCondition >> conditionBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Condition [:value :domainObject :oldValue | ';
		priority: 10;
		default: '';
		autoAccept: true;
		accessor: (LcsMABlockPluggableAccessor 
						accessors: #(#conditionBlock)
						arguments: LcsAccessorSlot valueDomainObjectOldValueBlockArguments);
		"addCondition: [:aValue | aValue isEmpty ] labelled: 'Enter a Smalltalk expression';"
		addCondition: [:aValue | (aValue = 'true') not ] labelled: 'Enter a new value, this will always evaluate to show the error message';
		addCondition: [:aValue | (aValue = 'false') not ] labelled: 'Enter a new value, this will always evaluate to never show the error message';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #validation }
LcsValidationCondition >> evaluateWith: aValidator [
	(self conditionBlock value: aValidator domainObject) ifFalse: [
		aValidator addErrorDescription: self validationDescriptionDescription in: self ]
]

{ #category : #'as yet unclassified' }
LcsValidationCondition >> initialize [
	super initialize.
	self conditionBlock: [ :value | true ]
]

{ #category : #magritte }
LcsValidationCondition >> magritteInspectAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 30;
		label: 'Inspect';
		blocIcon: BrGlamorousVectorIcons inspect;
		action: (GtMagritteAction new
				beInUIProcess;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aButton phlow spawnObject: aMemento ]);
		beToolbarAction
]

{ #category : #'slot model' }
LcsValidationCondition >> slotDefinition [
	^ self parent ifNotNil: [:p | p slotDefinition ]
]

{ #category : #validation }
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
							message: s message ].
	isError isBoolean ifFalse: [ 
		LcsSlotValidationNonBooleanResultError
			signalBooleanNotReturnedFor: aValue
			condition: self
			inSlot: self slotDefinition ].
	
	isError == true ifTrue: [ 
				LcsSlotValidationError
					signalInvalidValue: aValue
					forCondition: self
					inSlot: self slotDefinition ].
	^ isError
]

{ #category : #validation }
LcsValidationCondition >> validate: aValue context: aDomainObject [
	| isError |
	isError := [ self conditionBlock cull: aValue cull: aDomainObject cull: nil ]
					on: Error 
					do: [ :s | 
						LcsSlotValidationExecutionError 
							signalInvalidValue: aValue 
							forCondition: self 
							inSlot: self slotDefinition
							context: aDomainObject
							message: s message asString ].
	isError isBoolean ifFalse: [
		LcsSlotValidationNonBooleanResultError 
			signalBooleanNotReturnedFor: aValue
			condition: self
			inSlot: self slotDefinition ].
			
	isError == true ifTrue: [ 
		LcsSlotValidationError
			signalInvalidValue: aValue
			forCondition: self
			inSlot: self slotDefinition ].
	^ isError
]

{ #category : #accessing }
LcsValidationCondition >> validationDescription [
	^ validationDescription
]

{ #category : #accessing }
LcsValidationCondition >> validationDescription: anObject [
	validationDescription := anObject
]

{ #category : #magritte }
LcsValidationCondition >> validationDescriptionDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Description';
		priority: 9;
		accessor: #validationDescription;
		autoAccept: true;
		default: '';
		"addCondition: [:aValue | (aValue isNil) not ] labelled: 'Enter a non-nil value';
		addCondition: [:aValue | (aValue = 'nil') not ] labelled: 'Enter a non-nil value';"
		addCondition: [:aValue | 
			(aValue trimBoth isEmpty) not ] labelled: 'A description is required';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]
