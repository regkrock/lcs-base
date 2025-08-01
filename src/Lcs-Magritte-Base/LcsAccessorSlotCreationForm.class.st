Class {
	#name : #LcsAccessorSlotCreationForm,
	#superclass : #LcsSlotCreationForm,
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #configuration }
LcsAccessorSlotCreationForm class >> defaultSlotClass [
	^ LcsAccessorSlot
]

{ #category : #configuration }
LcsAccessorSlotCreationForm class >> priority [
	^ 10
]

{ #category : #configuration }
LcsAccessorSlotCreationForm class >> slotComponentName [
	^ 'Accessor'
]

{ #category : #private }
LcsAccessorSlotCreationForm >> accessPathFrom: anMAChainAccessor [
	| accessor path|
	path := OrderedCollection new.
	accessor := anMAChainAccessor. 
	[ accessor respondsTo: #next ] whileTrue: [
		path add: accessor accessor selector.
		accessor := accessor next ]. 
	path add: accessor selector.
	^ path
]

{ #category : #'magritte - support' }
LcsAccessorSlotCreationForm >> addAccessorToBeginningOfAccessPath: aDescription [
	(aDescription accessor isKindOf: LcsMAPluggableAccessor) ifTrue: [ 
		aDescription accessor addSelectorToStartOfAccessChain: #slotModelBuilder.
		^aDescription ].
			
	(aDescription accessor isKindOf: MASelectorAccessor) ifTrue: [ 
		aDescription accessor: (MAChainAccessor accessors: {#slotModelBuilder. aDescription accessor selector}).
		^ aDescription ].
		
	(aDescription accessor isKindOf: MAChainAccessor) ifTrue: [ 
		aDescription accessor: (
			MAChainAccessor accessors: ( 
				(self accessPathFrom: aDescription accessor )
					addFirst: #slotModelBuilder;
					yourself)).
		^ aDescription ].
		
	^ aDescription
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> allowNilDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #allowNil
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> collectionSlotNameDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #collectionSlotName
]

{ #category : #callbacks }
LcsAccessorSlotCreationForm >> commit [
	self error: 'Do not use this'.
	"self slotModelBuilder commit"
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> initialValueBlockDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #initialValueBlock
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> magritteBuildAction [
	<magritteActionDescription>
	self isSlotModelBuilderNotReified ifTrue: [ ^ nil ].
	^ MAActionDescription new
		priority: 30;
		label: 'Build';
		beToolbarAction;
		blocIcon: BrGlamorousVectorIcons play;
		action: (GtMagritteAction new
				beInUIProcess;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aModel slotModelBuilder execute.
					aModel initializeSlotTypeClassAndBuilderClass.
					aButton phlow fireViewUpdateWish ]);
		onOverallStatusChanged: (GtMagritteBasicAction new
			action: [ :aStatus :aButton :aMemento :aDescription |
				aStatus isChanged
					ifTrue: [ aDescription enabled: false ]
					ifFalse: [ aDescription enabled: aStatus isValidAndInactive ] ])
]

{ #category : #'magritte - support' }
LcsAccessorSlotCreationForm >> magritteDescriptionFor: aSlotNameSymbol [
	| aDescription |
	
	(self slotModelBuilder respondsTo: aSlotNameSymbol) ifFalse: [ ^ nil ].
	
	aDescription := self slotModelBuilder perform: (aSlotNameSymbol , 'Description') asSymbol.
	
	self addAccessorToBeginningOfAccessPath: aDescription.
	^ aDescription
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> magritteInspectAction [
	"<magritteActionDescription>"
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

{ #category : #magritte }
LcsAccessorSlotCreationForm >> numberOfDecimalsDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #numberOfDecimals
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> prevalidationTransformBlockDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #prevalidationTransformBlock
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> requiredDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #required
]

{ #category : #callbacks }
LcsAccessorSlotCreationForm >> slotClassChangedTo: aClassName [
	self slotClassName: aClassName.
	self reifySlotModelBuilder
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> slotNameDescription [
	<magritteDescription>
	^ (self magritteDescriptionFor: #slotName) ifNotNil: [ :description |
		description
			priority: 4;
			yourself ]
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> slotTypesDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #slotTypes
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> targetClassDescription [
	<magritteDescription>
	^ (self magritteDescriptionFor: #targetClass) ifNotNil: [ :description |
		description
			priority: 3;
			yourself ]
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> validationConditionItemsDescription [
	"<magritteDescription>"
	^ self magritteDescriptionFor: #validationConditionItems
]

{ #category : #magritte }
LcsAccessorSlotCreationForm >> validationConditionsDescription [
	<magritteDescription>
	^ self magritteDescriptionFor: #validationConditions
]
