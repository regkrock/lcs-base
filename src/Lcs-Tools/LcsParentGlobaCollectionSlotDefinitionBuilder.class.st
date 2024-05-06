Class {
	#name : #LcsParentGlobaCollectionSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'collectionSlotName',
		'moduleName'
	],
	#category : #'Lcs-Tools'
}

{ #category : #'code generation' }
LcsParentGlobaCollectionSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	aCodeStream 
		addSetter: 'collectionSlotName' contents: self collectionSlotName printString;
		addSetter: 'moduleName' contents: self moduleName printString.
	

]

{ #category : #accessing }
LcsParentGlobaCollectionSlotDefinitionBuilder >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsParentGlobaCollectionSlotDefinitionBuilder >> collectionSlotName: aString [
	collectionSlotName := aString
]

{ #category : #initialize }
LcsParentGlobaCollectionSlotDefinitionBuilder >> initialize [
	super initialize.
	self slotName: 'parent'
]

{ #category : #accessing }
LcsParentGlobaCollectionSlotDefinitionBuilder >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsParentGlobaCollectionSlotDefinitionBuilder >> moduleName: aString [
	moduleName := aString
]
