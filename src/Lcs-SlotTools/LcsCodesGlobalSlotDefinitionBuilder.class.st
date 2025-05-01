Class {
	#name : #LcsCodesGlobalSlotDefinitionBuilder,
	#superclass : #LcsGlobalSlotDefinitionBuilder,
	#instVars : [
		'codeSuperclassName',
		'loaderClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsCodesGlobalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsCodesGlobalCollectionSlot
]

{ #category : #'code generation' }
LcsCodesGlobalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	super addSlotDefinitionSourceDetailsTo: aCodeStream .
	aCodeStream addSetter: 'loaderClass' contents: self loaderClassName

]

{ #category : #accessing }
LcsCodesGlobalSlotDefinitionBuilder >> codeSuperclass [
	^ self codeSuperclassName asClass
]

{ #category : #accessing }
LcsCodesGlobalSlotDefinitionBuilder >> codeSuperclassName [
	^ codeSuperclassName
]

{ #category : #accessing }
LcsCodesGlobalSlotDefinitionBuilder >> codeSuperclassName: aClassName [
	codeSuperclassName := aClassName
]

{ #category : #accessing }
LcsCodesGlobalSlotDefinitionBuilder >> laderClass [
	^ self loaderClassName asClass
]

{ #category : #accessing }
LcsCodesGlobalSlotDefinitionBuilder >> loaderClassName [
	^ loaderClassName
]

{ #category : #accessing }
LcsCodesGlobalSlotDefinitionBuilder >> loaderClassName: anObject [
	loaderClassName := anObject
]
