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

{ #category : #initialize }
LcsCodesGlobalSlotDefinitionBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
	super addExtraPropertiesTo: aSlotDefinitionMethodBuilder.
	aSlotDefinitionMethodBuilder.
		self collectionElementTypes do: [ :each |
			aSlotDefinitionMethodBuilder 
				addProperty: 'addCollectionMemberType' 
				value: each ].
	aSlotDefinitionMethodBuilder addProperty: 'loaderClass' value: self loaderClassName
]

{ #category : #'code generation' }
LcsCodesGlobalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	super addSlotDefinitionSourceDetailsTo: aCodeStream .
	aCodeStream addKeyword: 'loaderClass' argument: self loaderClassName

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

{ #category : #command }
LcsCodesGlobalSlotDefinitionBuilder >> populateSlotModel [
	| aModule |
	super populateSlotModel.
	aModule := self module.
	(aModule perform: self getterSelector)
		ifNil: [ aModule initializeSlotNamed: self slotName ]
]
