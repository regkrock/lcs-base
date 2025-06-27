Class {
	#name : #LcsMemberOfSlotBuilder,
	#superclass : #LcsAccessorSlotBuilder,
	#instVars : [
		'collectionSlotName',
		'collectionSlotModuleName',
		'collectionSourceClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsMemberOfSlotBuilder class >> slotClass [
	^ LcsMemberOfSlot
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> addAssociationsToUmlModel: aClassesModel [
	super addAssociationsToUmlModel: aClassesModel.
	(aClassesModel classModelForClassname: self targetClassName)
		addAssociation: self slotName toModelNamed: self slotTypes any
]

{ #category : #'gt view' }
LcsMemberOfSlotBuilder >> addClassesToUmlModel: umlModel [
	umlModel addClassNamed: self targetClassName.
	self currentSystem isNil ifTrue: [ ^ self ].
	umlModel addClassNamed: self slotTypes first
]

{ #category : #initialize }
LcsMemberOfSlotBuilder >> addExtraPropertiesTo: aBuilder [
	super addExtraPropertiesTo: aBuilder.
	aBuilder 
		addProperty: 'collectionSlotName' value: self collectionSlotName;
		addProperty: 'collectionSlotModuleName' value: self collectionSlotModuleName
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

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSourceClassName [
	^ collectionSourceClassName
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSourceClassName: anObject [
	collectionSourceClassName := anObject
]

{ #category : #'gt view' }
LcsMemberOfSlotBuilder >> sourceCollectionClassName [

	self collectionSourceClassName ifNotNil: [ ^ self collectionSourceClassName ].
	
	^ (self currentSystem moduleNamed: self collectionSlotModuleName) ifNotNil: [ :module | 
		([ module perform: self collectionSlotName asSymbol ] on: MessageNotUnderstood do: [ :s | s return: nil ]) ifNotNil: [ :value | value class name asString ] ]
]

{ #category : #command }
LcsMemberOfSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]
