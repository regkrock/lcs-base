Class {
	#name : 'LcsMemberOfLocalCollectionSlotBuilder',
	#superclass : 'LcsAccessorSlotBuilder',
	#instVars : [
		'collectionSourceClassName'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'defaults' }
LcsMemberOfLocalCollectionSlotBuilder class >> slotClass [
	^ LcsMemberOfLocalCollectionSlot
]

{ #category : 'gt views' }
LcsMemberOfLocalCollectionSlotBuilder >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
		addAssociation: self slotName
		from: self targetClassName
		to: self slotTypes first asString
]

{ #category : 'gt views' }
LcsMemberOfLocalCollectionSlotBuilder >> addClassesToUmlModel: aUmlModel [
	aUmlModel addClassNamed: self targetClassName.
	self currentSystem isNil ifTrue: [ ^ self ].
	aUmlModel addClassNamed: self slotTypes first
]

{ #category : 'gt views' }
LcsMemberOfLocalCollectionSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [
	super addSlotDefinitionSourceDetailsTo: aCodeStream.
	aCodeStream
		addKeyword: 'collectionSlotName' argument: (self collectionSlotName ifNil: [ '<missing>' ]) printString
]

{ #category : 'accessing' }
LcsMemberOfLocalCollectionSlotBuilder >> collectionSlotName [
	^ self properties at: 'collectionSlotName' ifAbsent: [ nil ]
]

{ #category : 'accessing' }
LcsMemberOfLocalCollectionSlotBuilder >> collectionSlotName: anObject [
	self properties at: 'collectionSlotName' put: anObject
]

{ #category : 'margritte' }
LcsMemberOfLocalCollectionSlotBuilder >> collectionSlotNameDescription [
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
LcsMemberOfLocalCollectionSlotBuilder >> collectionSourceClassName [
	^ collectionSourceClassName
]

{ #category : 'initialize' }
LcsMemberOfLocalCollectionSlotBuilder >> collectionSourceClassName: anObject [
	collectionSourceClassName := anObject
]

{ #category : 'initialize' }
LcsMemberOfLocalCollectionSlotBuilder >> initialize [
	super initialize.
	self targetSlotPath: OrderedCollection new
]

{ #category : 'gt views' }
LcsMemberOfLocalCollectionSlotBuilder >> sourceCollectionClassName [

	self collectionSourceClassName ifNotNil: [ ^ self collectionSourceClassName ].
	
	^ (self currentSystem moduleNamed: self collectionSlotModuleName) ifNotNil: [ :module | 
		([ module perform: self collectionSlotName asSymbol ] on: MessageNotUnderstood do: [ :s | s return: nil ]) ifNotNil: [ :value | value class name asString ] ]
]

{ #category : 'properties' }
LcsMemberOfLocalCollectionSlotBuilder >> targetSlotPath [
	^ self propertyAt: 'targetSlotPath' ifAbsent: []
]

{ #category : 'properties' }
LcsMemberOfLocalCollectionSlotBuilder >> targetSlotPath: aString [ 
	self propertyAt: 'targetSlotPath' put: aString
]

{ #category : 'magritte' }
LcsMemberOfLocalCollectionSlotBuilder >> targetSlotPathDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		  label: 'Target Slot Path';
			accessor: (LcsMAPluggableAccessor 
						accessors: #(#targetSlotPath)
						read: [ :selectors | selectors ] 
						write: [ :aModel :setter :collection | 
							aModel perform: setter with: (collection collect: [ :each | each asSymbol ]) ]);
			classes: { String};
			priority: 35;
			beModifiable;
			labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
			blocListStencil: (
				self
					taggerStencilWithCompletion: GtClassesCompletionStrategy new
					andContextMenuBlock: nil);
			beRequired
]

{ #category : 'command' }
LcsMemberOfLocalCollectionSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]
