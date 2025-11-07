Class {
	#name : #LcsGlobalCollectionReferenceSlotBuilder,
	#superclass : #LcsAccessorSlotBuilder,
	#instVars : [
		'collectionClassName'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #configuration }
LcsGlobalCollectionReferenceSlotBuilder class >> slotClass [
	^ LcsGlobalCollectionReferenceSlot
]

{ #category : #verification }
LcsGlobalCollectionReferenceSlotBuilder >> _verifyCodeInstallation [
	super _verifyCodeInstallation.

	"| slotDefinition |
	slotDefinition := self targetSlotDefinition.
	self assert: slotDefinition collectionSlotName equals: self collectionSlotName.
	self assert: slotDefinition collectionSlotName isString.
	self assert:  slotDefinition collectionSlotModuleName equals: self collectionSlotModuleName.
	self assert: slotDefinition collectionSlotModuleName isString."

]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceSlotBuilder >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	(aUmlModel classModelForClassname: self targetClassName)
		addAssociation: self slotName toModelNamed: self collectionClassName.
	(aUmlModel classModelForClassname: self collectionClassName)
		addAssociation: 'collection' toModelNamed: self targetClassName
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceSlotBuilder >> addClassesToUmlModel: aUmlModel [
	aUmlModel addClassNamed: self targetClassName.
	self slotTypes isEmpty ifTrue: [ ^ self ].
	aUmlModel addClassNamed: self slotTypes first
]

{ #category : #'gt views' }
LcsGlobalCollectionReferenceSlotBuilder >> addParentClassTo: classesModel [
	[ classesModel addClassModelForExisting: self slotTypes first asClass ]
		on: NotFound
		do: [ :s | 
			classesModel proposedClassModelFor: self slotTypes first.
			s return: nil ]
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
	^ self properties at: 'collectionSlotModuleName' ifAbsent: [ nil ]
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotModuleName: aString [
	self properties at: 'collectionSlotModuleName' put: aString
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotName [
	^ self properties at: 'collectionSlotName' ifAbsent: [ nil ]
]

{ #category : #accessing }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotName: aString [
	self properties at: 'collectionSlotName' put: aString
]

{ #category : #magritte }
LcsGlobalCollectionReferenceSlotBuilder >> collectionSlotNameDescription [
	<magritteDescription>
	"| existingInstvarNames |
	existingInstvarNames := self targetClass allInstVarNames."
	^ MAStringDescription new
		label: 'Collection Slot Name';
		priority: 1;
		accessor: #collectionSlotName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		"addCondition: [ :aValue | (existingInstvarNames includes: aValue asString trim asSymbol) not ] labelled: 'Slot already exists';"
		addCondition: [ :aValue | aValue asString trim asSymbol allSatisfy: [ :each | each isAlphaNumeric ] ] labelled: 'Slot Names can contain only alphanumerics';
		beRequired
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

{ #category : #'as yet unclassified' }
LcsGlobalCollectionReferenceSlotBuilder >> umlModel [
	^ super umlModel
		positions: {(296.68288951449927@311.40216064453125). (499.3888888888889@308.0). (350.47889094882544@294.7452011869667). (350.47889094882544@294.7452011869667). (350.47889094882544@323.29755093379276). (350.47889094882544@323.29755093379276)};
		yourself
		
]

{ #category : #command }
LcsGlobalCollectionReferenceSlotBuilder >> uninstall [
	super uninstall.
	self targetClass ifNotNil: [ :c | c removeDomainSlotNamed: self slotName ]
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
