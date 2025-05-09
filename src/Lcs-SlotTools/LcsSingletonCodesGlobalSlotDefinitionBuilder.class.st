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

{ #category : #'code generation' }
LcsSingletonCodesGlobalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	super addSlotDefinitionSourceDetailsTo: aCodeStream .
	aCodeStream addSetter: 'codeSuperclass' contents: self codeSuperclassName

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
