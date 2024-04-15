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

{ #category : #con }
LcsGlobalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsGlobalCollectionSlot
]

{ #category : #api }
LcsGlobalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: stream [ 
	stream 
		tab; tab; nextPutAll: 'addSlotType: ' , self slotClass name; nextPutAll: ';'; cr;
		tab; tab; nextPutAll: 'collectionSlotCollectionClass: ' , self collectionSlotCollectionClass name; nextPutAll: ';'; cr.
	self collectionElementTypes do: [ :eachClass |
		stream
			tab; tab; nextPutAll: 'addCollectionMemberType: '; nextPutAll: eachClass name; nextPutAll: ';'; cr].
	stream
		tab; tab; nextPutAll: 'beIdentitySetCollection'; nextPutAll: ';'; cr
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

{ #category : #api }
LcsGlobalSlotDefinitionBuilder >> install [
	self ensureSlotDoesNotAlreadyExist.
	self ensureSlotDefinitionMethodDoesNotAlreadyExist.
	self createInstanceVariable.
	self createGetterAndSetterMethods.
	self createSlotDefinitionMethod
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> moduleName [
	^ self targetClassName
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> moduleName: anObject [
	self targetClassName: (LcsBaseModule moduleClassNamed: anObject) name
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotClass [
	^ slotClass
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotClass: anObject [
	slotClass := anObject
]

{ #category : #api }
LcsGlobalSlotDefinitionBuilder >> target [
	^ target ifNil: [ target := 
	 (self targetClassName asClass )
		ifNil: [ self error: 'Module ' , self moduleName , ' not found' ]]
]
