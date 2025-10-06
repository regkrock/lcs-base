Class {
	#name : #LcsMemberOfSlotBuilder,
	#superclass : #LcsAccessorSlotBuilder,
	#instVars : [
		'collectionSourceClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsMemberOfSlotBuilder class >> slotClass [
	^ LcsMemberOfSlot
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> addAssociationsToUmlModel: umlModel [
	super addAssociationsToUmlModel: umlModel.
	(umlModel classModelForClassname: self targetClassName)
		addAssociation: self slotName toModelNamed: self slotTypes any
]

{ #category : #'gt views' }
LcsMemberOfSlotBuilder >> addClassesToUmlModel: umlModel [
	umlModel addClassNamed: self targetClassName.
	self currentSystem isNil ifTrue: [ ^ self ].
	umlModel addClassNamed: self slotTypes first
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
	^ self properties at: 'collectionSlotModuleName' ifAbsent: [ nil ]
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotModuleName: aString [
	self properties at: 'collectionSlotModuleName' put: aString
]

{ #category : #margritte }
LcsMemberOfSlotBuilder >> collectionSlotModuleNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Collection slot module name';
		priority: 10;
		default: '';
		accessor: #collectionSlotModuleName;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		yourself
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotName [
	^ self properties at: 'collectionSlotName' ifAbsent: [ nil ]
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSlotName: anObject [
	self properties at: 'collectionSlotName' put: anObject
]

{ #category : #margritte }
LcsMemberOfSlotBuilder >> collectionSlotNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Collection slot name';
		priority: 11;
		default: '';
		accessor: #collectionSlotName;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		yourself
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSourceClassName [
	^ collectionSourceClassName
]

{ #category : #accessing }
LcsMemberOfSlotBuilder >> collectionSourceClassName: anObject [
	collectionSourceClassName := anObject
]

{ #category : #'gt views' }
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
