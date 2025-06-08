Class {
	#name : #LcsLocalCollectionReferenceSlotBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'collectionSlotName',
		'collectionClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsLocalCollectionReferenceSlotBuilder class >> slotDefinitionClass [
	^ LcsLocalCollectionReferenceSlot
]

{ #category : #'code generation' }
LcsLocalCollectionReferenceSlotBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
	super addExtraPropertiesTo: aSlotDefinitionMethodBuilder.
	aSlotDefinitionMethodBuilder 
		addProperty: 'collectionSlotName' value: self collectionSlotName printString
]

{ #category : #'gt views' }
LcsLocalCollectionReferenceSlotBuilder >> addModelAssociationsTo: classesModel [
	super addModelAssociationsTo: classesModel.
	(classesModel classModelForClassname: self targetClassName)
		addAssociation: self slotName toModelNamed: self slotTypes first asString.
	(classesModel classModelForClassname: self slotTypes first asString)
		addAssociation: 'collection' toModelNamed: self targetClassName asString
]

{ #category : #'gt views' }
LcsLocalCollectionReferenceSlotBuilder >> addParentClassTo: classesModel [
	[ classesModel existingClassModelFor: self slotTypes first asClass ]
		on: NotFound
		do: [ :s | 
			classesModel proposedClassModelFor: self slotTypes first.
			s return: nil ]
]

{ #category : #'gt views' }
LcsLocalCollectionReferenceSlotBuilder >> addStepModelClassesTo: classesModel [
	self slotTypes isEmpty ifTrue: [ ^ self ].
	classesModel addClassNamed: self slotTypes first
]

{ #category : #'code generation' }
LcsLocalCollectionReferenceSlotBuilder >> collectionClass [
	^self collectionClassName asClass
]

{ #category : #accessing }
LcsLocalCollectionReferenceSlotBuilder >> collectionClassName [
	^ collectionClassName
]

{ #category : #accessing }
LcsLocalCollectionReferenceSlotBuilder >> collectionClassName: anObject [
	collectionClassName := anObject
]

{ #category : #accessing }
LcsLocalCollectionReferenceSlotBuilder >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsLocalCollectionReferenceSlotBuilder >> collectionSlotName: aString [
	collectionSlotName := aString
]

{ #category : #'gt views' }
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

{ #category : #initialize }
LcsLocalCollectionReferenceSlotBuilder >> initialize [
	super initialize.
	self slotName: 'parent'
]

{ #category : #printing }
LcsLocalCollectionReferenceSlotBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Install slot "';
		nextPutAll: self slotName;
		nextPutAll: '" in ';
		nextPutAll: (self targetClassName ifNil: [ '<missing target class>' ])
]

{ #category : #command }
LcsLocalCollectionReferenceSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ self targetClass removeDomainSlotNamed: self slotName ]
]

{ #category : #verification }
LcsLocalCollectionReferenceSlotBuilder >> verifyCodeInstallation [
	| slotDefinition |
	super verifyCodeInstallation.
	slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition collectionSlotName equals: self collectionSlotName.
	self assert: slotDefinition collectionSlotName isString
]

{ #category : #verification }
LcsLocalCollectionReferenceSlotBuilder >> verifyUninstall [
	| slotDefinition |
	super verifyUninstall.
	self targetClass ifNil: [ ^ self ].
	slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition collectionSlotName equals: self collectionSlotName.
	self assert: slotDefinition collectionSlotName isString.
]
