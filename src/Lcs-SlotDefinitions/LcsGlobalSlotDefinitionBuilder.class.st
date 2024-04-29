Class {
	#name : #LcsGlobalSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'moduleName',
		'slotClass',
		'collectionElementTypes',
		'collectionSlotCollectionClass',
		'targetModule'
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
		addSetter: 'addSlotType' contents: self slotClass name;
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
	^ self targetClassName
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> moduleName: anObject [
	self targetClassName: (#LcsBaseModule asClass moduleClassNamed: anObject) name
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotClass [
	^ slotClass
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotClass: anObject [
	slotClass := anObject
]

{ #category : #configuration }
LcsGlobalSlotDefinitionBuilder >> target [
	^ target ifNil: [ target := 
	 (self targetClassName asClass )
		ifNil: [ self error: 'Module ' , self moduleName , ' not found' ]]
]
