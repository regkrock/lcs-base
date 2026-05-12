Class {
	#name : 'LuiComponentAttribute',
	#superclass : 'Object',
	#instVars : [
		'parent',
		'valueBlock',
		'cachedValue',
		'tagAttributeSetSelector'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant' }
LuiComponentAttribute class >> attributeName [
	self subclassResponsibility
]

{ #category : 'instance creation' }
LuiComponentAttribute class >> on: aProperties [
	^ self new
		initializeOn: aProperties;
		yourself
]

{ #category : 'private' }
LuiComponentAttribute >> _attributeValue [
	^ self valueBlock cull: self component
]

{ #category : 'asking' }
LuiComponentAttribute >> attributeName [
	^ self class attributeName
]

{ #category : 'asking' }
LuiComponentAttribute >> attributeValue [
	self cachedValue ifNil: [ self cachedValue: self _attributeValue ].
	^ self cachedValue
]

{ #category : 'accessing' }
LuiComponentAttribute >> cachedValue [
	^ cachedValue
]

{ #category : 'accessing' }
LuiComponentAttribute >> cachedValue: anObject [
	cachedValue := anObject
]

{ #category : 'accessing' }
LuiComponentAttribute >> clearCache [
	self cachedValue: nil
]

{ #category : 'components' }
LuiComponentAttribute >> component [
	^ self parent ifNotNil: [ :properties | properties parentComponent ]
]

{ #category : 'gt views' }
LuiComponentAttribute >> gtComponentFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Parent Component';
		priority: 101;
		object: [ self parent parentComponent ];
		view: #gtComponentsFor:
]

{ #category : 'gt views' }
LuiComponentAttribute >> gtViewAttributesOn: aView [
	<gtView>
	
	^ aView forward
		title: 'Parent Properties';
		priority: 102;
		object: [ self parent ];
		view: #gtViewAttributesOn:
]

{ #category : 'initialize' }
LuiComponentAttribute >> initialize [
	super initialize.
	self valueBlock: [ ]
]

{ #category : 'initialze' }
LuiComponentAttribute >> initializeOn: aProperties [ 
	self parent: aProperties
]

{ #category : 'accessing' }
LuiComponentAttribute >> parent [
	^ parent
]

{ #category : 'accessing' }
LuiComponentAttribute >> parent: anObject [
	parent := anObject
]

{ #category : 'accessing' }
LuiComponentAttribute >> tagAttributeSetSelector [
	^ tagAttributeSetSelector ifNil: [ tagAttributeSetSelector := (self attributeName , ':') asSymbol ]
]

{ #category : 'accessing' }
LuiComponentAttribute >> tagAttributeSetSelector: aSymbol [
	tagAttributeSetSelector := aSymbol
]

{ #category : 'accessing' }
LuiComponentAttribute >> valueBlock [
	^ valueBlock
]

{ #category : 'accessing' }
LuiComponentAttribute >> valueBlock: anObject [
	self clearCache.
	valueBlock := anObject
]
