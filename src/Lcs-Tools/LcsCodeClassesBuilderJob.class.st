Class {
	#name : #LcsCodeClassesBuilderJob,
	#superclass : #LcsClassesBuilderJob,
	#instVars : [
		'codeSuperclassBuilder',
		'codeCollectionClassBuilder',
		'memberOfSlotBuilder',
		'codeClassBuilders',
		'collectionSlotBuilder'
	],
	#category : #'Lcs-Tools'
}

{ #category : #initialize }
LcsCodeClassesBuilderJob >> adCodeSubclassesBuilderJobSteps [
	self addJobStep: LcsCodeBuilderJobSteps new
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> addCodeClassBuilder: aCodeClassBuilder [
	 aCodeClassBuilder superclassName: self codeSuperclassBuilder installClassName.
	 (self jobSteps at: 2) addJobStep: aCodeClassBuilder
]

{ #category : #initialize }
LcsCodeClassesBuilderJob >> addCodeCollectionClassBuilderStep [
	self addJobStep: LcsCodeCollectionClassBuilder new
]

{ #category : #initialize }
LcsCodeClassesBuilderJob >> addCodeSuperClassBuilderStep [
	self addJobStep: LcsCodeSuperClassBuilder new
]

{ #category : #initialize }
LcsCodeClassesBuilderJob >> addGlobalCollectionSlotDefinitionBuilderStep [
	self addJobStep: LcsGlobalSlotDefinitionBuilder new
]

{ #category : #initialize }
LcsCodeClassesBuilderJob >> addJobStep: aBuilderJobStep [ 
	aBuilderJobStep parent: self.
	self jobSteps add: aBuilderJobStep
]

{ #category : #initialize }
LcsCodeClassesBuilderJob >> addMemberOfSlotInDomainClassBuilderStep [
	self addJobStep: LcsMemberOfSlotBuilder new
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeClassBuilders [
	^ codeClassBuilders
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeClassBuilders: anObject [ 
	codeClassBuilders := anObject
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeCollectionClassBuilder [
	^ self jobSteps at: 4
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeSuperclassBuilder [
	^ self jobSteps at: 1
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeSuperclassBuilder: anObject [
	codeSuperclassBuilder := anObject
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> codeSuperclassRootName: aString [ 
	self codeSuperclassBuilder rootName: aString.
	self memberOfSlotBuilder slotName: aString
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> collectionSlotBuilder [
	^ collectionSlotBuilder
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> collectionSlotBuilder: anObject [
	collectionSlotBuilder := anObject
]

{ #category : #initialize }
LcsCodeClassesBuilderJob >> initialize [
	super initialize.
	self addCodeSuperClassBuilderStep.
	self adCodeSubclassesBuilderJobSteps.
	self addCodeCollectionClassBuilderStep.
	self addGlobalCollectionSlotDefinitionBuilderStep.
	self addMemberOfSlotInDomainClassBuilderStep.
	self addJobStep: LcsGlobalSlotDefinitionBuilder new
]

{ #category : #build }
LcsCodeClassesBuilderJob >> install [
	self jobSteps do: [:each | each install ]
	"self installCodeSuperclass.
	self codeClassBuilders do: [ :each | each install ].
	self installCodesCollectionClass.
	self installCodesSlotInModule.
	self installDomainClassSlot"
]

{ #category : #build }
LcsCodeClassesBuilderJob >> installCodeSuperclass [
	self codeSuperclassBuilder install.
	self collectionSlotBuilder
		addCollectionElementType: self codeSuperclassBuilder installedClass.
	self memberOfSlotBuilder addSlotType: self codeSuperclassBuilder installedClass
]

{ #category : #build }
LcsCodeClassesBuilderJob >> installCodesCollectionClass [
	self codeCollectionClassBuilder install.
	self collectionSlotBuilder
		slotClass: self codeCollectionClassBuilder installedClass
]

{ #category : #build }
LcsCodeClassesBuilderJob >> installCodesSlotInModule [
	self collectionSlotBuilder install
]

{ #category : #build }
LcsCodeClassesBuilderJob >> installDomainClassSlot [
	self memberOfSlotBuilder install
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> installGlobalCollection: aString inSlotNamed: aSlotName inModule: aModuleClass [ 
	self codeCollectionClassBuilder rootName: aString.
	self collectionSlotBuilder 
		slotName: aSlotName;
		moduleName: aModuleClass moduleName.
	self memberOfSlotBuilder 
		collectionSlotName: aSlotName;
		moduleName: aModuleClass moduleName
]

{ #category : #build }
LcsCodeClassesBuilderJob >> installSlotIn: aClass [ 
	self memberOfSlotBuilder target: aClass
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> memberOfSlotBuilder [
	^ self jobSteps at: 5
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> memberOfSlotBuilder: anObject [ 
	memberOfSlotBuilder := anObject
]
