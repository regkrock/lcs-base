Class {
	#name : #LcsBaseSlotBuilder,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'slotClassName',
		'slotDefinitionSelector',
		'slotDefinitionTemplate',
		'targetClass',
		'targetClassName',
		'targetModuleClass',
		'targetPackageName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #con }
LcsBaseSlotBuilder class >> slotClass [
	"Subclasses can override this method to provide a default"
]

{ #category : #'code generation' }
LcsBaseSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
]

{ #category : #execute }
LcsBaseSlotBuilder >> commit [
	self buildJobSteps.
	self execute
]

{ #category : #command }
LcsBaseSlotBuilder >> installCode [
	self traceStep: 'installCode'.
	self jobSteps installCode
]

{ #category : #populate }
LcsBaseSlotBuilder >> populateFrom: aSlotClassName [
	self properties removeAll.
	self slotClassName: aSlotClassName.
	self slotDefinitionTemplate: aSlotClassName asClass new.
	self slotName: self slotDefinitionTemplate slotName.
	self slotDefinitionTemplate properties keysAndValuesDo:  [ :key :value |
		self propertyAt: key put: value copy ]
]

{ #category : #accessing }
LcsBaseSlotBuilder >> slotClassName [
	^ slotClassName
]

{ #category : #accessing }
LcsBaseSlotBuilder >> slotClassName: anObject [
	slotClassName := anObject
]

{ #category : #accessing }
LcsBaseSlotBuilder >> slotDefinitionSelector [
	^ slotDefinitionSelector
]

{ #category : #accessing }
LcsBaseSlotBuilder >> slotDefinitionSelector: aSymbolOrNil [
	slotDefinitionSelector := aSymbolOrNil
]

{ #category : #accessing }
LcsBaseSlotBuilder >> slotDefinitionTemplate [
	^ slotDefinitionTemplate
]

{ #category : #accessing }
LcsBaseSlotBuilder >> slotDefinitionTemplate: anObject [ 
	slotDefinitionTemplate := anObject
]

{ #category : #properties }
LcsBaseSlotBuilder >> slotName: anObject [
	| slotName slotDefinitionName|
	slotName := 
		anObject isEmptyOrNil 
			ifTrue: [ anObject ] 
			ifFalse: [(anObject first asLowercase asString , 
						(anObject copyFrom: 2 to: anObject size))].
	self propertyAt: 'slotName' put: slotName.
	slotDefinitionName := 
		anObject isEmptyOrNil 
			ifTrue: [ anObject ] 
			ifFalse: [ (self slotName , 'SlotDefinition') asSymbol].
	self slotDefinitionSelector: slotDefinitionName
]

{ #category : #accessing }
LcsBaseSlotBuilder >> targetClass [
	^ self targetClassName ifNotNil: [ 
		[ self targetClassName asClass ] 
			on: NotFound 
			do: [ :s | s return: nil ] ]
]

{ #category : #accessing }
LcsBaseSlotBuilder >> targetClass: aClass [
	self targetClassName: aClass name
]

{ #category : #accessing }
LcsBaseSlotBuilder >> targetClassName [
	^ targetClassName
]

{ #category : #accessing }
LcsBaseSlotBuilder >> targetClassName: aString [
	targetClassName := aString
]

{ #category : #accessing }
LcsBaseSlotBuilder >> targetModuleClass [
	^ targetModuleClass
]

{ #category : #accessing }
LcsBaseSlotBuilder >> targetModuleClass: aModuleClass [
	targetModuleClass := aModuleClass
]

{ #category : #accessing }
LcsBaseSlotBuilder >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsBaseSlotBuilder >> targetPackageName: anObject [
	targetPackageName := anObject
]
