Class {
	#name : 'LuiSmalltalkObjectAccessor',
	#superclass : 'LuiAccessor',
	#instVars : [
		'model',
		'readSelector',
		'writeSelector'
	],
	#category : 'Lcs-WebComponents-Accessor',
	#package : 'Lcs-WebComponents',
	#tag : 'Accessor'
}

{ #category : 'instance creation' }
LuiSmalltalkObjectAccessor class >> newOn: aComponent [
	^ self new
		initializeOn: aComponent;
		yourself
]

{ #category : 'instance creation' }
LuiSmalltalkObjectAccessor class >> newOn: aComponent model: aModel [
	^ self new
		initializeOn: aComponent  model: aModel;
		yourself
]

{ #category : 'instance creation' }
LuiSmalltalkObjectAccessor class >> newOn: aComponent selector: aGetter model: aModel [
	^ self new
		initializeOn: aComponent selector: aGetter model: aModel;
		yourself
]

{ #category : 'testing' }
LuiSmalltalkObjectAccessor >> canRead: aModel [
	^ true
]

{ #category : 'testing' }
LuiSmalltalkObjectAccessor >> canWrite: aModel [
	"Test if ==aModel== can be written."
	^ true
]

{ #category : 'model' }
LuiSmalltalkObjectAccessor >> contents [
	^ self read
]

{ #category : 'accessing' }
LuiSmalltalkObjectAccessor >> defactoModel [
	^ model ifNil: [ self parent model ]
]

{ #category : 'model' }
LuiSmalltalkObjectAccessor >> displayValue [
	^ self contents asString
]

{ #category : 'initialize' }
LuiSmalltalkObjectAccessor >> initialize [
	super initialize.
	self readSelector: #yourself.
	self writeSelector: #yourself
]

{ #category : 'initialize' }
LuiSmalltalkObjectAccessor >> initializeOn: aComponent [ 
	self parent: aComponent
]

{ #category : 'initialize' }
LuiSmalltalkObjectAccessor >> initializeOn: aComponent  model: aModel [
	self 
		parent: aComponent;
		model: aModel
]

{ #category : 'initialize' }
LuiSmalltalkObjectAccessor >> initializeOn: aComponent selector: aGetter model: aModel [
	self 
		parent: aComponent;
		readSelector: aGetter;
		writeSelector: (aGetter , ':') asSymbol;
		model: aModel
]

{ #category : 'accessing' }
LuiSmalltalkObjectAccessor >> model [
	^ model
]

{ #category : 'accessing' }
LuiSmalltalkObjectAccessor >> model: anObject [
	model := anObject
]

{ #category : 'model' }
LuiSmalltalkObjectAccessor >> read [
	^ self model perform: self readSelector
]

{ #category : 'accessing' }
LuiSmalltalkObjectAccessor >> readSelector [
	^ readSelector
]

{ #category : 'accessing' }
LuiSmalltalkObjectAccessor >> readSelector: anObject [
	readSelector := anObject
]

{ #category : 'printing' }
LuiSmalltalkObjectAccessor >> storeOn: aStream [
	aStream nextPut: $(.
	self class storeOn: aStream.
	aStream
		nextPutAll: ' read: ';
		store: self readSelector;
		nextPutAll: ' write: ';
		store: self writeSelector;
		nextPut: $)
]

{ #category : 'model' }
LuiSmalltalkObjectAccessor >> write: anObject [
	self writeSelector = #yourself
		ifTrue: [ self model: anObject]
		ifFalse: [ self model perform: self writeSelector with: anObject ]
]

{ #category : 'model' }
LuiSmalltalkObjectAccessor >> write: anObject to: aModel [
	<deprecated: 'dont think this is used'>
	self writeSelector = #yourself
		ifTrue: [ self model: anObject]
		ifFalse: [ aModel perform: self writeSelector with: anObject ]
]

{ #category : 'accessing' }
LuiSmalltalkObjectAccessor >> writeSelector [
	^ writeSelector
]

{ #category : 'accessing' }
LuiSmalltalkObjectAccessor >> writeSelector: anObject [
	writeSelector := anObject
]
