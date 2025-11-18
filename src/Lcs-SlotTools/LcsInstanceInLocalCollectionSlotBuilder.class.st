Class {
	#name : #LcsInstanceInLocalCollectionSlotBuilder,
	#superclass : #LcsAccessorSlotBuilder,
	#instVars : [
		'collectionSourceClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #defaults }
LcsInstanceInLocalCollectionSlotBuilder class >> slotClass [
	^ LcsInstanceInLocalCollectionSlot
]

{ #category : #'gt views' }
LcsInstanceInLocalCollectionSlotBuilder >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	(aUmlModel classModelForClassname: self targetClassName)
		addAssociation: self slotName toModelNamed: self slotTypes any
]

{ #category : #'gt views' }
LcsInstanceInLocalCollectionSlotBuilder >> addClassesToUmlModel: aUmlModel [
	aUmlModel addClassNamed: self targetClassName.
	self currentSystem isNil ifTrue: [ ^ self ].
	aUmlModel addClassNamed: self slotTypes first
]

{ #category : #'gt views' }
LcsInstanceInLocalCollectionSlotBuilder >> addSlotDefinitionSourceDetailsTo: aCodeStream [
	super addSlotDefinitionSourceDetailsTo: aCodeStream.
	aCodeStream
		addKeyword: 'collectionSlotName' argument: (self collectionSlotName ifNil: [ '<missing>' ]) printString;
		addKeyword: 'typeCode' argument: (self typeCode ifNil: [ '<missing>' ]) printString
]

{ #category : #'job steps' }
LcsInstanceInLocalCollectionSlotBuilder >> buildJobSteps [
	self addJobStep: self slotDefinitionMethodBuilder.
	self addJobStep: self getterAndSetterMethodsBuilder
]

{ #category : #accessing }
LcsInstanceInLocalCollectionSlotBuilder >> collectionSlotName [
	^ self properties at: 'collectionSlotName' ifAbsent: [ nil ]
]

{ #category : #properties }
LcsInstanceInLocalCollectionSlotBuilder >> collectionSlotName: anObject [
	self properties at: 'collectionSlotName' put: anObject
]

{ #category : #margritte }
LcsInstanceInLocalCollectionSlotBuilder >> collectionSlotNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Collection slot name';
		priority: 11;
		default: '';
		accessor: #collectionSlotName;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		yourself
]

{ #category : #properites }
LcsInstanceInLocalCollectionSlotBuilder >> collectionSourceClassName [
	^ collectionSourceClassName
]

{ #category : #properites }
LcsInstanceInLocalCollectionSlotBuilder >> collectionSourceClassName: anObject [
	collectionSourceClassName := anObject
]

{ #category : #'builder step' }
LcsInstanceInLocalCollectionSlotBuilder >> slotDefinitionMethodBuilder [
	^ super slotDefinitionMethodBuilder
		beFacadeSlot;
		yourself
]

{ #category : #'gt views' }
LcsInstanceInLocalCollectionSlotBuilder >> sourceCollectionClassName [

	self collectionSourceClassName ifNotNil: [ ^ self collectionSourceClassName ].
	
	^ (self currentSystem moduleNamed: self collectionSlotModuleName) ifNotNil: [ :module | 
		([ module perform: self collectionSlotName asSymbol ] on: MessageNotUnderstood do: [ :s | s return: nil ]) ifNotNil: [ :value | value class name asString ] ]
]

{ #category : #properites }
LcsInstanceInLocalCollectionSlotBuilder >> typeCode [
	^ self properties at: 'typeCode' ifAbsent: [ nil ]
]

{ #category : #properties }
LcsInstanceInLocalCollectionSlotBuilder >> typeCode: anObject [
	self properties at: 'typeCode' put: anObject
]

{ #category : #margritte }
LcsInstanceInLocalCollectionSlotBuilder >> typeCodeDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Type Code';
		priority: 11;
		default: '';
		accessor: #typeCode;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		yourself
]

{ #category : #command }
LcsInstanceInLocalCollectionSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]
