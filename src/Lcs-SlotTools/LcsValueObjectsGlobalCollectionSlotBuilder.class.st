Class {
	#name : #LcsValueObjectsGlobalCollectionSlotBuilder,
	#superclass : #LcsGlobalCollectionSlotBuilder,
	#instVars : [
		'codeSuperclassName',
		'loaderClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsValueObjectsGlobalCollectionSlotBuilder class >> slotDefinitionClass [
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
LcsValueObjectsGlobalCollectionSlotBuilder >> codeSuperclass [
	^ self codeSuperclassName asClass
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlotBuilder >> codeSuperclassName [
	^ codeSuperclassName
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlotBuilder >> codeSuperclassName: aClassName [
	codeSuperclassName := aClassName
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlotBuilder >> laderClass [
	^ self loaderClassName asClass
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlotBuilder >> loaderClassName [
	^ loaderClassName
]

{ #category : #accessing }
LcsValueObjectsGlobalCollectionSlotBuilder >> loaderClassName: anObject [
	loaderClassName := anObject
]
