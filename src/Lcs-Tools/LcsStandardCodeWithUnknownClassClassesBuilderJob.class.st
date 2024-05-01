Class {
	#name : #LcsStandardCodeWithUnknownClassClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeInstances'
	],
	#category : #'Lcs-Tools'
}

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> addCodeSubclassWithRootNamed: aString [
	self addCodeSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> addCodeSubclassWithRootNamed: aString with: aBlock [
	| classBuilder |
	classBuilder := self codeSubclassBuilderFor: aString.
	aBlock value: classBuilder.
	self codeSubclassesBuilderJobSteps addJobStep: classBuilder
]

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeCollectionClassBuilder [
	^ self jobSteps at: 3
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeInstances [
	^ codeInstances
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeInstances: aCollection [
	codeInstances := aCollection
]

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeRootName: aRootName [
	| codeSlotName codesSlotName codeSlotClassName|

	codeSlotName := self codeSlotNameFrom: aRootName.
	codesSlotName := codeSlotName asEnglishPlural.
	codeSlotClassName := self classPrefix , 'Base' , aRootName.
	
	self codeSuperclassBuilder rootName: 'Base' ,aRootName.
	self addCodeSubclassWithRootNamed: aRootName.
	self addCodeSubclassWithRootNamed: ('Unknown' , aRootName)  with: [ :classBuilder | classBuilder beDefaultInstance ].
	self codeCollectionClassBuilder rootName: aRootName asEnglishPlural.
	self globalCollectionSlotBuilder 
		slotClassName: codeSlotClassName;
		slotName: codesSlotName.
	self memberOfSlotInDomainClassBuilder
		collectionSlotName: codesSlotName;
		slotName: codeSlotName
]

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeSubclassBuilderFor: aString [
	^ LcsCodeClassBuilder new
		classPrefix: self classPrefix;
		rootName: aString;
		superclassName: self codeSuperclassBuilder installClassName;
		codePackageName: self codePackageName;
		yourself
]

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeSubclassesBuilderJobSteps [
	^ self jobSteps at: 2
]

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeSuperclassBuilder [
	^ self jobSteps at: 1
]

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeSuperclassRootName: aString [ 
	self codeSuperclassBuilder rootName: 'Base' , aString.
	self memberOfSlotInDomainClassBuilder slotName: ((aString first asLowercase asString) , (aString copyFrom: 2 to: aString size)).
	self addCodeClassBuilder: ((LcsCodeClassBuilder newOn: self)
									rootName: aString;
									superclassName: self codeSuperclassBuilder installClassName;
									yourself ).
	self addCodeClassBuilder: ((LcsCodeClassBuilder newOn: self)
									rootName: 'Unknown' , aString;
									superclassName: self codeSuperclassBuilder installClassName;
									beDefaultInstance;
									yourself ).

]

{ #category : #tests }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> createCodeInstances: aCollection [ 
	self codeInstances addAll: aCollection
]

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> globalCollectionSlotBuilder [
	^ self jobSteps at: 4
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> initialize [
	super initialize.
	self addCodeSuperClassBuilderStep.
	self addCodeSubclassesBuilderJobSteps.
	self addCodeCollectionClassBuilderStep.
	self addGlobalCollectionSlotDefinitionBuilderStep.
	self addMemberOfSlotInDomainClassBuilderStep.
	self codeInstances: OrderedCollection new
]

{ #category : #'job steps' }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> memberOfSlotInDomainClassBuilder [
	^ self jobSteps at: 5
]
