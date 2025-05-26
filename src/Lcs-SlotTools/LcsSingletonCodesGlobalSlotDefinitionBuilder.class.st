Class {
	#name : #LcsSingletonCodesGlobalSlotDefinitionBuilder,
	#superclass : #LcsGlobalSlotDefinitionBuilder,
	#instVars : [
		'codeSuperclassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsSingletonCodesGlobalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsSingletonCodesGlobalCollectionSlot
]

{ #category : #initialize }
LcsSingletonCodesGlobalSlotDefinitionBuilder >> addExtraPropertiesTo: aBuilder [
	super addExtraPropertiesTo: aBuilder.
	aBuilder addProperty: 'codeSuperclass' value: self codeSuperclassName
]

{ #category : #'code generation' }
LcsSingletonCodesGlobalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	super addSlotDefinitionSourceDetailsTo: aCodeStream .
	aCodeStream addKeyword: 'codeSuperclass' argument: self codeSuperclassName

]

{ #category : #accessing }
LcsSingletonCodesGlobalSlotDefinitionBuilder >> codeSuperclass [
	^ self codeSuperclassName asClass
]

{ #category : #accessing }
LcsSingletonCodesGlobalSlotDefinitionBuilder >> codeSuperclassName [
	^ codeSuperclassName
]

{ #category : #accessing }
LcsSingletonCodesGlobalSlotDefinitionBuilder >> codeSuperclassName: aClassName [
	codeSuperclassName := aClassName
]

{ #category : #command }
LcsSingletonCodesGlobalSlotDefinitionBuilder >> populateSlotModel [
	super populateSlotModel.
	(self targetClass slotDefinitionNamed: self slotName)
	 	initializeSlotValueIn: self targetModule
]
