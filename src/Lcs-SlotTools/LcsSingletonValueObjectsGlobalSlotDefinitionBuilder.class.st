Class {
	#name : #LcsSingletonValueObjectsGlobalSlotDefinitionBuilder,
	#superclass : #LcsGlobalSlotDefinitionBuilder,
	#instVars : [
		'codeSuperclassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsSingletonValueObjectsGlobalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsSingletonValueObjectsGlobalCollectionSlot
]

{ #category : #initialize }
LcsSingletonValueObjectsGlobalSlotDefinitionBuilder >> addExtraPropertiesTo: aBuilder [
	super addExtraPropertiesTo: aBuilder.
	aBuilder addProperty: 'codeSuperclass' value: self codeSuperclassName
]

{ #category : #'code generation' }
LcsSingletonValueObjectsGlobalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	super addSlotDefinitionSourceDetailsTo: aCodeStream .
	aCodeStream addKeyword: 'codeSuperclass' argument: self codeSuperclassName

]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalSlotDefinitionBuilder >> codeSuperclass [
	^ self codeSuperclassName asClass
]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalSlotDefinitionBuilder >> codeSuperclassName [
	^ codeSuperclassName
]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalSlotDefinitionBuilder >> codeSuperclassName: aClassName [
	codeSuperclassName := aClassName
]
