Class {
	#name : #LcsSlotDefinitionBuilder,
	#superclass : #LcsObject,
	#instVars : [
		'slotName',
		'target',
		'slotDefinitionSelector',
		'targetClassName',
		'parent'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #'instance  creation' }
LcsSlotDefinitionBuilder class >> newOn: aBuilderOrBuilderJob [
	^ self new
		initializeOn: aBuilderOrBuilderJob;
		yourself 
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> addCompletedRefactoring: anObject [ 
	self parent notNil ifTrue: [ self parent addCompletedRefactoring: anObject ]
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> createGetterAndSetterMethods [
	self
		addCompletedRefactoring: (RBCreateDomainSlotAcccessorsForVariableRefactoring
				instanceVariable: self slotName
				class: self target) execute
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> createInstanceVariable [
	"(RBAddInstanceVariableRefactoring variable: self slotName class: self target)"
	self addCompletedRefactoring: (RBAddInstanceVariableChange add: self slotName to: self target)
		execute
]

{ #category : #'code generation' }
LcsSlotDefinitionBuilder >> createSlotDefinitionMethod [
	self
		addCompletedRefactoring: (RBAddMethodChange
				compile: self slotDefinitionSource
				in: self target class
				classified: #'slot definitions') execute
]

{ #category : #testing }
LcsSlotDefinitionBuilder >> doesSlotDefinitionMethodExist [
	^ self target class includesSelector: self slotDefinitionSelector
]

{ #category : #validation }
LcsSlotDefinitionBuilder >> ensureSlotDefinitionMethodDoesNotAlreadyExist [
	self doesSlotDefinitionMethodExist
		ifTrue: [ self error: 'Slot definition already exists' ]
]

{ #category : #validation }
LcsSlotDefinitionBuilder >> ensureSlotDoesNotAlreadyExist [
	(self target allInstVarNames includes: self slotName)
		ifTrue: [ self error: 'Slot ' , self slotName , 'already exists' ]
]

{ #category : #iniitialize }
LcsSlotDefinitionBuilder >> initializeOn: aBuilderOrBuilderJob [ 
	self parent: aBuilderOrBuilderJob
]

{ #category : #api }
LcsSlotDefinitionBuilder >> install [
	self ensureSlotDoesNotAlreadyExist.
	self ensureSlotDefinitionMethodDoesNotAlreadyExist.
	self createInstanceVariable.
	self createGetterAndSetterMethods.
	self createSlotDefinitionMethod
]

{ #category : #acccessing }
LcsSlotDefinitionBuilder >> parent [
	^ parent
]

{ #category : #acccessing }
LcsSlotDefinitionBuilder >> parent: aBuilderOrBuilderJob [ 
	parent := aBuilderOrBuilderJob
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
	.
	slotName := (anObject first asLowercase asString , (anObject copyFrom: 2 to: anObject size))
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
