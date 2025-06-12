Class {
	#name : #LcsGlobalCollectionReferenceSlotBuilder,
	#superclass : #LcsSlotDefinitionBuilder,
	#instVars : [
		'collectionSlotName',
		'collectionSlotModuleName',
		'collectionClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsGlobalCollectionReferenceSlotBuilder class >> slotDefinitionClass [
	^ LcsGlobalCollectionReferenceSlot
]

{ #category : #'code generation' }
LcsGlobalCollectionReferenceSlotBuilder >> addExtraPropertiesTo: aSlotDefinitionMethodBuilder [
	super addExtraPropertiesTo: aSlotDefinitionMethodBuilder.
	aSlotDefinitionMethodBuilder 
		addProperty: 'collectionSlotName' value: self collectionSlotName printString;
		addProperty: 'collectionSlotModuleName' value: self collectionSlotModuleName printString
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceSlotBuilder >> addModelAssociationsTo: classesModel [
	super addModelAssociationsTo: classesModel.
	(classesModel classModelForClassname: self targetClassName)
		addAssociation: self slotName toModelNamed: self collectionClassName.
	(classesModel classModelForClassname: self collectionClassName)
		addAssociation: 'collection' toModelNamed: self targetClassName
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceSlotBuilder >> addParentClassTo: classesModel [
	[ classesModel existingClassModelFor: self slotTypes first asClass ]
		on: NotFound
		do: [ :s | 
			classesModel proposedClassModelFor: self slotTypes first.
			s return: nil ]
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceSlotBuilder >> addStepModelClassesTo: classesModel [
	self slotTypes isEmpty ifTrue: [ ^ self ].
	classesModel addClassNamed: self slotTypes first
]

{ #category : #'code generation' }
LcsGlobalCollectionReferenceSlotBuilder >> collectionClass [
	^ [ self collectionClassName asString asClass ] on: NotFound do: [ :s | s return: nil ]
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceSlotBuilder >> collectionClassName [
	^ self slotTypes first
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionClassName: anObject [
	collectionClassName := anObject
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotModule [
	^ self currentSystem moduleNamed: self collectionSlotModuleName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotModuleName [
	^ collectionSlotModuleName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotModuleName: aString [
	collectionSlotModuleName := aString
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotName [
	^ collectionSlotName
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotName: aString [
	collectionSlotName := aString
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceSlotBuilder >> gtClassBuilderViewFor: aView [
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
LcsGlobalCollectionReferenceSlotBuilder >> initialize [
	super initialize.
	self slotName: 'parent'
]

{ #category : #printing }
LcsGlobalCollectionReferenceSlotBuilder >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Install slot "';
		nextPutAll: self slotName;
		nextPutAll: '" in ';
		nextPutAll: (self targetClassName ifNil: [ '<missing target class>' ])
]

{ #category : #command }
LcsGlobalCollectionReferenceSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ :c | c removeDomainSlotNamed: self slotName ]
]

{ #category : #verification }
LcsGlobalCollectionReferenceSlotBuilder >> verifyCodeInstallation [
	super verifyCodeInstallation.

	"| slotDefinition |
	slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition collectionSlotName equals: self collectionSlotName.
	self assert: slotDefinition collectionSlotName isString.
	self assert:  slotDefinition collectionSlotModuleName equals: self collectionSlotModuleName.
	self assert: slotDefinition collectionSlotModuleName isString."

]

{ #category : #verification }
LcsGlobalCollectionReferenceSlotBuilder >> verifyUninstall [
	"| slotDefinition |"
	super verifyUninstall.
	self targetClass ifNil: [ ^ self ].

	'slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition collectionSlotName equals: self collectionSlotName.
	self assert: slotDefinition collectionSlotName isString.
	self assert:  slotDefinition collectionSlotModuleName equals: self collectionSlotModuleName.
	self assert: slotDefinition collectionSlotModuleName isString.'

]
