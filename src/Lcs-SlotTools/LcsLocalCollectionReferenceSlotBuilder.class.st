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
	(aUmlModel classModelForClassname: self targetClassName)
		addAssociation: self slotName toModelNamed: self slotTypes first asString.
	(aUmlModel classModelForClassname: self slotTypes first asString)
		addAssociation: 'collection' toModelNamed: self targetClassName asString
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
