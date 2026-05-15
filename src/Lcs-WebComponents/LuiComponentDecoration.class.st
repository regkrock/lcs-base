Class {
	#name : 'LuiComponentDecoration',
	#superclass : 'Object',
	#instVars : [
		'parent',
		'valueBlock',
		'cachedValue',
		'tagDecorationSetSelector'
	],
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'constant' }
LuiComponentDecoration class >> decorationName [
	self subclassResponsibility
]

{ #category : 'instance creation' }
LuiComponentDecoration class >> on: aProperties [
	^ self new
		initializeOn: aProperties;
		yourself
]

{ #category : 'private' }
LuiComponentDecoration >> _decorationValue [
	^ self valueBlock cull: self component
]

{ #category : 'accessing' }
LuiComponentDecoration >> cachedValue [
	^ cachedValue ifNil: [ cachedValue := self _decorationValue ]
]

{ #category : 'accessing' }
LuiComponentDecoration >> cachedValue: anObject [
	cachedValue := anObject
]

{ #category : 'accessing' }
LuiComponentDecoration >> clearCache [
	self cachedValue: nil
]

{ #category : 'components' }
LuiComponentDecoration >> component [
	^ self parent ifNotNil: [ :decorations | decorations parentComponent ]
]

{ #category : 'asking' }
LuiComponentDecoration >> decorationName [
	^ self class decorationName
]

{ #category : 'asking' }
LuiComponentDecoration >> decorationValue [
	^ self cachedValue
]

{ #category : 'gt views' }
LuiComponentDecoration >> gtComponentFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Parent Component';
		priority: 101;
		object: [ self parent parentComponent ];
		view: #gtComponentsFor:
]

{ #category : 'gt views' }
LuiComponentDecoration >> gtViewDecorationsOn: aView [
	<gtView>
	^ aView forward
		title: 'Parent Decorations';
		priority: 102;
		object: [ self parent ];
		view: #gtViewDecorationsOn:
]

{ #category : 'initialize' }
LuiComponentDecoration >> initialize [
	super initialize.
	self valueBlock: [ ]
]

{ #category : 'initialze' }
LuiComponentDecoration >> initializeOn: aDecorations [ 
	self parent: aDecorations
]

{ #category : 'accessing' }
LuiComponentDecoration >> parent [
	^ parent
]

{ #category : 'accessing' }
LuiComponentDecoration >> parent: anObject [
	parent := anObject
]

{ #category : 'accessing' }
LuiComponentDecoration >> tagDecorationSetSelector [
	^ tagDecorationSetSelector ifNil: [ tagDecorationSetSelector := (self attributeName , ':') asSymbol ]
]

{ #category : 'accessing' }
LuiComponentDecoration >> tagDecorationSetSelector: aSymbol [
	tagDecorationSetSelector := aSymbol
]

{ #category : 'accessing' }
LuiComponentDecoration >> valueBlock [
	^ valueBlock
]

{ #category : 'accessing' }
LuiComponentDecoration >> valueBlock: anObject [
	self clearCache.
	valueBlock := anObject
]
