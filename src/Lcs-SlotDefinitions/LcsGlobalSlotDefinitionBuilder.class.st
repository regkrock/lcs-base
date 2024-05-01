Class {
	#name : #LcsGlobalSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'moduleName',
		'slotClass',
		'collectionElementTypes',
		'collectionSlotCollectionClass',
		'targetModule',
		'slotClassName'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #default }
LcsGlobalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsGlobalCollectionSlot
]

{ #category : #configuration }
LcsGlobalSlotDefinitionBuilder >> addCollectionElementType: aClass [
	self collectionElementTypes add: aClass

]

{ #category : #'code generation' }
LcsGlobalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	aCodeStream 
		addSetter: 'addSlotType' contents: self slotClassName;
		addSetter: 'collectionSlotCollectionClass' contents: self collectionSlotCollectionClass name.
	self collectionElementTypes do: [ :eachClass |
		aCodeStream addSetter: 'addCollectionMemberType' contents: eachClass name].
	aCodeStream addCommand: 'beIdentitySetCollection'

]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> collectionElementTypes [
	^ collectionElementTypes
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> collectionElementTypes: anObject [
	collectionElementTypes := anObject
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> collectionSlotCollectionClass [
	^ collectionSlotCollectionClass
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> collectionSlotCollectionClass: anObject [
	collectionSlotCollectionClass := anObject
]

{ #category : #initialize }
LcsGlobalSlotDefinitionBuilder >> initialize [
	super initialize.
	self collectionElementTypes:	OrderedCollection new.
	self collectionSlotCollectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> moduleName [
	^ moduleName
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> moduleName: anObject [
	moduleName := anObject
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotClass [
	^ slotClass 
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotClass: anObject [
	slotClass := anObject
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotClassName [
	^ slotClassName ifNil: [ self slotClass name ]
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotClassName: aName [
	slotClassName := aName
]

{ #category : #configuration }
LcsGlobalSlotDefinitionBuilder >> target [
	^ target ifNil: [ target := 
	 (self targetClassName asClass )
		ifNil: [ self error: 'Module ' , self moduleName , ' not found' ]]
]
