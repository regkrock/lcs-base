Class {
	#name : #LcsGlobalSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'slotClass',
		'collectionElementTypes',
		'targetModule',
		'slotClassName',
		'targetModuleName',
		'collectionClass'
	],
	#category : #'Lcs-Tools'
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
		addSetter: 'addSlotType' contents: self slotClassName.
	self collectionClass notNil ifTrue: [
		aCodeStream
			addSetter: 'collectionClass' contents: self collectionClass name].
	self collectionElementTypes do: [ :eachClass |
		aCodeStream addSetter: 'addCollectionMemberType' contents: (eachClass isString ifTrue: [ eachClass asClass ] ifFalse: [ eachClass ] ) name].
	self collectionClass isNil ifTrue: [
		aCodeStream addCommand: 'beIdentitySetCollection']

]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> collectionClass [
	^ collectionClass
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> collectionClass: anObject [
	collectionClass := anObject
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> collectionElementTypes [
	^ collectionElementTypes
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> collectionElementTypes: anObject [
	collectionElementTypes := anObject
]

{ #category : #initialize }
LcsGlobalSlotDefinitionBuilder >> initialize [
	super initialize.
	self collectionElementTypes:	OrderedCollection new.
	self collectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> initializeModel [
	(self target slotDefinitionNamed: self slotName) 
		initializeSlotValueIn: (self currentSystem moduleNamed: self targetModuleName)
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> populateSlotModel [
	(self targetModule perform: self slotName asSymbol) ifNil: [ self targetModule initializeSlotNamed: self slotName ]
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
		ifNil: [ self error: 'Module ' , self targetModuleName , ' not found' ]]
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> targetModule [
	^ self currentSystem moduleNamed: (self targetModuleName ifNil: [ self targetModuleClass moduleName ])
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> targetModuleName [
	^ targetModuleName
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> targetModuleName: anObject [
	targetModuleName := anObject
]

{ #category : #builder }
LcsGlobalSlotDefinitionBuilder >> uninstall [
	self target removeDomainSlotNamed: self slotName.
]
