Class {
	#name : 'LcsSlotAction',
	#superclass : 'LcsApplicationObject',
	#traits : 'LtParentTrait',
	#classTraits : 'LtParentTrait classTrait',
	#instVars : [
		'description',
		'actionBlock'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'comparing' }
LcsSlotAction >> = anObject [
	anObject class name = self class name ifFalse: [ ^ false ].
	anObject actionBlock asString = self actionBlock asString ifFalse: [ ^ false ].
	^ anObject description = self description
]

{ #category : 'accessing' }
LcsSlotAction >> actionBlock [
	^ actionBlock
]

{ #category : 'accessing' }
LcsSlotAction >> actionBlock: anObject [
	actionBlock := anObject
]

{ #category : 'magritte' }
LcsSlotAction >> actionBlockDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: ('Action [:<1s> :<2s> :<3s> | '
				expandMacrosWithArguments: LcsAccessorSlot valueDomainObjectOldValueBlockArguments);
		priority: 10;
		default: '';
		accessor: (LcsMABlockPluggableAccessor
				accessors: #(#actionBlock)
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

{ #category : 'code generation' }
LcsSlotAction >> addCodeGenerationDetailsTo: aCodeStream [
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

{ #category : 'code generation' }
LcsSlotAction >> addInstVarSetterFor: aVarName to: aCodeStream [
	aVarName asString = 'parent' ifTrue: [ ^ self ].
	aCodeStream
		addKeyword: aVarName
		argument: (self creationStringForValueOf: aVarName)
]

{ #category : 'printing' }
LcsSlotAction >> asCreationString [
	^ '(<3s> new
			actionBlock: <1s>;
			description: ''<2s>'')'
		expandMacrosWith: self actionBlock printString
		with: self description
		with: self class name
]

{ #category : 'code generation' }
LcsSlotAction >> creationStringForValueOf: aVarName [
	| object |
	object := self instVarNamed: aVarName.
	object isBlock ifTrue: [ ^ object displayString ].
	^ object printString
]

{ #category : 'defaults' }
LcsSlotAction >> defaultActionBlock [
	"do nothing"
	^ [ :value |  ]
]

{ #category : 'accessing' }
LcsSlotAction >> description [
	^ description
]

{ #category : 'accessing' }
LcsSlotAction >> description: aString [ 
	description := aString
]

{ #category : 'magritte' }
LcsSlotAction >> descriptionDescription [
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

{ #category : 'message' }
LcsSlotAction >> errorDescription [
	^ (self class name asString , self errorDetails) trim
]

{ #category : 'message' }
LcsSlotAction >> errorDetails [
	^ ' - Error: ' , self description
]

{ #category : 'comparing' }
LcsSlotAction >> hash [
	^ self actionBlock hash bitXor: self description hash
]

{ #category : 'initialize' }
LcsSlotAction >> initialize [
	super initialize.
	self description: ''.
	self actionBlock: self defaultActionBlock
]

{ #category : 'initialize' }
LcsSlotAction >> initializeOn: anObject [ 
	self parent: anObject
]

{ #category : 'magritte' }
LcsSlotAction >> magritteAcceptAction [
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
LcsSlotAction >> magritteInspectAction [
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
LcsSlotAction >> slotDefinition [
	^ self parent ifNotNil: [:p | p slotDefinition ]
]

{ #category : 'code generation' }
LcsSlotAction >> writeOnCodeStream: aCodeStream [
]
