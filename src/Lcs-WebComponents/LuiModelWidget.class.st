Class {
	#name : 'LuiModelWidget',
	#superclass : 'LuiComponent',
	#instVars : [
		'valueAccessor'
	],
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'testing' }
LuiModelWidget class >> isAbstract [ 
	^ self == LuiModelWidget
]

{ #category : 'instance creation' }
LuiModelWidget class >> named: aComponentName model: aModel [
	^ self new
		initializeNamed: aComponentName model: aModel;
		yourself
]

{ #category : 'instance creation' }
LuiModelWidget class >> named: aComponentName selector: aGetter model: aModel [
	^ self new
		initializeNamed: aComponentName selector: aGetter model: aModel;
		yourself
]

{ #category : 'instance creation' }
LuiModelWidget class >> onSlot: aSlotDefinition [
	^ self onSlot: aSlotDefinition model: nil
]

{ #category : 'instance creation' }
LuiModelWidget class >> onSlot: aSlotDefinition model: aModel [
	^ self
		onSlot: aSlotDefinition
		model: aModel
		componentName: aSlotDefinition slotName
]

{ #category : 'instance creation' }
LuiModelWidget class >> onSlot: aSlotDefinition model: aModel componentName: aString [
	^ self new
		initializeOnSlot: aSlotDefinition model: aModel componentName: aString;
		yourself
]

{ #category : 'instance creation' }
LuiModelWidget class >> onSlotNamed: aSlotName model: aModel [
	^ self onSlot: (aModel slotDefinitionNamed: aSlotName) model: aModel
]

{ #category : 'instance creation' }
LuiModelWidget class >> onSlotNamed: aSlotName model: aModel componentName: aString [
	^ self
		onSlot: (aModel slotDefinitionNamed: aSlotName)
		model: aModel
		componentName: aString
]

{ #category : 'instance creation' }
LuiModelWidget >> _initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	self
		valueAccessor: (LuiSlotAccessor
				newOn: self
				slotDefinition: aSlotDefinition
				model: aModel).
	aSlotDefinition isVirtualSlot ifTrue: [ self disabled: true ].
	self componentName: aString
]

{ #category : 'component   decorations' }
LuiModelWidget >> addDependentComponent: aLuiComponent [
	^ self componentDecorations addDependentComponent: aLuiComponent
]

{ #category : 'rendering' }
LuiModelWidget >> addRenderingOfComponent: aComponent to: aScript [ 
	aScript << (aScript jQuery id: aComponent parentComponent componentId) load html: [ :ajaxHtml | aComponent parentComponent renderDetailsOn: ajaxHtml ]
]

{ #category : 'initialize' }
LuiModelWidget >> beNotRerendered [
	self removeDependentComponent: self
]

{ #category : 'initialize' }
LuiModelWidget >> beRerendered [
	self addDependentComponent: self
]

{ #category : 'attributes - accessing' }
LuiModelWidget >> callback [
	^ self attributes callback
]

{ #category : 'attributes - accessing' }
LuiModelWidget >> callback: aBlock [
	self attributes callback: aBlock 
]

{ #category : 'initialize' }
LuiModelWidget >> componentAttributesClass [
	^ LuiModelWidgetAttributes
]

{ #category : 'instance creation' }
LuiModelWidget >> componentNameBaseOn: aSlotDefinition [
	^ aSlotDefinition slotName
]

{ #category : 'component   decorations' }
LuiModelWidget >> dependentComponents [
	^ self componentDecorations dependentComponents
]

{ #category : 'rendering' }
LuiModelWidget >> displayValue [
	self valueAccessor ifNil: [ ^ 'nil' ].
	^ self valueAccessor displayValue
]

{ #category : 'rendering' }
LuiModelWidget >> handleCallbackAndRenderDependents: html [
	^ html jQuery ajax
		callback: [ :value | self handleCallbackValue: value ]
			value: (html jQuery id: self componentId) value;
		lcsOnSuccess: (self renderDependentComponentsOn: html)
]

{ #category : 'callbacks' }
LuiModelWidget >> handleCallbackValue: value [ 
	self valueAccessor codec decode: value
]

{ #category : 'testing' }
LuiModelWidget >> hasDependentComponents [
	^ self componentDecorations hasDependentComponents
]

{ #category : 'initialize' }
LuiModelWidget >> initialize [
	super initialize.
	"self beRerendered"
]

{ #category : 'initialize' }
LuiModelWidget >> initializeNamed: aName [
	super initializeNamed: aName.
	self valueAccessor: (LuiSmalltalkObjectAccessor newOn: self )
]

{ #category : 'initialize' }
LuiModelWidget >> initializeNamed: aName  model: aModel [
	self initializeNamed: aName.
	self valueAccessor: (LuiSmalltalkObjectAccessor newOn: self  model: aModel)
]

{ #category : 'initialize' }
LuiModelWidget >> initializeNamed: aName selector: aGetter model: aModel [
	super initializeNamed: aName.
	self valueAccessor: (
		LuiSmalltalkObjectAccessor
			newOn: self
			selector: aGetter
			model: aModel)
]

{ #category : 'instance creation' }
LuiModelWidget >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	self
		_initializeOnSlot: aSlotDefinition
		model: aModel
		componentName: aString.
	aSlotDefinition configureWidgetComponent: self model: aModel
]

{ #category : 'model' }
LuiModelWidget >> model [
	self valueAccessor model ifNotNil: [ : model | ^ model ].
	^ self presenter ifNotNil: [ :presenter | presenter model ]
]

{ #category : 'model' }
LuiModelWidget >> model: aModel [
	self valueAccessor model: aModel.
]

{ #category : 'callbacks' }
LuiModelWidget >> optionModel [
	^ self valueAccessor model
]

{ #category : 'visiting' }
LuiModelWidget >> populateFromNumberSlot: aNumberSlot [
]

{ #category : 'model' }
LuiModelWidget >> presenter [
	^ self myParentPresenterComponent
]

{ #category : 'attributes - accessing' }
LuiModelWidget >> readOnly [
	^ self attributes readOnly
]

{ #category : 'attributes - accessing' }
LuiModelWidget >> readOnly: aBoolean [
	self attributes readOnly: aBoolean 
]

{ #category : 'component   decorations' }
LuiModelWidget >> removeDependentComponent: aLuiComponent [
	^ self componentDecorations removeDependentComponent: aLuiComponent
]

{ #category : 'rendering' }
LuiModelWidget >> renderDependentComponentsOn: html [
	self hasDependentComponents ifFalse: [ ^ nil ].
	^ html jQuery script: [  :script | 
		self dependentComponents do: [ :eachComponent | 
			self addRenderingOfComponent: eachComponent to: script ] ]
]

{ #category : 'accessing' }
LuiModelWidget >> valueAccessor [
	^ valueAccessor
]

{ #category : 'accessing' }
LuiModelWidget >> valueAccessor: anObject [
	valueAccessor := anObject
]
