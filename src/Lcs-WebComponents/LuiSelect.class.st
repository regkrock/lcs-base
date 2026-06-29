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

{ #category : 'initialize' }
LuiSelect >> componentAttributesClass [
	^ LuiSelectAttributes
]

{ #category : 'defaults' }
LuiSelect >> defaultCssClasses [
	^ #()
	"^ #( inputField )"
]

{ #category : 'initialize' }
LuiSelect >> displayLabelFor: anObject [
	^ self valueAccessor class == LuiSlotAccessor
		ifTrue: [ self slotDefinition displayStringBlock
				cull: anObject
				cull: self slotDefinition ]
		ifFalse: [ anObject asString ]
]

{ #category : 'accessing' }
LuiSelect >> elements [
	^ elements
]

{ #category : 'accessing' }
LuiSelect >> elements: anObject [
	elements := anObject
]

{ #category : 'callbacks' }
LuiSelect >> handleCallbackValue: aValue element: anElement [
	self valueAccessor write: anElement
]

{ #category : 'initialize' }
LuiSelect >> initialize [
	super initialize.
	self optionPrintBlock: [ :eachOption | eachOption asString ].
	self callback: [].
	self selectableItemsBlock: [ :model | self slotDefinition targetCollection ]. 
	self elements: OrderedCollection new.
]

{ #category : 'initialize' }
LuiSelect >> initializeNamed: aName [
	super initializeNamed: aName
]

{ #category : 'initialize' }
LuiSelect >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super
		initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: aString.
	self elements: (
		(self selectableItemsBlock cull: aModel)
			asSortedCollection: [ :a :b | (self displayLabelFor: a) <= (self displayLabelFor: b) ])
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
		dataName: self componentName;
		dataStClass: self;
		dispatchCallback;
		with: [ self renderElementComponentsOn: html ]
]

{ #category : 'rendering' }
LuiSelect >> renderElementComponentsOn: html [
	^ self elements
		doWithIndex: [ :each :index | 
			| optionComponentName |
			optionComponentName := self componentName , '_' , index asString.
			html option
				id: (self fullComponentName , '/' , optionComponentName) hash asString;
				dataName: optionComponentName;
				dataStClass: self;
				label: (self displayLabelFor: each);
				callback: [ :value | self handleCallbackValue: value element: each ];
				selected: self valueAccessor read = each;
				with: (self optionValueFor: each) ]
]

{ #category : 'accessing' }
LuiSelect >> selectableItemsBlock [
	^ selectableItemsBlock
]

{ #category : 'accessing' }
LuiSelect >> selectableItemsBlock: anObject [
	selectableItemsBlock := anObject
]

{ #category : 'query' }
LuiSelect >> selection [
	^ self valueAccessor read
]

{ #category : 'model' }
LuiSelect >> slotDefinition [
	^ self valueAccessor slotDefinition 
]
