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
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsGlobalSlotDefinitionBuilder class >> slotDefinitionClass [
	^ LcsGlobalCollectionSlot
]

{ #category : #'gt views' }
LcsGlobalSlotDefinitionBuilder >> addCollectionElementType: aClass [
	self collectionElementTypes add: aClass
]

{ #category : #initialize }
LcsGlobalSlotDefinitionBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
	super addExtraPropertiesTo: aSlotDefinitionMethodBuilder.
	self collectionElementTypes do: [ :each |
		aSlotDefinitionMethodBuilder 
			addProperty: 'addCollectionMemberType' 
			value: each ]
]

{ #category : #'gt views' }
LcsGlobalSlotDefinitionBuilder >> addModelAssociationsTo: classesModel [
	(classesModel classModelForClassname: self targetModuleClass name asString)
		addAssociation: self slotName toModelNamed: self slotTypes first.
	(classesModel classModelForClassname: self slotTypes first asString)
		addAssociation: 'parent' toModelNamed: self targetModuleClass name asString

]

{ #category : #initialize }
LcsGlobalSlotDefinitionBuilder >> addPropertiesTo: step [ 
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

{ #category : #command }
LcsGlobalSlotDefinitionBuilder >> globalCollectionHome [
	^ self module
]

{ #category : #initialize }
LcsGlobalSlotDefinitionBuilder >> initialize [
	super initialize.
	self collectionElementTypes:	OrderedCollection new.
	self collectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #initialize }
LcsGlobalSlotDefinitionBuilder >> initializeModel [
	(self targetClass slotDefinitionNamed: self slotName)
		initializeSlotValueIn: (self currentSystem moduleNamed: self targetModuleName)
]

{ #category : #command }
LcsGlobalSlotDefinitionBuilder >> module [
	^ self currentSystem moduleNamed: self targetClass defaultModuleName
]

{ #category : #command }
LcsGlobalSlotDefinitionBuilder >> populateSlotModel [
	super populateSlotModel.
	self globalCollectionHome initializeSlotNamed: self slotName 
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
LcsGlobalSlotDefinitionBuilder >> slotTypeClass [
	^ [ self slotTypeClassName asString asClass ] on: NotFound do: [ :s | s return: nil ]
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotTypeClassName [
	^ slotTypeClassName
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> slotTypeClassName: aName [
	slotTypeClassName := aName
]

{ #category : #accessing }
LcsGlobalSlotDefinitionBuilder >> targetModule [
	^ targetModule
	"^ self currentSystem moduleNamed: (self targetModuleName ifNil: [ self targetModuleClass defaultModuleName ])"
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
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamedFromSlotModel: self slotName].
]

{ #category : #command }
LcsGlobalSlotDefinitionBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass ifNotNil: [ self targetClass verifyRemovedDomainSlotNamed: self slotName ]
]
