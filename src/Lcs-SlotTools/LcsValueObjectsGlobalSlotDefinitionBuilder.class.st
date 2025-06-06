Class {
	#name : #LcsValueObjectsGlobalSlotDefinitionBuilder,
	#superclass : #LcsGlobalSlotDefinitionBuilder,
	#instVars : [
		'codeSuperclassName',
		'loaderClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsValueObjectsGlobalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsCodesGlobalCollectionSlot
]

{ #category : #initialize }
LcsValueObjectsGlobalSlotDefinitionBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
	super addExtraPropertiesTo: aSlotDefinitionMethodBuilder.
	aSlotDefinitionMethodBuilder.
		self collectionElementTypes do: [ :each |
			aSlotDefinitionMethodBuilder 
				addProperty: 'addCollectionMemberType' 
				value: each ].
	aSlotDefinitionMethodBuilder addProperty: 'loaderClass' value: self loaderClassName
]

{ #category : #'code generation' }
LcsValueObjectsGlobalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	super addSlotDefinitionSourceDetailsTo: aCodeStream .
	aCodeStream addKeyword: 'loaderClass' argument: self loaderClassName

]

{ #category : #accessing }
LcsValueObjectsGlobalSlotDefinitionBuilder >> codeSuperclass [
	^ self codeSuperclassName asClass
]

{ #category : #accessing }
LcsValueObjectsGlobalSlotDefinitionBuilder >> codeSuperclassName [
	^ codeSuperclassName
]

{ #category : #accessing }
LcsValueObjectsGlobalSlotDefinitionBuilder >> codeSuperclassName: aClassName [
	codeSuperclassName := aClassName
]

{ #category : #accessing }
LcsValueObjectsGlobalSlotDefinitionBuilder >> laderClass [
	^ self loaderClassName asClass
]

{ #category : #accessing }
LcsValueObjectsGlobalSlotDefinitionBuilder >> loaderClassName [
	^ loaderClassName
]

{ #category : #accessing }
LcsValueObjectsGlobalSlotDefinitionBuilder >> loaderClassName: anObject [
	loaderClassName := anObject
]
