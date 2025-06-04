Class {
	#name : #LcsMemberOfSlotBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'collectionSlotName',
		'collectionSlotModuleName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsMemberOfSlotBuilder class >> slotDefinitionClass [
	^ LcsMemberOfSlot
]

{ #category : #initialize }
LcsMemberOfSlotBuilder >> addExtraPropertiesTo: aBuilder [
	super addExtraPropertiesTo: aBuilder.
	aBuilder 
		addProperty: 'collectionSlotName' value: self collectionSlotName printString;
		addProperty: 'collectionSlotModuleName' value: self collectionSlotModuleName printString
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> addModelAssociationsTo: classesModel [
	(classesModel classModelForClassname: self targetClassName)
		addAssociation: self slotName toModelNamed: self newDomainClassName
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [
	super addSlotDefinitionSourceDetailsTo: aCodeStream.
	aCodeStream
		addKeyword: 'collectionSlotName' argument: (self collectionSlotName ifNil: [ '<missing>' ]) printString;
		addKeyword: 'collectionSlotModuleName' argument: (self collectionSlotModuleName ifNil: [ '<missing>' ]) printString
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotModuleName [
	^ collectionSlotModuleName
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotModuleName: aString [
	collectionSlotModuleName := aString
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotName: anObject [
	collectionSlotName := anObject
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> domainClass [
	^ self newDomainClassName asClass
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> newDomainClassName [
	^ self parent parent newDomainClassName
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> targetModuleName [
	^ self targetModuleClass defaultModuleName
]

{ #category : #command }
LcsMemberOfSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]
