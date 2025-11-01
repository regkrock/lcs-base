Class {
	#name : #LcsGlobalCollectionSlotBuilder,
	#superclass : #LcsAccessorSlotBuilder,
	#instVars : [
		'slotClass',
		'targetModule',
		'targetModuleName',
		'collectionClass',
		'slotTypeClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsGlobalCollectionSlotBuilder class >> slotClass [
	^ LcsGlobalCollectionSlot
]

{ #category : #'gt views' }
LcsGlobalCollectionSlotBuilder >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	(aUmlModel classModelForClassname: self parentClassName)
		addAssociation: self slotName toModelNamed: self collectionClassName.
	(aUmlModel classModelForClassname: self collectionClassName)
		addAssociation: 'parent' toModelNamed: self parentClassName
]

{ #category : #'gt views' }
LcsGlobalCollectionSlotBuilder >> addClassesToUmlModel: aUmlModel [
	super addClassesToUmlModel: aUmlModel.
	aUmlModel 
		addClassNamed: self targetClassName;
		addClassNamed: self parentClassName;
		addClassNamed: self collectionClassName
]

{ #category : #'gt views' }
LcsGlobalCollectionSlotBuilder >> addCollectionMemberType: aClass [
	self collectionMemberTypes add: aClass
]

{ #category : #magritte }
LcsGlobalCollectionSlotBuilder >> allowNilDescription [
	^ super allowNilDescription
		beReadOnly;
		yourself
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
LcsGlobalCollectionSlotBuilder >> collectionMemberTypes [
	^ self properties at: 'collectionMemberTypes' ifAbsent: [ OrderedCollection new ]
]

{ #category : #accessing }
LcsGlobalCollectionSlotBuilder >> collectionMemberTypes: anObject [
	self properties at: 'collectionMemberTypes' put: anObject
]

{ #category : #command }
LcsGlobalCollectionSlotBuilder >> globalCollectionHome [
	^ self module
]

{ #category : #initialize }
LcsGlobalCollectionSlotBuilder >> initialize [
	super initialize.
	self collectionMemberTypes: OrderedCollection new.
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
