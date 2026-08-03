Class {
	#name : 'LuiSelect',
	#superclass : 'LuiModelWidget',
	#instVars : [
		'optionPrintBlock',
		'optionNames',
		'options',
		'elements',
		'selectableItemsBlock'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
LuiSelect class >> named: aName model: aModel options: aCollection [
	^ self new
		initializeNamed: aName model: aModel options: aCollection;
		yourself
]

{ #category : 'initialize' }
LuiSelect >> componentAttributesClass [
	^ LuiSelectAttributes
]

{ #category : 'defaults' }
LuiSelect >> defaultCssClasses [
	^ OrderedCollection with: LuiCssClassesMap / #inputField
]

{ #category : 'initialize' }
LuiSelect >> displayLabelFor: anObject [
	^ self valueAccessor class == LuiSlotAccessor
		ifTrue: [ self slotDefinition displayStringBlock
				cull: anObject
				cull: self slotDefinition ]
		ifFalse: [ anObject asString ]
]

{ #category : 'callbacks' }
LuiSelect >> elementWithOption: aValue [
	^ self elements detect: [ :each | (self optionValueFor: each) = aValue ]
]

{ #category : 'accessing' }
LuiSelect >> elements [
	^ elements
]

{ #category : 'accessing' }
LuiSelect >> elements: anObject [
	elements := anObject
]

{ #category : 'rendering' }
LuiSelect >> handleCallbackAndRenderDependents: html [
	^ html jQuery ajax
		callback: [ :value | self handleCallbackValue: value ]
			value: (html jQuery id: self componentId) value;
		lcsOnSuccess: (self renderDependentComponentsOn: html)
]

{ #category : 'callbacks' }
LuiSelect >> handleCallbackValue: aValue [
	self valueAccessor write: (self elementWithOption: aValue)
]

{ #category : 'initialize' }
LuiSelect >> initialize [
	super initialize.
	self beRerendered.
	self optionPrintBlock: [ :eachOption | eachOption asString ].
	self selectableItemsBlock: [ :model | self slotDefinition targetCollection ]
]

{ #category : 'initialize' }
LuiSelect >> initializeNamed: aName [
	super initializeNamed: aName.
	self elements: OrderedCollection new
]

{ #category : 'initialize' }
LuiSelect >> initializeNamed: aName  model: aModel [
	super initializeNamed: aName  model: aModel.
	"self elements: aModel.
	self elements doWithIndex: [ :each :index |
		self addComponent: (LuiSelectOption onModel: each
		componentName: self componentName , '_' , index asString) ] "
]

{ #category : 'instance creation' }
LuiSelect >> initializeNamed: aName model: aModel options: aCollection [ 
	self initializeNamed: aName model: aModel.
	self elements: aCollection.
	self elements doWithIndex: [ :each :index |
		self addComponent: (LuiSelectOption named: self componentName , '_' , index asString model: each) ] 
]

{ #category : 'initialize' }
LuiSelect >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super
		initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: aString.
	self elements: self sortedElements.
	self elements doWithIndex: [ :each :index |
		| option |
		option := LuiSelectOption 
					onSlot: aSlotDefinition
					model:each
					componentName: self componentName , '_' , index asString.
		self addComponent: option ] 
]

{ #category : 'accessing' }
LuiSelect >> optionPrintBlock [
	^ optionPrintBlock
]

{ #category : 'accessing' }
LuiSelect >> optionPrintBlock: anObject [
	optionPrintBlock := anObject
]

{ #category : 'initialize' }
LuiSelect >> optionValueFor: anObject [
	^ self valueAccessor class == LuiSlotAccessor
		ifTrue: [ self slotDefinition optionValueBlock cull: anObject cull: self slotDefinition ]
		ifFalse: [ anObject asString ]
]

{ #category : 'rendering' }
LuiSelect >> renderComponentOn: html [
	html select
		id: self componentId asString;
		addCommonAttributes: self;
		onChange: (self handleCallbackAndRenderDependents: html);
		with: [ self renderDetailsOn: html ]
]

{ #category : 'accessing' }
LuiSelect >> selectableItemsBlock [
	^ selectableItemsBlock
]

{ #category : 'accessing' }
LuiSelect >> selectableItemsBlock: anObject [
	selectableItemsBlock := anObject
]

{ #category : 'model' }
LuiSelect >> slotDefinition [
	^ self valueAccessor slotDefinition 
]

{ #category : 'private' }
LuiSelect >> sortedElements [
		^(self selectableItemsBlock cull: self model)
			asSortedCollection: [ :a :b | (self displayLabelFor: a) <= (self displayLabelFor: b) ]
]
