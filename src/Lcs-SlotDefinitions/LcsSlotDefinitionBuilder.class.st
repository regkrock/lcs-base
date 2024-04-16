Class {
	#name : #LcsSlotDefinitionBuilder,
	#superclass : #LcsObject,
	#instVars : [
		'slotName',
		'target',
		'slotDefinitionSelector',
		'targetClassName'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> createGetterAndSetterMethods [
	(RBCreateDomainSlotAcccessorsForVariableRefactoring
		instanceVariable: self slotName
		class: self target) execute
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> createInstanceVariable [
	(RBAddInstanceVariableRefactoring variable: self slotName class: self target)
		execute
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> createSlotDefinitionMethod [
	(RBAddMethodChange
		compile: self slotDefinitionSource
		in: self target class
		classified: #'slot definitions') execute
]

{ #category : #testing }
LcsSlotDefinitionBuilder >> doesSlotDefinitionMethodExist [
	^ self target class includesSelector: self slotDefinitionSelector
]

{ #category : #api }
LcsSlotDefinitionBuilder >> ensureSlotDefinitionMethodDoesNotAlreadyExist [
	self doesSlotDefinitionMethodExist
		ifTrue: [ self error: 'Slot definition already exists' ]
]

{ #category : #api }
LcsSlotDefinitionBuilder >> ensureSlotDoesNotAlreadyExist [
	(self target allInstVarNames includes: self slotName)
		ifTrue: [ self error: 'Slot ' , self slotName , 'already exists' ]
]

{ #category : #api }
LcsSlotDefinitionBuilder >> install [
	self ensureSlotDoesNotAlreadyExist.
	self ensureSlotDefinitionMethodDoesNotAlreadyExist.
	self createInstanceVariable.
	self createGetterAndSetterMethods.
	self createSlotDefinitionMethod
]

{ #category : #configuration }
LcsSlotDefinitionBuilder >> slotDefinitionClass [
	^ self class slotDefinitionClass
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionSelector [
	^ slotDefinitionSelector
		ifNil: [ slotDefinitionSelector := self slotName , 'SlotDefinition' asSymbol ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotDefinitionSelector: aSymbol [
	slotDefinitionSelector := aSymbol asSymbol
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> slotDefinitionSource [
	| codeStream |
"	stream := WriteStream on: String new.
	stream 
		nextPutAll: self slotDefinitionSelector; cr;
		tab; nextPutAll: '<slotDefinition>'; cr;
		tab; nextPutAll: '^ '; nextPutAll: self slotDefinitionClass name; nextPutAll: ' new'; cr;
		tab; tab; nextPutAll: 'slotName: '; nextPutAll: self slotName printString; nextPutAll: ';'; cr.
	self addSlotDefinitionSourceDetailsTo: stream.
	stream
		tab; tab; nextPutAll: 'yourself'.
	^ stream contents"
	
	codeStream := LcsMethodStream new.
	codeStream
		startSlotDefintionSource: self slotName; 
		addSlotDefinitionClassCreatonLine: self slotDefinitionClass;
		addSetter: 'slotName' contents: self slotName printString.
		
	self addSlotDefinitionSourceDetailsTo: codeStream. 
		
	^codeStream 
		addYourself;
		contents

]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotName [
	^ slotName
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> slotName: anObject [
	slotName := anObject
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> target [
	^target ifNil: [ target := self targetClassName asClass ]
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> target: aClass [ 
	target := aClass
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClassName [
	^ targetClassName
]

{ #category : #accessing }
LcsSlotDefinitionBuilder >> targetClassName: anObject [
	targetClassName := anObject
]
