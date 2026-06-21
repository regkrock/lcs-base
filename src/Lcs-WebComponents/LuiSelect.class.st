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
		'options'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'options' }
LuiSelect >> addOption: aString [
	self addComponent: (LuiOption new text: aString)
]

{ #category : 'option - slotDefinition' }
LuiSelect >> addOption: aSlotDefinition basedOn: anItem [
	^ self addComponent: ((LuiOption onSlot: aSlotDefinition model: anItem)
								callback: [ :value | self handleCallbackValue: value ];
								yourself)
]

{ #category : 'option - slotDefinition' }
LuiSelect >> addOptionComponents [
	self optionNames
		with: self options
		do: [ :eachOptionName :eachOption | 
			self
				addComponent: (LuiOption new
						componentName: eachOptionName;
						optionValue: eachOption;
						text: eachOptionName) ]
]

{ #category : 'options' }
LuiSelect >> addOptionsFrom: anOptionsCollection [
	self options: anOptionsCollection copy.
	self optionNames: (self options
				collect: [ :each | self optionNames add: (self optionPrintBlock value: each) ]).
	self addOptionComponents
]

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
LuiSelect >> initialize [
	super initialize.
	self options: OrderedCollection new.
	self optionNames: OrderedCollection new.
	self optionPrintBlock: [ :eachOption | eachOption asString ].
	self callback: []
]

{ #category : 'initialize' }
LuiSelect >> initializeNamed: aName [
	super initializeNamed: aName.
	self name: aName
]

{ #category : 'initialize' }
LuiSelect >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	self callback: [:value | self handleCallbackValue: value].
	aSlotDefinition targetCollection
		sorted: [ :a :b | 
			(aSlotDefinition displayStringBlock cull: a cull: aSlotDefinition)
				<= (aSlotDefinition displayStringBlock cull: b cull: aSlotDefinition) ]
		do: [ :eachItem | self addOption: aSlotDefinition basedOn: eachItem ]
]

{ #category : 'attributes - accessing' }
LuiSelect >> name [
	^ self attributes name
]

{ #category : 'attributes - accessing' }
LuiSelect >> name: aString [
	^ self attributes name: aString
]

{ #category : 'accessing' }
LuiSelect >> optionNames [
	^ optionNames
]

{ #category : 'accessing' }
LuiSelect >> optionNames: anObject [
	optionNames := anObject
]

{ #category : 'accessing' }
LuiSelect >> optionPrintBlock [
	^ optionPrintBlock
]

{ #category : 'accessing' }
LuiSelect >> optionPrintBlock: anObject [
	optionPrintBlock := anObject
]

{ #category : 'accessing' }
LuiSelect >> options [
	^ options
]

{ #category : 'accessing' }
LuiSelect >> options: anObject [
	options := anObject
]

{ #category : 'rendering' }
LuiSelect >> renderComponentOn: html [
	html select
		addCommonAttributes: self;
		with: [self renderDetailsOn: html]
]
