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
	super addModelAssociationsTo: classesModel.
	(classesModel classModelForClassname: self targetClassName)
		addAssociation: self slotName toModelNamed: self sourceCollectionClassName
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [
	super addSlotDefinitionSourceDetailsTo: aCodeStream.
	aCodeStream
		addKeyword: 'collectionSlotName' argument: (self collectionSlotName ifNil: [ '<missing>' ]) printString;
		addKeyword: 'collectionSlotModuleName' argument: (self collectionSlotModuleName ifNil: [ '<missing>' ]) printString
]

{ #category : #'gt view' }
LcsMemberOfSlotBuilder >> addStepModelClassesTo: classesModel [
	classesModel addClassNamed: self targetClassName.
	self currentSystem isNil ifTrue: [ ^ self ].
	classesModel addClassNamed: self sourceCollectionClassName
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

{ #category : #'gt view' }
LcsMemberOfSlotBuilder >> sourceCollectionClassName [
	^ (self currentSystem moduleNamed: self collectionSlotModuleName) ifNotNil: [ :module | 
		(module perform: collectionSlotName asSymbol) ifNotNil: [ :value | value class name asString ] ]
]

{ #category : #command }
LcsMemberOfSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]
