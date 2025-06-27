Class {
	#name : #LcsValueObjectsGlobalCollectionSlotBuilder,
	#superclass : #LcsGlobalCollectionSlotBuilder,
	#instVars : [
		'valueObjectSuperclassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsValueObjectsGlobalCollectionSlotBuilder class >> slotClass [
	^ LcsValueObjectsGlobalCollectionSlot
]

{ #category : #'gt views' }
LcsValueObjectsGlobalCollectionSlotBuilder >> addClassesToUmlModel: umlModel [
	umlModel 
		addClassNamed: self collectionClassName;
		addClassNamed: self parentClassName
]

{ #category : #initialize }
LcsValueObjectsGlobalCollectionSlotBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
	super addExtraPropertiesTo: aSlotDefinitionMethodBuilder.
	aSlotDefinitionMethodBuilder.
		self collectionElementTypes do: [ :each |
			aSlotDefinitionMethodBuilder 
				addProperty: 'addCollectionMemberType' 
				value: each ].
	aSlotDefinitionMethodBuilder addProperty: 'loaderClass' value: self loaderClassName
]

{ #category : #'code generation' }
LcsValueObjectsGlobalCollectionSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	super addSlotDefinitionSourceDetailsTo: aCodeStream .
	aCodeStream addKeyword: 'loaderClass' argument: self loaderClassName

]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlotBuilder >> laderClass [
	^ self loaderClassName asClass
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlotBuilder >> loaderClassName [
	^ self properties at: 'loaderClassName' ifAbsent: [ nil ]
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlotBuilder >> loaderClassName: anObject [
	self properties at: 'loaderClassName' put: anObject
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclass [
	^ self valueObjectSuperclassName asClass
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclassName [
	^ valueObjectSuperclassName
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlotBuilder >> valueObjectSuperclassName: aClassName [
	valueObjectSuperclassName := aClassName
]
