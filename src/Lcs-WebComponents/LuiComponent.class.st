Class {
	#name : #LuiComponent,
	#superclass : #WAComponent,
	#instVars : [
		'components',
		'cssClasses',
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

{ #category : #asking }
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

{ #category : #asking }
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

{ #category : #accessing }
LuiComponent >> cssClasses [
	^ cssClasses
]

{ #category : #accessing }
LuiComponent >> cssClasses: anObject [
	cssClasses := anObject
]

{ #category : #styling }
LuiComponent >> cssClassesProperty [
	^ self properties propertyAt: LuiCssClassesProperty propertyName ifAbsent: [ nil ]
]

{ #category : #styling }
LuiComponent >> cssClassesString [
	^ (self cssClassesProperty ifNil: [ ^ nil ]) propertyValue ifEmpty: [ nil ]
]

{ #category : #defaults }
LuiComponent >> defaultCssClasses [
	^OrderedCollection new
]

{ #category : #rendering }
LuiComponent >> displayValue [
	^ self domainObject ifNil: [ '' ] displayString
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

{ #category : #initialize }
LuiComponent >> initialize [
	super initialize.
	self components: OrderedDictionary new.
	self properties: (LuiComponentProperties on: self).
	self initializeCssClasses.
]

{ #category : #initialize }
LuiComponent >> initializeCssClasses [
	self defaultCssClasses isEmpty ifTrue: [ ^self ].
	self properties addCssClassProperty
]

{ #category : #initialize }
LuiComponent >> initializeNamed: aName on: aWebComponent [
	self 
		componentName: aName;
		parentComponent: aWebComponent
]

{ #category : #testing }
LuiComponent >> isHidden [
	^ self halt isHidden
]

{ #category : #rendering }
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

{ #category : #'as yet unclassified' }
LuiComponent >> parentViewComponents [
	self parentComponent ifNil: [ ^ {} ].
	^Array with: self parentComponent
]

{ #category : #accessing }
LuiComponent >> properties [
	^ properties
]

{ #category : #initialize }
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
	self isTraceOn ifTrue: [ self renderTraceOn: html ]
]

{ #category : #rendering }
LuiComponent >> renderContentOn: html [
	self renderComponentOn: html
]

{ #category : #rendering }
LuiComponent >> renderSubcomponentsOn: aRenderer [
	self components do: [ :each | aRenderer render: each ]
]

{ #category : #rendering }
LuiComponent >> renderTraceOn: html [
	Transcript
		show: self traceRenderMessage;
		cr
]

{ #category : #rendering }
LuiComponent >> traceRenderMessage [
	^ self class name asString , '     ' , self componentName asString
]
