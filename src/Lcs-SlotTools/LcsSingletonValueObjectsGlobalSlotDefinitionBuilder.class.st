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

{ #category : #'gt views' }
LcsSingletonValueObjectsGlobalSlotDefinitionBuilder >> addExtraPropertiesTo: aBuilder [
	super addExtraPropertiesTo: aBuilder.
	aBuilder addProperty: 'codeSuperclass' value: self codeSuperclassName
]

{ #category : #'gt views' }
LcsSingletonValueObjectsGlobalSlotDefinitionBuilder >> addModelClassesTo: classesModel [
	super addModelClassesTo: classesModel.
	self slotTypes isEmpty ifTrue: [ ^ self ].
	self addParentClassTo: classesModel
]

{ #category : #'gt views' }
LcsSingletonValueObjectsGlobalSlotDefinitionBuilder >> addParentClassTo: classesModel [
	[ classesModel existingClassModelFor: self slotTypes first asClass ]
		on: NotFound
		do: [ :s | 
			classesModel proposedClassModelFor: self slotTypes first.
			s return: nil ]
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
