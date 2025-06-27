Class {
	#name : #LcsSingletonValueObjectsGlobalCollectionSlotBuilder,
	#superclass : #LcsGlobalCollectionSlotBuilder,
	#instVars : [
		'valueObjectSuperclassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder class >> slotClass [
	^ LcsSingletonValueObjectsGlobalCollectionSlot
]

{ #category : #'gt views' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> addClassesToUmlModel: umlModel [
	umlModel addClassNamed: self targetClassName.
	self slotTypes isEmpty ifTrue: [ ^ self ].
	umlModel addClassNamed: self slotTypes first
]

{ #category : #'gt views' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> addExtraPropertiesTo: aBuilder [
	super addExtraPropertiesTo: aBuilder.
	aBuilder addProperty: 'valueObjectSuperclass' value: self valueObjectSuperclassName
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
	aCodeStream addKeyword: 'valueObjectSuperclass' argument: self valueObjectSuperclassName
]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclass [
	^ self valueObjectSuperclassName asClass
]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclassName [
	^ valueObjectSuperclassName
]

{ #category : #accessing }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclassName: aClassName [
	valueObjectSuperclassName := aClassName
]
