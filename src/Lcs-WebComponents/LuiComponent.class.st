Class {
	#name : 'LuiComponent',
	#superclass : 'WAComponent',
	#instVars : [
		'components',
		'domainObject',
		'parentComponent',
		'componentId',
		'componentName',
		'componentKeys',
		'attributes'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LuiComponent class >> named: aName [
	^ super new 
		initializeNamed: aName;
		yourself
]

{ #category : 'instance creation' }
LuiComponent class >> named: aName on: aWebComponent [
	^ super new 
		initializeNamed: aName on: aWebComponent;
		yourself
]

{ #category : 'instance creation' }
LuiComponent class >> on: aWebComponent [
	^ self named: nil on: aWebComponent
]

{ #category : 'components' }
LuiComponent >> _componentNamed: aTargetNames [
	| targetComponent |
	targetComponent := self components at: aTargetNames first ifAbsent: [ ^ nil].
	aTargetNames size = 1 ifTrue: [ ^targetComponent ].
	^ targetComponent _componentNamed: (aTargetNames copyFrom: 2 to: aTargetNames size)
]

{ #category : 'private' }
LuiComponent >> addClassNameTo: names [
	names addFirst: self class name.
	self parentComponent ifNil: [ self parentComponent addClassNameTo: names ]
]

{ #category : 'components' }
LuiComponent >> addComponent: aComponent [
	self addToComponents: aComponent.
	self componentKeys add: aComponent componentName.
	^ aComponent
]

{ #category : 'components' }
LuiComponent >> addComponent: aComponent after: anAfterComponent [
	self addToComponents: aComponent.
	self componentKeys add: aComponent componentName after: anAfterComponent componentName.
	^ aComponent
]

{ #category : 'components' }
LuiComponent >> addComponent: aComponent before: aBeforeComponent [
	self addToComponents: aComponent.
	self componentKeys add: aComponent componentName before: aBeforeComponent componentName.
	^ aComponent
]

{ #category : 'private' }
LuiComponent >> addComponentNameTo: namePath [
	namePath addFirst: self componentName asString.
	self parentComponent ifNotNil: [ self parentComponent addComponentNameTo: namePath ]
]

{ #category : 'initialize' }
LuiComponent >> addCssClass: aClassName [ 
	self attributes addCssClass: aClassName
]

{ #category : 'initialize' }
LuiComponent >> addCssClasses: aCollection [ 
	self attributes addCssClasses: aCollection
]

{ #category : 'components' }
LuiComponent >> addFirstComponent: aComponent [
	| component |
	aComponent parentComponent: self.
	component := self components at: aComponent componentName put: aComponent.
	component assignId.
	self componentKeys addFirst: aComponent componentName.
	^component
]

{ #category : 'properties' }
LuiComponent >> addLabelComponent [
	^ self addComponent: (LuiLabel named: 'label' on: self)
]

{ #category : 'components' }
LuiComponent >> addToComponents: aComponent [ 
	aComponent parentComponent: self.
	self components at: aComponent componentName put: aComponent.
	aComponent assignId
]

{ #category : 'components' }
LuiComponent >> assignId [
	self componentId: self fullComponentName hash asString
]

{ #category : 'accessing' }
LuiComponent >> attributes [
	^ attributes
]

{ #category : 'accessing' }
LuiComponent >> attributes: anObject [ 
	attributes := anObject
]

{ #category : 'properties - delegated' }
LuiComponent >> beHidden [
	^ self attributes beHidden
]

{ #category : 'properties - delegated' }
LuiComponent >> beVisible [
	^ self attributes beVisible
]

{ #category : 'components' }
LuiComponent >> componentAtIndex: anInteger [
	^ self orderedComponents at: anInteger
]

{ #category : 'accessing' }
LuiComponent >> componentId [
	^ componentId
]

{ #category : 'accessing' }
LuiComponent >> componentId: anObject [
	componentId := anObject
]

{ #category : 'accessing' }
LuiComponent >> componentKeys [
	^ componentKeys
]

{ #category : 'accessing' }
LuiComponent >> componentKeys: anObject [
	componentKeys := anObject
]

{ #category : 'accessing' }
LuiComponent >> componentName [
	^ componentName
]

{ #category : 'accessing' }
LuiComponent >> componentName: anObject [
	componentName := anObject
]

{ #category : 'components' }
LuiComponent >> componentNamed: aString [
	| targetNames |
	targetNames := aString substrings: { $/ }.
	^ self _componentNamed: targetNames
]

{ #category : 'components' }
LuiComponent >> componentNamed: aString ifNil: aBlock [
	^ (self componentNamed: aString) ifNil: aBlock value
]

{ #category : 'accessing' }
LuiComponent >> components [
	^ components
]

{ #category : 'accessing' }
LuiComponent >> components: anObject [
	components := anObject
]

{ #category : 'initialize' }
LuiComponent >> cssClass: aClassName [ 
	self attributes addCssClass: aClassName
]

{ #category : 'properties' }
LuiComponent >> cssClassesAttribute [
	^ self attributes cssClassesAttribute
]

{ #category : 'properties' }
LuiComponent >> cssClassesString [
	^ self cssClassesAttribute cssClassesString
]

{ #category : 'defaults' }
LuiComponent >> defaultCssClasses [
	^OrderedCollection new
]

{ #category : 'rendering' }
LuiComponent >> displayValue [
	^ self valueAccessor displayValue
]

{ #category : 'accessing' }
LuiComponent >> domainObject [
	^ domainObject
]

{ #category : 'accessing' }
LuiComponent >> domainObject: anObject [
	domainObject := anObject
]

{ #category : 'components' }
LuiComponent >> firstComponent [
	^ self componentAtIndex: 1
]

{ #category : 'asking' }
LuiComponent >> fullClassesName [
	| names fullNameStream |
	names := OrderedCollection new.
	self addClassNameTo: names.
	fullNameStream := WriteStream on: String new.
	names 
		do: [ :eachName | fullNameStream nextPutAll: eachName ]
		separatedBy: [ fullNameStream nextPutAll: '/' ].
	^ fullNameStream contents
]

{ #category : 'asking' }
LuiComponent >> fullComponentName [
	| names fullNameStream |
	names := OrderedCollection new.
	self addComponentNameTo: names.
	fullNameStream := WriteStream on: String new.
	names 
		do: [ :eachName | fullNameStream nextPutAll: eachName ]
		separatedBy: [ fullNameStream nextPutAll: '/' ].
	^ fullNameStream contents
]

{ #category : 'asking' }
LuiComponent >> fullComponentNameWithId [
	^ self fullComponentName , '(' , self componentId , ')'
]

{ #category : 'gt - views' }
LuiComponent >> gtComponentsFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Components';
		priority: 10;
		expandUpTo: 4;
		items: [ { self } ];
		children: #orderedComponents;
		column: 'Component Class' text: [ :aComponent | aComponent class name ];
		column: 'Component Name' text: [ :aComponent | aComponent componentName displayString ];
		column: 'ID' text: [ :aComponent | aComponent componentId displayString ]
]

{ #category : 'gt - views' }
LuiComponent >> gtParentCompoentsFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Parents';
		priority: 15;
		expandUpTo: 4;
		items: [ { self } ];
		children: #parentViewComponents;
		column: 'Component Class' text: [ :aComponent | aComponent class name ];
		column: 'Name' text: [ :aComponent | aComponent componentName displayString ];
		column: 'ID' text: [ :aComponent | aComponent componentId displayString ]
]

{ #category : 'gt - views' }
LuiComponent >> gtViewAttributesOn: aView [
	<gtView>
	^ self attributes gtViewAttributesOn: aView
]

{ #category : 'testing' }
LuiComponent >> hasComponents [
	^ self components notEmpty
]

{ #category : 'properties' }
LuiComponent >> hasLabelComponent [
	^ (self componentNamed: 'label') notNil
]

{ #category : 'testing' }
LuiComponent >> hasNoAttribute [
	^ self attributes hasNoAttribute
]

{ #category : 'testing' }
LuiComponent >> hasNoAttributes [
	^ self attributes hasNoAttributes
]

{ #category : 'testing' }
LuiComponent >> hasNoComponents [
	^ self components isEmpty
]

{ #category : 'initialize' }
LuiComponent >> initialize [
	super initialize.
	self components: Dictionary new.
	self componentKeys: OrderedCollection new.
	self attributes: (LuiComponentAttributes on: self).
	self initializeCssClasses.
]

{ #category : 'initialize' }
LuiComponent >> initializeCssClasses [
	self defaultCssClasses ifEmpty: [ ^self ].
	self addCssClasses: self defaultCssClasses.
]

{ #category : 'initialize' }
LuiComponent >> initializeNamed: aName [
	self componentName: aName
]

{ #category : 'initialize' }
LuiComponent >> initializeNamed: aName on: aWebComponent [
	self 
		componentName: aName;
		parentComponent: aWebComponent
]

{ #category : 'testing' }
LuiComponent >> isHidden [
	^ self attributes isHidden
]

{ #category : 'testing' }
LuiComponent >> isNotRenderable [
	^ self attributes isNotRenderable
]

{ #category : 'testing' }
LuiComponent >> isRenderable [
	^ self attributes isRenderable
]

{ #category : 'testing' }
LuiComponent >> isTraceOn [
	^false
]

{ #category : 'testing' }
LuiComponent >> isVisible [
	^ self attributes isVisible
]

{ #category : 'properties' }
LuiComponent >> labelComponent [
	^ self hasLabelComponent 
		ifTrue: [ self componentNamed: 'label' ] 
		ifFalse: [ self addLabelComponent ]
]

{ #category : 'properties' }
LuiComponent >> labelString [
	^ self hasLabelComponent
		ifTrue: [ self labelComponent labelString ]
		ifFalse: [ '' ]
]

{ #category : 'properties' }
LuiComponent >> labelString: aString [
	self labelComponent labelString: aString
]

{ #category : 'components' }
LuiComponent >> lastComponent [
	^ self components values last
]

{ #category : 'logging' }
LuiComponent >> logRenderingTrace [
	self isTraceOn ifTrue: [
		Transcript
			show: self traceRenderMessage;
			cr ]
]

{ #category : 'accessing' }
LuiComponent >> orderedComponents [
	^ self componentKeys collect: [ :eachKey | self components at: eachKey ]
]

{ #category : 'accessing' }
LuiComponent >> parentComponent [
	^ parentComponent
]

{ #category : 'accessing' }
LuiComponent >> parentComponent: anObject [
	parentComponent := anObject
]

{ #category : 'components' }
LuiComponent >> parentComponentNamed: aString [
	self componentName = aString ifTrue: [ ^ self ].
	^ self parentComponent
		ifNil: [ nil ]
		ifNotNil: [ :parent |  parent parentComponentNamed: aString ]
]

{ #category : 'gt - views' }
LuiComponent >> parentViewComponents [
	self parentComponent ifNil: [ ^ {} ].
	^Array with: self parentComponent
]

{ #category : 'components' }
LuiComponent >> removeComponent: aComponent [
	self componentKeys remove: aComponent componentName ifAbsent: [].
	^ self components removeKey: aComponent componentName ifAbsent: []
]

{ #category : 'components' }
LuiComponent >> removeComponentNamed: aName [
	^ self removeComponent: (self componentNamed: aName)
]

{ #category : 'rendering' }
LuiComponent >> renderAfterSubcomponentsOn: html [ 
]

{ #category : 'rendering' }
LuiComponent >> renderBeforeSubcomponentsOn: html [ 
]

{ #category : 'rendering' }
LuiComponent >> renderComponentOn: html [
	html div
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]

{ #category : 'rendering' }
LuiComponent >> renderContentOn: html [
	self isNotRenderable ifTrue: [ ^ self ].
	self renderComponentOn: html
]

{ #category : 'rendering' }
LuiComponent >> renderDetailsOn: html [
	self renderBeforeSubcomponentsOn: html.
	self renderSubcomponentsOn: html.
	self renderAfterSubcomponentsOn: html
]

{ #category : 'rendering' }
LuiComponent >> renderSubcomponentsOn: html [
	self orderedComponents do: [ :eachComponent | html render: eachComponent ]
]

{ #category : 'properties - delegated' }
LuiComponent >> replaceExistingCssClassesWithCssClass: aString [
	self cssClassesAttribute replaceExistingCssClassesWithCssClass: aString
]

{ #category : 'properties' }
LuiComponent >> title [
	^ self attributes title
]

{ #category : 'properties' }
LuiComponent >> title: aString [
	self attributes title: aString
]

{ #category : 'properties' }
LuiComponent >> titleBlock: aBlock [
	self attributes titleBlock: aBlock
]

{ #category : 'logging' }
LuiComponent >> traceRenderMessage [
	^ 'rendering... ' , self class name asString , '     ' , self componentName asString
]
