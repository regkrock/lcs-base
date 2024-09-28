Class {
	#name : #LuiComponent,
	#superclass : #WAComponent,
	#instVars : [
		'components',
		'cssClasses',
		'domainObject',
		'parentComponent',
		'componentId',
		'componentPolicies',
		'componentName'
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
LuiComponent >> addComponent: aComponent [
	| component |
	component := self components at: aComponent componentName put: aComponent.
	component assignId.
	^component
]

{ #category : #asking }
LuiComponent >> addComponentNameTo: names [
	names addFirst: self class name.
	self parentComponent ifNil: [ self addComponentNameTo: names ]
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

{ #category : #accessing }
LuiComponent >> componentPolicies [
	^ componentPolicies
]

{ #category : #accessing }
LuiComponent >> componentPolicies: anObject [
	componentPolicies := anObject
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
LuiComponent >> cssClassesString [
	^ self cssClasses cssClassesString
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

{ #category : #initialize }
LuiComponent >> initialize [
	super initialize.
	self components: OrderedDictionary new.
	self cssClasses: LuiCssClasses new.
	self cssClasses addCssClasses: self defaultCssClasses.
	self componentPolicies: (LuiComponentPolicies on: self)
]

{ #category : #initialize }
LuiComponent >> initializeNamed: aName on: aWebComponent [
	self 
		componentName: aName;
		parentComponent: aWebComponent
]

{ #category : #testing }
LuiComponent >> isHidden [
	^ self componentPolicies isHidden
]

{ #category : #rendering }
LuiComponent >> isTraceOn [
	^true
]

{ #category : #testing }
LuiComponent >> isVisible [
	^ self componentPolicies isVisible
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
LuiComponent >> removeComponent: aComponent [
	^ self components remove: aComponent ifAbsent: []
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
