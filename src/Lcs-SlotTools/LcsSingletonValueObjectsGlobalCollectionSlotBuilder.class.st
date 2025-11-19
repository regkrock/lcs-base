Class {
	#name : 'LcsSingletonValueObjectsGlobalCollectionSlotBuilder',
	#superclass : 'LcsGlobalCollectionSlotBuilder',
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'defaults' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder class >> slotClass [
	^ LcsSingletonValueObjectsGlobalCollectionSlot
]

{ #category : 'gt views' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> addClassesToUmlModel: aUmlModel [
	aUmlModel addClassNamed: self targetClassName.
	self slotTypes isEmpty ifTrue: [ ^ self ].
	aUmlModel addClassNamed: self slotTypes first
]

{ #category : 'gt views' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> addParentClassTo: classesModel [
	[ classesModel addClassModelForExisting: self slotTypes first asClass ]
		on: NotFound
		do: [ :s | 
			classesModel proposedClassModelFor: self slotTypes first.
			s return: nil ]
]

{ #category : 'code generation' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	super addSlotDefinitionSourceDetailsTo: aCodeStream .
	aCodeStream addKeyword: 'valueObjectSuperclass' argument: self valueObjectSuperclassName
]

{ #category : 'accessing' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclass [
	^ self valueObjectSuperclassName asClass
]

{ #category : 'accessing' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclassName [
	^ self properties at: 'valueObjectSuperclassName' ifAbsent: [ nil ]
]

{ #category : 'accessing' }
LcsSingletonValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclassName: aClassName [
	self properties at: 'valueObjectSuperclass' put: aClassName
]
