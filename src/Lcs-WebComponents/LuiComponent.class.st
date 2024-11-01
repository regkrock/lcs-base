Class {
	#name : #LuiComponent,
	#superclass : #WAComponent,
	#instVars : [
		'components',
		'domainObject',
		'parentComponent',
		'componentId',
		'componentName',
		'properties'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'instance creation' }
LuiComponent class >> named: aName on: aWebComponent [
	^ super new 
		initializeNamed: aName on: aWebComponent;
		yourself
]

{ #category : #'instance creation' }
LuiComponent class >> on: aWebComponent [
	^ self named: nil on: aWebComponent
]

{ #category : #components }
LuiComponent >> _componentNamed: aTargetNames [
	| targetComponent |
	targetComponent := self components at: aTargetNames first ifAbsent: [ ^ nil].
	aTargetNames size = 1 ifTrue: [ ^targetComponent ].
	^ targetComponent _componentNamed: (aTargetNames copyFrom: 2 to: aTargetNames size)
]

{ #category : #private }
LuiComponent >> addClassNameTo: names [
	names addFirst: self class name.
	self parentComponent ifNil: [ self parentComponent addClassNameTo: names ]
]

{ #category : #components }
LuiComponent >> addComponent: aComponent [
	| component |
	component := self components at: aComponent componentName put: aComponent.
	component assignId.
	^component
]

{ #category : #private }
LuiComponent >> addComponentNameTo: names [
	names addFirst: self componentName asString.
	self parentComponent ifNotNil: [ self parentComponent addComponentNameTo: names ]
]

{ #category : #components }
LuiComponent >> assignId [
	self componentId: self fullComponentName hash asString
]

{ #category : #components }
LuiComponent >> componentAtIndex: anInteger [
	^ self components values at: anInteger
]

{ #category : #accessing }
LuiComponent >> componentId [
	^ componentId
]

{ #category : #accessing }
LuiComponent >> componentId: anObject [
	componentId := anObject
]

{ #category : #accessing }
LuiComponent >> componentName [
	^ componentName
]

{ #category : #accessing }
LuiComponent >> componentName: anObject [
	componentName := anObject
]

{ #category : #components }
LuiComponent >> componentNamed: aString [
	| targetNames |
	targetNames := aString substrings: { $/ }.
	^ self _componentNamed: targetNames
]

{ #category : #accessing }
LuiComponent >> components [
	^ components
]

{ #category : #accessing }
LuiComponent >> components: anObject [
	components := anObject
]

{ #category : #properties }
LuiComponent >> cssClassesProperty [
	^ self properties cssClassesProperty
]

{ #category : #properties }
LuiComponent >> cssClassesString [
	^ self cssClassesProperty cssClassesString
]

{ #category : #defaults }
LuiComponent >> defaultCssClasses [
	^OrderedCollection new
]

{ #category : #rendering }
LuiComponent >> displayValue [
	^ self valueAccessor label
]

{ #category : #accessing }
LuiComponent >> domainObject [
	^ domainObject
]

{ #category : #accessing }
LuiComponent >> domainObject: anObject [
	domainObject := anObject
]

{ #category : #components }
LuiComponent >> firstComponent [
	^ self componentAtIndex: 1
]

{ #category : #asking }
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

{ #category : #asking }
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

{ #category : #asking }
LuiComponent >> fullComponentNameWithId [
	^ self fullComponentName , '(' , self componentId , ')'
]

{ #category : #'gt - views' }
LuiComponent >> gtCompoentsFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Components';
		priority: 10;
		expandUpTo: 4;
		items: [ { self } ];
		children: #components;
		column: 'Component Class' text: [ :aComponent | aComponent class name ];
		column: 'Name' text: [ :aComponent | aComponent componentName displayString ];
		column: 'ID' text: [ :aComponent | aComponent componentId displayString ]
]

{ #category : #'gt - views' }
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

{ #category : #'gt - views' }
LuiComponent >> gtViewPropertiesOn: aView [
	<gtView>
	^ self properties gtViewPropertiesOn: aView
]

{ #category : #testing }
LuiComponent >> hasNoComponents [
	^ self components isEmpty
]

{ #category : #initialize }
LuiComponent >> initialize [
	super initialize.
	self components: OrderedDictionary new.
	self properties: (LuiComponentProperties on: self).
	self initializeCssClasses.
]

{ #category : #initialize }
LuiComponent >> initializeCssClasses [
	self defaultCssClasses ifEmpty: [ ^self ].
	self properties cssClassesProperty addCssClasses: self defaultCssClasses
]

{ #category : #initialize }
LuiComponent >> initializeNamed: aName on: aWebComponent [
	self 
		componentName: aName;
		parentComponent: aWebComponent
]

{ #category : #testing }
LuiComponent >> isHidden [
	^ self properties isHidden
]

{ #category : #testing }
LuiComponent >> isNotRenderable [
	^ self properties isNotRenderable
]

{ #category : #testing }
LuiComponent >> isRenderable [
	^ self properties isRenderable
]

{ #category : #testing }
LuiComponent >> isTraceOn [
	^false
]

{ #category : #testing }
LuiComponent >> isVisible [
	^ ( self properties propertyAt: 'isHidden' ifAbsent: [ true ] ) value
]

{ #category : #components }
LuiComponent >> lastComponent [
	^ self components values last
]

{ #category : #logging }
LuiComponent >> logRenderingTrace [
	self isTraceOn ifTrue: [
		Transcript
			show: self traceRenderMessage;
			cr ]
]

{ #category : #accessing }
LuiComponent >> parentComponent [
	^ parentComponent
]

{ #category : #accessing }
LuiComponent >> parentComponent: anObject [
	parentComponent := anObject
]

{ #category : #components }
LuiComponent >> parentComponentNamed: aString [
	self componentName = aString ifTrue: [ ^ self ].
	^ self parentComponent
		ifNil: [ nil ]
		ifNotNil: [ :parent |  parent parentComponentNamed: aString ]
]

{ #category : #'gt - views' }
LuiComponent >> parentViewComponents [
	self parentComponent ifNil: [ ^ {} ].
	^Array with: self parentComponent
]

{ #category : #accessing }
LuiComponent >> properties [
	^ properties
]

{ #category : #accessing }
LuiComponent >> properties: anObject [ 
	properties := anObject
]

{ #category : #components }
LuiComponent >> removeComponent: aComponent [
	^ self components removeKey: aComponent componentName ifAbsent: []
]

{ #category : #components }
LuiComponent >> removeComponentNamed: aName [
	^ self removeComponent: (self componentNamed: aName)
]

{ #category : #rendering }
LuiComponent >> renderComponentOn: html [
	self subclassResponsibility
]

{ #category : #rendering }
LuiComponent >> renderContentOn: html [
	self isNotRenderable ifTrue: [ ^ self ].
	self renderComponentOn: html
]

{ #category : #rendering }
LuiComponent >> renderSubcomponentsOn: html [
	self components do: [ :each | html render: each ]
]

{ #category : #'as yet unclassified' }
LuiComponent >> replaceExistingCssClassesWithCssClass: aString [
	self cssClassesProperty replaceExistingCssClassesWithCssClass: aString
]

{ #category : #properties }
LuiComponent >> title [
	^ self properties title
]

{ #category : #properties }
LuiComponent >> title: aString [
	self properties title: aString
]

{ #category : #properties }
LuiComponent >> titleBlock: aBlock [
	self properties titleBlock: aBlock
]

{ #category : #logging }
LuiComponent >> traceRenderMessage [
	^ 'rendering... ' , self class name asString , '     ' , self componentName asString
]
