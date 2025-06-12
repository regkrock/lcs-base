Class {
	#name : #LcsGlobalCollectionSlotBuilder,
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
LcsGlobalCollectionSlotBuilder class >> slotDefinitionClass [
	^ LcsGlobalCollectionSlot
]

{ #category : #'gt views' }
LcsGlobalCollectionSlotBuilder >> addCollectionElementType: aClass [
	self collectionElementTypes add: aClass
]

{ #category : #initialize }
LcsGlobalCollectionSlotBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
	super addExtraPropertiesTo: aSlotDefinitionMethodBuilder.
	self collectionElementTypes do: [ :each |
		aSlotDefinitionMethodBuilder 
			addProperty: 'addCollectionMemberType' 
			value: each ]
]

{ #category : #'gt views' }
LcsGlobalCollectionSlotBuilder >> addModelAssociationsTo: classesModel [
	super addModelAssociationsTo: classesModel.
	(classesModel classModelForClassname: self parentClassName)
		addAssociation: self slotName toModelNamed: self collectionClassName.
	(classesModel classModelForClassname: self collectionClassName)
		addAssociation: 'parent' toModelNamed: self parentClassName
]

{ #category : #initialize }
LcsGlobalCollectionSlotBuilder >> addPropertiesTo: step [ 
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> collectionClass [
	^ collectionClass
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> collectionClass: anObject [
	collectionClass := anObject
]

{ #category : #'gt views' }
LcsGlobalCollectionSlotBuilder >> collectionClassName [
	^ self slotTypes first asString
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> collectionElementTypes [
	^ collectionElementTypes
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> collectionElementTypes: anObject [
	collectionElementTypes := anObject
]

{ #category : #command }
LcsGlobalCollectionSlotBuilder >> globalCollectionHome [
	^ self module
]

{ #category : #initialize }
LcsGlobalCollectionSlotBuilder >> initialize [
	super initialize.
	self collectionElementTypes:	OrderedCollection new.
	self collectionClass: LcsSmalltalkConfiguration identitySetClass
]

{ #category : #initialize }
LcsGlobalCollectionSlotBuilder >> initializeModel [
	(self targetClass slotDefinitionNamed: self slotName)
		initializeSlotValueIn: (self currentSystem moduleNamed: self targetModuleName)
]

{ #category : #command }
LcsGlobalCollectionSlotBuilder >> module [
	^ self currentSystem moduleNamed: self targetClass defaultModuleName
]

{ #category : #'gt views' }
LcsGlobalCollectionSlotBuilder >> parentClassName [
	^ self targetModuleClass name asString
]

{ #category : #command }
LcsGlobalCollectionSlotBuilder >> populateSlotModel [
	super populateSlotModel.
	self globalCollectionHome initializeSlotNamed: self slotName 
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> slotClass [
	^ slotClass 
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> slotClass: anObject [
	slotClass := anObject
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> slotTypeClass [
	^ [ self slotTypeClassName asString asClass ] on: NotFound do: [ :s | s return: nil ]
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> slotTypeClassName [
	^ slotTypeClassName
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> slotTypeClassName: aName [
	slotTypeClassName := aName
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> targetModule [
	^ targetModule
	"^ self currentSystem moduleNamed: (self targetModuleName ifNil: [ self targetModuleClass defaultModuleName ])"
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> targetModuleName [
	^ targetModuleName
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> targetModuleName: anObject [
	targetModuleName := anObject
]

{ #category : #command }
LcsGlobalCollectionSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamedFromSlotModel: self slotName].
]

{ #category : #command }
LcsGlobalCollectionSlotBuilder >> verifyUninstall [
	super verifyUninstall.
	self targetClass ifNotNil: [ self targetClass verifyRemovedDomainSlotNamed: self slotName ]
]
