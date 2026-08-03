"
<label for=""standard-select"">Standard Select</label>
<div class=""select"">
  <select id=""standard-select"">
    <option value=""Option 1"">Option 1</option>
    <option value=""Option 2"">Option 2</option>
    <option value=""Option 3"">Option 3</option>
    <option value=""Option 4"">Option 4</option>
    <option value=""Option 5"">Option 5</option>
    <option value=""Option length"">
      Option that has too long of a value to fit
    </option>
  </select>
</div>
"
Class {
	#name : 'LuiNonJQuerySelect',
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

{ #category : 'initialize' }
LuiNonJQuerySelect >> componentAttributesClass [
	^ LuiSelectAttributes
]

{ #category : 'defaults' }
LuiNonJQuerySelect >> defaultCssClasses [
	^ OrderedCollection with: LuiCssClassesMap / #inputField
]

{ #category : 'initialize' }
LuiNonJQuerySelect >> displayLabelFor: anObject [
	^ self valueAccessor class == LuiSlotAccessor
		ifTrue: [ self slotDefinition displayStringBlock
				cull: anObject
				cull: self slotDefinition ]
		ifFalse: [ anObject asString ]
]

{ #category : 'callbacks' }
LuiNonJQuerySelect >> elementWithOption: aValue [
	^ self elements detect: [ :each | (self optionValueFor: each) = aValue ]
]

{ #category : 'accessing' }
LuiNonJQuerySelect >> elements [
	^ elements
]

{ #category : 'accessing' }
LuiNonJQuerySelect >> elements: anObject [
	elements := anObject
]

{ #category : 'rendering' }
LuiNonJQuerySelect >> handleCallbackAndRenderDependents: html [
	^ html jQuery ajax
		callback: [ :value | self handleCallbackValue: value ]
			value: (html jQuery id: self componentId) value;
		lcsOnSuccess: (self renderDependentComponentsOn: html)
]

{ #category : 'callbacks' }
LuiNonJQuerySelect >> handleCallbackValue: aValue [
	self valueAccessor write: (self elementWithOption: aValue)
]

{ #category : 'callbacks' }
LuiNonJQuerySelect >> handleCallbackValue: aValue element: anElement [
	self valueAccessor write: anElement
]

{ #category : 'initialize' }
LuiNonJQuerySelect >> initialize [
	super initialize.
	self beRerendered.
	self optionPrintBlock: [ :eachOption | eachOption asString ].
	self callback: [].
	self selectableItemsBlock: [ :model | self slotDefinition targetCollection ]. 
	self elements: OrderedCollection new.
]

{ #category : 'initialize' }
LuiNonJQuerySelect >> initializeNamed: aName [
	super initializeNamed: aName
]

{ #category : 'initialize' }
LuiNonJQuerySelect >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super
		initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: aString.
	self elements: (
		(self selectableItemsBlock cull: aModel)
			asSortedCollection: [ :a :b | (self displayLabelFor: a) <= (self displayLabelFor: b) ])
]

{ #category : 'accessing' }
LuiNonJQuerySelect >> optionPrintBlock [
	^ optionPrintBlock
]

{ #category : 'accessing' }
LuiNonJQuerySelect >> optionPrintBlock: anObject [
	optionPrintBlock := anObject
]

{ #category : 'initialize' }
LuiNonJQuerySelect >> optionValueFor: anObject [
	^ self valueAccessor class == LuiSlotAccessor
		ifTrue: [ self slotDefinition optionValueBlock cull: anObject cull: self slotDefinition ]
		ifFalse: [ anObject asString ]
]

{ #category : 'rendering' }
LuiNonJQuerySelect >> renderComponentOn: html [
	html select
		id: self componentId asString;
		addCommonAttributes: self;
		dispatchCallback;
		with: [ self renderElementComponentsOn: html ]
]

{ #category : 'rendering' }
LuiNonJQuerySelect >> renderElementComponentsOn: html [
	^ self elements
		doWithIndex: [ :each :index | 
			| optionComponentName |
			optionComponentName := self componentName , '_' , index asString.
			html option
				id: (self fullComponentName , '/' , optionComponentName) hash asString;
				dataName: optionComponentName;
				dataStClass: self;
				label: (self displayLabelFor: each);
				"callback: [ :value | self handleCallbackValue: value element: each ];"
				selected: self valueAccessor read = each;
				with: (self optionValueFor: each) ]
]

{ #category : 'accessing' }
LuiNonJQuerySelect >> selectableItemsBlock [
	^ selectableItemsBlock
]

{ #category : 'accessing' }
LuiNonJQuerySelect >> selectableItemsBlock: anObject [
	selectableItemsBlock := anObject
]

{ #category : 'query' }
LuiNonJQuerySelect >> selection [
	^ self valueAccessor read
]

{ #category : 'model' }
LuiNonJQuerySelect >> slotDefinition [
	^ self valueAccessor slotDefinition 
]
