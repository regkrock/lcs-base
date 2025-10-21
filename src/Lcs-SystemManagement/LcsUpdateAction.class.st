Class {
	#name : #LcsUpdateAction,
	#superclass : #LcsApplicationObject,
	#traits : 'LtParentTrait',
	#classTraits : 'LtParentTrait classTrait',
	#instVars : [
		'description',
		'actionBlock'
	],
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #comparing }
LcsUpdateAction >> = anObject [
	anObject class name = self class name ifFalse: [ ^ false ].
	anObject actionBlock asString = self actionBlock asString ifFalse: [ ^ false ].
	^ anObject description = self description
]

{ #category : #accessing }
LcsUpdateAction >> actionBlock [
	^ actionBlock
]

{ #category : #accessing }
LcsUpdateAction >> actionBlock: anObject [
	actionBlock := anObject
]

{ #category : #magritte }
LcsUpdateAction >> actionBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Action [:value :domainObject :oldValue | ';
		priority: 10;
		default: '';
		accessor: (LcsMABlockPluggableAccessor 
						accessors: #(#actionBlock)
						arguments: LcsAccessorSlot valueDomainObjectOldValueBlockArguments);
		addCondition: [:aValue | aValue trimBoth isNotEmpty ] labelled: 'Enter a Smalltalk expression';
		addCondition: [:aValue | (aValue = 'true') not ] labelled: 'Enter a new value, this will always evaluate to show the error message';
		addCondition: [:aValue | (aValue = 'false') not ] labelled: 'Enter a new value, this will always evaluate to never show the error message';
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]
]

{ #category : #'code generation' }
LcsUpdateAction >> addCodeGenerationDetailsTo: aCodeStream [
	| baseObject newValue originalValue hasDetailLines instanceVarNames|
	hasDetailLines := false.
	baseObject := self class new.
	aCodeStream 
		newLine;
		nextPutAll: self className asString , ' new'.
	aCodeStream indent.
	instanceVarNames := self class allInstVarNames reject: [ :each | each = 'parent'].
	instanceVarNames do: [ :eachVarName |
		newValue := self instVarNamed: eachVarName.
		originalValue := baseObject instVarNamed: eachVarName. 
		newValue isBlock 
			ifTrue: [ 
				newValue displayString ~= originalValue displayString
					ifTrue: [ 
						hasDetailLines := true.
						self addInstVarSetterFor: eachVarName to: aCodeStream ] ]
			ifFalse: [
				 newValue ~= originalValue
				 	ifTrue: [
				 		hasDetailLines := true.
				 		self addInstVarSetterFor: eachVarName to: aCodeStream ] ] ].
	hasDetailLines ifTrue: [ 
		aCodeStream addYourself].

]

{ #category : #'code generation' }
LcsUpdateAction >> addInstVarSetterFor: aVarName to: aCodeStream [
	aVarName asString = 'parent' ifTrue: [ ^ self ].
	aCodeStream
		addKeyword: aVarName
		argument: (self creationStringForValueOf: aVarName)
]

{ #category : #'code generation' }
LcsUpdateAction >> creationStringForValueOf: aVarName [
	| object |
	object := self instVarNamed: aVarName.
	object isBlock ifTrue: [ ^ object displayString ].
	^ object printString
]

{ #category : #defaults }
LcsUpdateAction >> defaultActionBlock [
	"do nothing"
	^ [ :value |  ]
]

{ #category : #accessing }
LcsUpdateAction >> description [
	^ description
]

{ #category : #accessing }
LcsUpdateAction >> description: aString [ 
	description := aString
]

{ #category : #magritte }
LcsUpdateAction >> descriptionDescription [
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

{ #category : #message }
LcsUpdateAction >> errorDescription [
	^ self class name asString , ' Error ' , self description
		ifNil: [ '' ]
		ifNotNil: ' - ' , self description
]

{ #category : #validation }
LcsUpdateAction >> execute: aValue [
	^ self execute: aValue context: nil oldValue: nil
]

{ #category : #validation }
LcsUpdateAction >> execute: aValue context: aDomainObject [
	^ self execute: aValue context: aDomainObject oldValue: nil
]

{ #category : #validation }
LcsUpdateAction >> execute: aValue context: aDomainObject oldValue: anOldValue [
	[ self actionBlock cull: aValue cull: aDomainObject cull: anOldValue ]
		on: Error
		do: [ :s | 
				LcsUpdateActionExecutionError
					signalErrForValue: aValue
					updateAction: self
					slot: self slotDefinition
					context: aDomainObject
					oldValue: anOldValue
					message: s message asString ]
]

{ #category : #comparing }
LcsUpdateAction >> hash [
	^ self actionBlock hash bitXor: self description hash
]

{ #category : #initialize }
LcsUpdateAction >> initialize [
	super initialize.
	self actionBlock: self defaultActionBlock
]

{ #category : #initialize }
LcsUpdateAction >> initializeOn: anObject [ 
	self parent: anObject
]

{ #category : #magritte }
LcsUpdateAction >> magritteAcceptAction [
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

{ #category : #magritte }
LcsUpdateAction >> magritteInspectAction [
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

{ #category : #'slot model' }
LcsUpdateAction >> slotDefinition [
	^ self parent ifNotNil: [:p | p slotDefinition ]
]

{ #category : #'code generation' }
LcsUpdateAction >> writeOnCodeStream: aCodeStream [
]
