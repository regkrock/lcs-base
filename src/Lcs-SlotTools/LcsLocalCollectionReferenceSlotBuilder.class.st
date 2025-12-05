Class {
	#name : 'LcsLocalCollectionReferenceSlotBuilder',
	#superclass : 'LcsAccessorSlotBuilder',
	#instVars : [
		'collectionClassName'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'configuration' }
LcsLocalCollectionReferenceSlotBuilder class >> slotClass [
	^ LcsLocalCollectionReferenceSlot
]

{ #category : 'verification' }
LcsLocalCollectionReferenceSlotBuilder >> _verifyCodeInstallation [
	| slotDefinition |
	super _verifyCodeInstallation.
	slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition collectionSlotName equals: self collectionSlotName.
	self assert: slotDefinition collectionSlotName isString
]

{ #category : 'gt views' }
LcsLocalCollectionReferenceSlotBuilder >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
		addAssociation: self slotName
			from: self targetClassName
			to: self slotTypes first asString;
		addAssociation: 'collection'
			from: self slotTypes first asString
			to: self targetClassName
]

{ #category : 'gt views' }
LcsLocalCollectionReferenceSlotBuilder >> addClassesToUmlModel: aUmlModel [
	aUmlModel addClassNamed: self targetClassName.
	self slotTypes isEmpty ifTrue: [ ^ self ].
	aUmlModel addClassNamed: self slotTypes first
]

{ #category : 'gt views' }
LcsLocalCollectionReferenceSlotBuilder >> addParentClassTo: classesModel [
	[ classesModel addClassModelForExisting: self slotTypes first asClass ]
		on: NotFound
		do: [ :s | 
			classesModel proposedClassModelFor: self slotTypes first.
			s return: nil ]
]

{ #category : 'as yet unclassified' }
LcsLocalCollectionReferenceSlotBuilder >> allowNilDescription [
	<magritteDescription>
	^ nil
]

{ #category : 'as yet unclassified' }
LcsLocalCollectionReferenceSlotBuilder >> allowNullDescription [
	<magritteDescription>
	^ nil
]

{ #category : 'code generation' }
LcsLocalCollectionReferenceSlotBuilder >> collectionClass [
	^self collectionClassName asClass
]

{ #category : 'accessing' }
LcsLocalCollectionReferenceSlotBuilder >> collectionClassName [
	^ collectionClassName
]

{ #category : 'accessing' }
LcsLocalCollectionReferenceSlotBuilder >> collectionClassName: anObject [
	collectionClassName := anObject
]

{ #category : 'accessing' }
LcsLocalCollectionReferenceSlotBuilder >> collectionSlotName [
	^ self properties at: 'collectionSlotName' ifAbsent: [ nil ]
]

{ #category : 'accessing' }
LcsLocalCollectionReferenceSlotBuilder >> collectionSlotName: aString [
	self properties at: 'collectionSlotName' put: aString
]

{ #category : 'as yet unclassified' }
LcsLocalCollectionReferenceSlotBuilder >> collectionSlotNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Collection Slot Name';
		priority: 4;
		accessor: #collectionSlotName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isAlphaNumeric ] ] labelled: 'Slot Names can contain only alphanumerics';
		beRequired
]

{ #category : 'gt views' }
LcsLocalCollectionReferenceSlotBuilder >> gtClassBuilderViewFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Steps List';
		priority: 2;
		expandUpTo: 3;
		items: [ self jobSteps ];
		children: [ :step | step jobSteps ];
		"column: 'Number'
			text: [ :step | step stepNumber ] width: 55;"
		column: 'Step'
			text: [ :step | step jobStepDescription ] width: 400;
		column: 'Step Class'
			text: [ :step | step class name ];
		column: ''
			stencil: [ :step | step viewCodeButton ];
		column: 'Status'
			text: [ :step | step state asString asRopedText ]
]

{ #category : 'initialize' }
LcsLocalCollectionReferenceSlotBuilder >> initialize [
	super initialize.
	self slotName: 'parent'
]

{ #category : 'printing' }
LcsLocalCollectionReferenceSlotBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Install slot "';
		nextPutAll: self slotName;
		nextPutAll: '" in ';
		nextPutAll: (self targetClassName ifNil: [ '<missing target class>' ])
]

{ #category : 'command' }
LcsLocalCollectionReferenceSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]

{ #category : 'verification' }
LcsLocalCollectionReferenceSlotBuilder >> verifyUninstall [
	| slotDefinition |
	super verifyUninstall.
	self targetClass ifNil: [ ^ self ].
	slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition collectionSlotName equals: self collectionSlotName.
	self assert: slotDefinition collectionSlotName isString.
]
