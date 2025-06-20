Class {
	#name : #LcsSingletonValueObjectsGlobalCollectionSlotBuilder,
	#superclass : #LcsGlobalCollectionSlotBuilder,
	#instVars : [
		'codeSuperclassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder class >> slotDefinitionClass [
	^ LcsSingletonValueObjectsGlobalCollectionSlot
]

{ #category : #'gt views' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> addExtraPropertiesTo: aBuilder [
	super addExtraPropertiesTo: aBuilder.
	aBuilder addProperty: 'codeSuperclass' value: self codeSuperclassName
]

{ #category : #'gt views' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> addParentClassTo: classesModel [
	[ classesModel existingClassModelFor: self slotTypes first asClass ]
		on: NotFound
		do: [ :s | 
			classesModel proposedClassModelFor: self slotTypes first.
			s return: nil ]
]

{ #category : #'code generation' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	super addSlotDefinitionSourceDetailsTo: aCodeStream .
	aCodeStream addKeyword: 'codeSuperclass' argument: self codeSuperclassName

]

{ #category : #'gt views' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> addStepModelClassesTo: aClassesModel [
	aClassesModel addClassNamed: self targetClassName.
	self slotTypes isEmpty ifTrue: [ ^ self ].
	aClassesModel addClassNamed: self slotTypes first
]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> codeSuperclass [
	^ self codeSuperclassName asClass
]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> codeSuperclassName [
	^ codeSuperclassName
]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> codeSuperclassName: aClassName [
	codeSuperclassName := aClassName
]
