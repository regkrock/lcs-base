Class {
	#name : #LuiSlotAccessor,
	#superclass : #LuiAccessor,
	#instVars : [
		'readSelector',
		'writeSelector',
		'model',
		'slotName',
		'slotDefinition'
	],
	#category : #'Lcs-WebComponents-Accessor'
}

{ #category : #testing }
LuiSlotAccessor class >> isAbstract [
	^ false
]

{ #category : #'instance creation' }
LuiSlotAccessor class >> read: aReadSelector write: aWriteSelector [
	^ self new
		readSelector: aReadSelector;
		writeSelector: aWriteSelector;
		yourself
]

{ #category : #'instance creation' }
LuiSlotAccessor class >> selector: aSelector [
	^ self new
		selector: aSelector;
		yourself
]

{ #category : #comparing }
LuiSlotAccessor >> = anObject [
	^ super = anObject
		and: [ self readSelector = anObject readSelector
		and: [ self writeSelector = anObject writeSelector ] ]
]

{ #category : #testing }
LuiSlotAccessor >> canRead: aModel [
	^ self readSelector notNil and: [ aModel respondsTo: self readSelector ]
]

{ #category : #testing }
LuiSlotAccessor >> canWrite: aModel [
	^ self writeSelector notNil and: [ aModel respondsTo: self writeSelector ]
]

{ #category : #model }
LuiSlotAccessor >> contents [
	^ self model perform: self readSelector
]

{ #category : #accessing }
LuiSlotAccessor >> defaultLabelFor: aDescription [
	^ self readSelector asString normalizeCamelCase capitalized
]

{ #category : #'as yet unclassified' }
LuiSlotAccessor >> descriptionSelector [
	<magritteDescription>
	^ MASymbolDescription new
			accessor: #selector;
			yourself
]

{ #category : #model }
LuiSlotAccessor >> displayValue [
	^ self model perform: self readSelector
]

{ #category : #testing }
LuiSlotAccessor >> fieldDescription [
	^ self readSelector asString
]

{ #category : #testing }
LuiSlotAccessor >> handlesSelector: aSelector [
	^ aSelector = self readSelector or: [ aSelector = self writeSelector ]
]

{ #category : #comparing }
LuiSlotAccessor >> hash [
	^  super hash bitXor: (self readSelector hash bitXor: self writeSelector hash)
]

{ #category : #accessing }
LuiSlotAccessor >> label [ 
	^ self slotDefinition label
]

{ #category : #accessing }
LuiSlotAccessor >> model [
	^ model
]

{ #category : #accessing }
LuiSlotAccessor >> model: anObject [
	model := anObject
]

{ #category : #accessing }
LuiSlotAccessor >> name [
	^ self readSelector
]

{ #category : #model }
LuiSlotAccessor >> read [
	^ self model perform: self readSelector
]

{ #category : #model }
LuiSlotAccessor >> read: aModel [
	^ aModel perform: self readSelector
]

{ #category : #accessing }
LuiSlotAccessor >> readSelector [
	^ readSelector
]

{ #category : #accessing }
LuiSlotAccessor >> readSelector: anObject [
	readSelector := anObject
]

{ #category : #accessing }
LuiSlotAccessor >> selector [
	^ self readSelector
]

{ #category : #accessing }
LuiSlotAccessor >> selector: aSelector [ 
	self readSelector: aSelector asSymbol.
	self writeSelector: (aSelector greaseString copyWith: $:) asSymbol
]

{ #category : #accessing }
LuiSlotAccessor >> slot: aSlotDefinition [
	^ slotDefinition
]

{ #category : #accessing }
LuiSlotAccessor >> slotDefinition [
	^ slotDefinition
]

{ #category : #accessing }
LuiSlotAccessor >> slotDefinition: aSlotDefinition [
	slotDefinition := aSlotDefinition.
	self selector: aSlotDefinition getterSelector.
	self slotName: aSlotDefinition slotName
]

{ #category : #accessing }
LuiSlotAccessor >> slotName [
	^ slotName
]

{ #category : #accessing }
LuiSlotAccessor >> slotName: anObject [
	slotName := anObject.
	self selector: anObject.
]

{ #category : #printing }
LuiSlotAccessor >> storeOn: aStream [
	aStream nextPut: $(.
	self class storeOn: aStream.
	aStream
		nextPutAll: ' read: ';
		store: self readSelector;
		nextPutAll: ' write: ';
		store: self writeSelector;
		nextPut: $)
]

{ #category : #model }
LuiSlotAccessor >> write: anObject to: aModel [
	^ aModel perform: self writeSelector with: anObject
]

{ #category : #accessing }
LuiSlotAccessor >> writeSelector [
	^ writeSelector
]

{ #category : #accessing }
LuiSlotAccessor >> writeSelector: anObject [
	writeSelector := anObject
]
