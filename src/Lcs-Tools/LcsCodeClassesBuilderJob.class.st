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
LcsCodeClassesBuilderJob >> addCodeCollectionClassBuilderStep [
	self addJobStep: LcsCodeCollectionClassBuilder new
]

{ #category : #initialize }
LcsCodeClassesBuilderJob >> addCodeSubclassesBuilderJobSteps [
	self addJobStep: LcsCodeBuilderJobSteps new
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

{ #category : #configuration }
LcsCodeClassesBuilderJob >> codeCollectionClassBuilder [
	self subclassResponsibility
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> codeRootName: aString [
	| codeSlotName codesSlotName codeSlotClassName|

	codeSlotName := self codeSlotNameFrom: aString.
	codesSlotName := codeSlotName asEnglishPlural.
	codeSlotClassName := self classPrefix , aString.
	
	self codeSuperclassBuilder rootName: aString.
	self codeCollectionClassBuilder rootName: aString asEnglishPlural.
	self globalCollectionSlotBuilder 
		slotClassName: codeSlotClassName;
		slotName: codesSlotName.
	self memberOfSlotInDomainClassBuilder
		collectionSlotName: codesSlotName;
		slotName: codeSlotName
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> codeSlotNameFrom: aString [
	^ (aString at: 1) asLowercase asString , (aString copyFrom: 2 to: aString size)
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> codeSuperclassBuilder [
	self subclassResponsibility
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> codeSuperclassRootName: aString [ 
	self codeSuperclassBuilder rootName: aString.
	self memberOfSlotInDomainClassBuilder slotName: ((aString at: 1) asLowercase) asString , (aString copyFrom: 2 to: aString size)
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> globalCollectionSlotBuilder [
	self subclassResponsibility
]

{ #category : #build }
LcsCodeClassesBuilderJob >> install [
	self jobSteps do: [:each | 
		Transcript cr; show: each printString.
		each install ]
]

{ #category : #build }
LcsCodeClassesBuilderJob >> installCodeSuperclass [
	self codeSuperclassBuilder install.
	self memberOfSlotInDomainClassBuilder
		addCollectionElementType: self codeSuperclassBuilder installedClass.
	self memberOfSlotInDomainClassBuilder addSlotType: self codeSuperclassBuilder installedClass
]

{ #category : #build }
LcsCodeClassesBuilderJob >> installCodesCollectionClass [
	self codeCollectionClassBuilder install.
	self memberOfSlotInDomainClassBuilder
		slotClass: self codeCollectionClassBuilder installedClass
]

{ #category : #build }
LcsCodeClassesBuilderJob >> installCodesSlotInModule [
	self memberOfSlotInDomainClassBuilder install
]

{ #category : #build }
LcsCodeClassesBuilderJob >> installDomainClassSlot [
	self memberOfSlotInDomainClassBuilder install
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> installGlobalCollection: aString inSlotNamed: aSlotName inModule: aModuleClass [ 
	self codeCollectionClassBuilder targetClassName: (self classPrefix , aString).
	self memberOfSlotInDomainClassBuilder 
		slotName: aSlotName;
		moduleName: aModuleClass moduleName.
	self memberOfSlotInDomainClassBuilder 
		collectionSlotName: aSlotName;
		moduleName: aModuleClass moduleName
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> installGlobalCollectionSlotInModule: aModuleClass [
	| name |
	name := aModuleClass moduleName.
	self memberOfSlotInDomainClassBuilder moduleName: name.
	self globalCollectionSlotBuilder moduleName: name.
	self memberOfSlotInDomainClassBuilder moduleName: name.
]

{ #category : #build }
LcsCodeClassesBuilderJob >> installSlotInDomainClass: aClass [ 
	self memberOfSlotInDomainClassBuilder target: aClass
]

{ #category : #configuration }
LcsCodeClassesBuilderJob >> memberOfSlotInDomainClassBuilder [
	self subclassResponsibility
]
