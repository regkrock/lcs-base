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
LcsGlobalCollectionReferenceSlotBuilder >> addModelAssociationsTo: aCollection [
	aCollection add: (self target -> {{self slotName. self collectionClass.}})
]

{ #category : #'code generation' }
LcsGlobalCollectionReferenceSlotBuilder >> collectionClass [
	^self collectionClassName asClass
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionClassName [
	^ collectionClassName
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

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> target [
	^ target ifNil: [ target := self targetClassName asClass ]
]

{ #category : #command }
LcsGlobalCollectionReferenceSlotBuilder >> uninstall [
	super uninstall.
	self target removeDomainSlotNamed: self slotName
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
	| slotDefinition |
	super verifyUninstall.
	([self targetClassName asClass ] on: NotFound do: [ :s | s return: nil ] ) ifNil: [ ^ self ].
	super verifyUninstall.
	slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition collectionSlotName equals: self collectionSlotName.
	self assert: slotDefinition collectionSlotName isString.
	self assert:  slotDefinition collectionSlotModuleName equals: self collectionSlotModuleName.
	self assert: slotDefinition collectionSlotModuleName isString.

]
