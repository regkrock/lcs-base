Class {
	#name : 'LuiComponentAttribute',
	#superclass : 'Object',
	#instVars : [
		'parent',
		'valueBlock',
		'cachedValue',
		'tagAttributeSetterSelector'
	],
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
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

{ #category : 'rendering' }
LuiComponentAttribute >> attributeObjectForTag: aTagBrush [ 
	^ self cachedValue
]

{ #category : 'asking' }
LuiComponentAttribute >> attributeValue [
	^ self cachedValue
]

{ #category : 'accessing' }
LuiComponentAttribute >> basicCachedValue [
	^ cachedValue
]

{ #category : 'accessing' }
LuiComponentAttribute >> cachedValue [
	^ cachedValue ifNil: [ cachedValue := self _attributeValue ]
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

{ #category : 'initialize' }
LuiComponentAttribute >> initializeOn: aComponentAttributes [ 
	self parent: aComponentAttributes
]

{ #category : 'accessing' }
LuiComponentAttribute >> parent [
	^ parent
]

{ #category : 'accessing' }
LuiComponentAttribute >> parent: anObject [
	parent := anObject
]

{ #category : 'rendering' }
LuiComponentAttribute >> renderOnTag: aTagBrush [
	aTagBrush
		perform: self tagAttributeSetterSelector
		with: (self attributeObjectForTag: aTagBrush)
]

{ #category : 'accessing' }
LuiComponentAttribute >> tagAttributeSetterSelector [
	^ tagAttributeSetterSelector ifNil: [ tagAttributeSetterSelector := (self attributeName , ':') asSymbol ]
]

{ #category : 'accessing' }
LuiComponentAttribute >> tagAttributeSetterSelector: aSymbol [
	tagAttributeSetterSelector := aSymbol
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
