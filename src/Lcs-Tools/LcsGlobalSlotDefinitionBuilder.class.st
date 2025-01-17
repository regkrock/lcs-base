Class {
	#name : #LcsGlobalSlotDefinitionBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'slotClass',
		'collectionElementTypes',
		'targetModule',
		'targetModuleName',
		'collectionClass',
		'slotTypeClassName'
	],
	#category : #'Lcs-Tools'
}

{ #category : #default }
LcsGlobalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsGlobalCollectionSlot
]

{ #category : #'gt view' }
LcsGlobalSlotDefinitionBuilder >> addCollectionElementType: aClass [
	self collectionElementTypes add: aClass

]

{ #category : #'gt view' }
LcsGlobalSlotDefinitionBuilder >> addModelAssociationsTo: aCollection [
	aCollection 
		add: (self targetModuleClass -> {{self slotName. self slotTypeClass.}});
		add: (self slotTypeClass -> {{'parent'. self targetModuleClass.}})

]

{ #category : #'code generation' }
LcsGlobalSlotDefinitionBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [ 
	aCodeStream 
		addSetter: 'addSlotType' contents: self slotTypeClassName.
	self collectionClass notNil ifTrue: [
		aCodeStream
			addSetter: 'collectionClass' contents: self collectionClass name].
	self collectionElementTypes do: [ :eachClass |
		aCodeStream addSetter: 'addCollectionMemberType' contents: (eachClass isString ifTrue: [ eachClass ] ifFalse: [ eachClass name ] )].
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

{ #category : #initialize }
LcsGlobalSlotDefinitionBuilder >> initializeModel [
	(self target slotDefinitionNamed: self slotName) 
		initializeSlotValueIn: (self currentSystem moduleNamed: self targetModuleName)
]

{ #category : #command }
LcsGlobalSlotDefinitionBuilder >> populateSlotModel [
	(self target perform: self slotName asSymbol) ifNil: [ self target initializeSlotNamed: self slotName ]
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
LcsGlobalSlotDefinitionBuilder >> slotClassName: aName [
	slotTypeClassName := aName
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotTypeClass [
	^ self slotTypeClassName asClass
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotTypeClassName [
	^ slotTypeClassName ifNil: [ self slotClass name ]
]

{ #category : #configuration }
LcsGlobalSlotDefinitionBuilder >> target [
	^ target ifNil: [ 
		target := self targetClassName ifNotNil: [ self targetClassName asClass ] ]
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

{ #category : #command }
LcsGlobalSlotDefinitionBuilder >> uninstall [
	self target removeDomainSlotNamed: self slotName.
]
