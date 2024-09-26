Class {
	#name : #LuiComponent,
	#superclass : #WAComponent,
	#instVars : [
		'components',
		'cssClasses',
		'domainObject',
		'parentComponent',
		'componentId',
		'componentPolicies'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'instance creation' }
LuiComponent class >> on: aWebComponent [
	^ super new 
		initializeOn: aWebComponent;
		yourself
]

{ #category : #asking }
LuiComponent >> addComponentNameTo: names [
	names addFirst: self class name.
	self parentComponent ifNil: [ self addComponentNameTo: names ]
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

{ #category : #initialize }
LuiComponent >> initialize [
	super initialize.
	self components: OrderedDictionary new.
	self cssClasses: LuiCssClasses new.
	self componentPolicies: (LuiComponentPolicies on: self)
]

{ #category : #initialize }
LuiComponent >> initializeOn: aWebComponent [ 
	self parentComponent: aWebComponent
]

{ #category : #'as yet unclassified' }
LuiComponent >> isVisible [
	^ self componentPolcies
]

{ #category : #accessing }
LuiComponent >> parentComponent [
	^ parentComponent
]

{ #category : #accessing }
LuiComponent >> parentComponent: anObject [
	parentComponent := anObject
]

{ #category : #rendering }
LuiComponent >> renderContentOn: aRenderer [
	self renderSubcomponentsOn: aRenderer
]

{ #category : #rendering }
LuiComponent >> renderSubcomponentsOn: aRenderer [
	self components do: [ :each | each renderComponentOn: aRenderer ]
]
