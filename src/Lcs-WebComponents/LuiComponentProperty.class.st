Class {
	#name : #LuiComponentProperty,
	#superclass : #Object,
	#instVars : [
		'parent',
		'valueBlock',
		'cachedValue'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #'instance creation' }
LuiComponentProperty class >> on: aProperties [
	^ self new
		initializeOn: aProperties;
		yourself
]

{ #category : #constant }
LuiComponentProperty class >> propertyName [
	self subclassResponsibility
]

{ #category : #accessing }
LuiComponentProperty >> cachedValue [
	^ cachedValue
]

{ #category : #accessing }
LuiComponentProperty >> cachedValue: anObject [
	cachedValue := anObject
]

{ #category : #accessing }
LuiComponentProperty >> clearCache [
	self cachedValue: nil
]

{ #category : #components }
LuiComponentProperty >> component [
	^ self parent ifNotNil: [ :properties | properties parentComponent ]
]

{ #category : #'as yet unclassified' }
LuiComponentProperty >> initialize [
	super initialize.
	self valueBlock: [ ]
]

{ #category : #initialze }
LuiComponentProperty >> initializeOn: aProperties [ 
	self parent: aProperties
]

{ #category : #accessing }
LuiComponentProperty >> parent [
	^ parent
]

{ #category : #accessing }
LuiComponentProperty >> parent: anObject [
	parent := anObject
]

{ #category : #asking }
LuiComponentProperty >> propertyName [
	^ self class propertyName
]

{ #category : #asking }
LuiComponentProperty >> propertyValue [
	self cachedValue ifNil: [self cachedValue: (self valueBlock cull: self component) ].
	^ self cachedValue
]

{ #category : #accessing }
LuiComponentProperty >> valueBlock [
	^ valueBlock
]

{ #category : #accessing }
LuiComponentProperty >> valueBlock: anObject [
	self clearCache.
	valueBlock := anObject
]
