Class {
	#name : #LcsGlobalCollectionReferenceDefinitionSlotBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'collectionSlotName',
		'collectionSlotModuleName',
		'collectionClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsGlobalCollectionReferenceDefinitionSlotBuilder class >> slotDefinitionClass [
	^ LcsGlobalCollectionReferenceSlot
]

{ #category : #'code generation' }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
	super addExtraPropertiesTo: aSlotDefinitionMethodBuilder.
	aSlotDefinitionMethodBuilder 
		addProperty: 'collectionSlotName' value: self collectionSlotName printString;
		addProperty: 'collectionSlotModuleName' value: self collectionSlotModuleName printString
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> addModelAssociationsTo: classesModel [
	super addModelAssociationsTo: self slotTypes first.
	(classesModel classModelForClassname: self targetClassName)
		addAssociation: self slotName toModelNamed: self slotTypes first.
	(classesModel classModelForClassname: self slotTypes first)
		addAssociation: 'collection' toModelNamed: self targetClassName
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> addModelClassesTo: classesModel [
	super addModelClassesTo: classesModel.
	self slotTypes isEmpty ifTrue: [ ^ self ].
	self addParentClassTo: classesModel
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> addParentClassTo: classesModel [
	[ classesModel existingClassModelFor: self slotTypes first asClass ]
		on: NotFound
		do: [ :s | 
			classesModel proposedClassModelFor: self slotTypes first.
			s return: nil ]
]

{ #category : #'code generation' }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> collectionClass [
	^ [ self collectionClassName asString asClass ] on: NotFound do: [ :s | s return: nil ]
]

{ #category : #accessing }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> collectionClassName [
	^ collectionClassName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> collectionClassName: anObject [
	collectionClassName := anObject
]

{ #category : #accessing }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> collectionSlotModule [
	^ self currentSystem moduleNamed: self collectionSlotModuleName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> collectionSlotModuleName [
	^ collectionSlotModuleName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> collectionSlotModuleName: aString [
	collectionSlotModuleName := aString
]

{ #category : #accessing }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> collectionSlotName: aString [
	collectionSlotName := aString
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> gtClassBuilderViewFor: aView [
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
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> initialize [
	super initialize.
	self slotName: 'parent'
]

{ #category : #printing }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Install slot "';
		nextPutAll: self slotName;
		nextPutAll: '" in ';
		nextPutAll: (self targetClassName ifNil: [ '<missing target class>' ])
]

{ #category : #command }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ :c | c removeDomainSlotNamed: self slotName ]
]

{ #category : #verification }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.

	"| slotDefinition |
	slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition collectionSlotName equals: self collectionSlotName.
	self assert: slotDefinition collectionSlotName isString.
	self assert:  slotDefinition collectionSlotModuleName equals: self collectionSlotModuleName.
	self assert: slotDefinition collectionSlotModuleName isString."

]

{ #category : #verification }
LcsGlobalCollectionReferenceDefinitionSlotBuilder >> verifyUninstall [
	"| slotDefinition |"
	super verifyUninstall.
	self targetClass ifNil: [ ^ self ].

	'slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition collectionSlotName equals: self collectionSlotName.
	self assert: slotDefinition collectionSlotName isString.
	self assert:  slotDefinition collectionSlotModuleName equals: self collectionSlotModuleName.
	self assert: slotDefinition collectionSlotModuleName isString.'

]
