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
LcsLocalCollectionReferenceSlotBuilder >> addModelAssociationsTo: aCollection [
	aCollection add: (self target -> {{self slotName. self collectionClass.}})
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

{ #category : #accessing }
LcsLocalCollectionReferenceSlotBuilder >> target [
	^ target ifNil: [ target := self targetClassName asClass ]
]

{ #category : #command }
LcsLocalCollectionReferenceSlotBuilder >> uninstall [
	self target removeDomainSlotNamed: self slotName
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
	([self targetClassName asClass ] on: NotFound do: [ :s | s return: nil ] ) ifNil: [ ^ self ].
	super verifyUninstall.
	slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition collectionSlotName equals: self collectionSlotName.
	self assert: slotDefinition collectionSlotName isString.
]
