Class {
	#name : 'LcsValueObjectsGlobalCollectionSlotBuilder',
	#superclass : 'LcsGlobalCollectionSlotBuilder',
	#instVars : [
		'valueObjectSuperclassName'
	],
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'defaults' }
LcsValueObjectsGlobalCollectionSlotBuilder class >> slotClass [
	^ LcsValueObjectsGlobalCollectionSlot
]

{ #category : 'gt views' }
LcsValueObjectsGlobalCollectionSlotBuilder >> addClassesToUmlModel: aUmlModel [
	aUmlModel 
		addClassNamed: self collectionClassName;
		addClassNamed: self parentClassName
]

{ #category : 'code generation' }
LcsValueObjectsGlobalCollectionSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	super addSlotDefinitionSourceDetailsTo: aCodeStream .
	aCodeStream addKeyword: 'loaderClass' argument: self loaderClassName

]

{ #category : 'accessing' }
LcsValueObjectsGlobalCollectionSlotBuilder >> laderClass [
	^ self loaderClassName asClass
]

{ #category : 'accessing' }
LcsValueObjectsGlobalCollectionSlotBuilder >> loaderClassName [
	^ self propertyAt: #'loaderClass' ifAbsent: [ nil ]
]

{ #category : 'accessing' }
LcsValueObjectsGlobalCollectionSlotBuilder >> loaderClassName: anObject [
	self propertyAt: #'loaderClass' put: anObject
]

{ #category : 'accessing' }
LcsValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclass [
	^ self valueObjectSuperclassName asClass
]

{ #category : 'accessing' }
LcsValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclassName [
	^ valueObjectSuperclassName
]

{ #category : 'accessing' }
LcsValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclassName: aClassName [
	valueObjectSuperclassName := aClassName
]
