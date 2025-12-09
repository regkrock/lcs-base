Class {
	#name : 'LcsMemberOfGlobalCollectionSlotBuilder',
	#superclass : 'LcsDomainObjectSlotBuilder',
	#instVars : [
		'collectionSourceClassName'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'defaults' }
LcsMemberOfGlobalCollectionSlotBuilder class >> slotClass [
	^ LcsMemberOfGlobalCollectionSlot
]

{ #category : 'gt views' }
LcsMemberOfGlobalCollectionSlotBuilder >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
		addAssociation: self slotName
		from: self targetClassName
		to: self slotTypes first asString
]

{ #category : 'gt views' }
LcsMemberOfGlobalCollectionSlotBuilder >> addClassesToUmlModel: aUmlModel [
	aUmlModel addClassNamed: self targetClassName.
	self currentSystem isNil ifTrue: [ ^ self ].
	aUmlModel addClassNamed: self slotTypes first
]

{ #category : 'gt views' }
LcsMemberOfGlobalCollectionSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [
	super addSlotDefinitionSourceDetailsTo: aCodeStream.
	aCodeStream
		addKeyword: 'collectionSlotName' argument: (self collectionSlotName ifNil: [ '<missing>' ]) printString;
		addKeyword: 'collectionSlotModuleName' argument: (self collectionSlotModuleName ifNil: [ '<missing>' ]) printString
]

{ #category : 'accessing' }
LcsMemberOfGlobalCollectionSlotBuilder >> collectionSlotModuleName [
	^ self properties at: 'collectionSlotModuleName' ifAbsent: [ nil ]
]

{ #category : 'accessing' }
LcsMemberOfGlobalCollectionSlotBuilder >> collectionSlotModuleName: aString [
	self properties at: 'collectionSlotModuleName' put: aString
]

{ #category : 'margritte' }
LcsMemberOfGlobalCollectionSlotBuilder >> collectionSlotModuleNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Collection slot module name';
		priority: 10;
		default: '';
		accessor: #collectionSlotModuleName;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		yourself
]

{ #category : 'accessing' }
LcsMemberOfGlobalCollectionSlotBuilder >> collectionSlotName [
	^ self properties at: 'collectionSlotName' ifAbsent: [ nil ]
]

{ #category : 'accessing' }
LcsMemberOfGlobalCollectionSlotBuilder >> collectionSlotName: anObject [
	self properties at: 'collectionSlotName' put: anObject
]

{ #category : 'margritte' }
LcsMemberOfGlobalCollectionSlotBuilder >> collectionSlotNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Collection slot name';
		priority: 11;
		default: '';
		accessor: #collectionSlotName;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		yourself
]

{ #category : 'accessing' }
LcsMemberOfGlobalCollectionSlotBuilder >> collectionSourceClassName [
	^ collectionSourceClassName
]

{ #category : 'accessing' }
LcsMemberOfGlobalCollectionSlotBuilder >> collectionSourceClassName: anObject [
	collectionSourceClassName := anObject
]

{ #category : 'gt views' }
LcsMemberOfGlobalCollectionSlotBuilder >> sourceCollectionClassName [

	self collectionSourceClassName ifNotNil: [ ^ self collectionSourceClassName ].
	
	^ (self currentSystem moduleNamed: self collectionSlotModuleName) ifNotNil: [ :module | 
		([ module perform: self collectionSlotName asSymbol ] on: MessageNotUnderstood do: [ :s | s return: nil ]) ifNotNil: [ :value | value class name asString ] ]
]

{ #category : 'command' }
LcsMemberOfGlobalCollectionSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]
