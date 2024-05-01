Class {
	#name : #LcsDomainClassClassesBuilderJob,
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

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> codeClassBuilders [
	^ codeClassBuilders
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> codeClassBuilders: anObject [ 
	codeClassBuilders := anObject
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> codeCollectionClassBuilder [
	^ codeCollectionClassBuilder
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> codeCollectionClassBuilder: anObject [ 
	codeCollectionClassBuilder := anObject
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> codeSuperclassBuilder [
	^ codeSuperclassBuilder
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> codeSuperclassBuilder: anObject [
	codeSuperclassBuilder := anObject
]

{ #category : #configuration }
LcsDomainClassClassesBuilderJob >> codeSuperclassRootName: aString [ 
	self codeSuperclassBuilder rootName: aString.
	self memberOfSlotInDomainClassBuilder slotName: aString
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> collectionSlotBuilder: anObject [
	collectionSlotBuilder := anObject
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> install [
	self installCodeSuperclass.
	"self codeClassBuilders do: [ :each | each install ]."
	self installCodesCollectionClass.
	self installCodesSlotInModule.
	self installDomainClassSlot
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> installCodeSuperclass [
	self codeSuperclassBuilder install.
	self memberOfSlotInDomainClassBuilder
		addCollectionElementType: self codeSuperclassBuilder installedClass.
	self memberOfSlotInDomainClassBuilder addSlotType: self codeSuperclassBuilder installedClass
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> installCodesCollectionClass [
	self codeCollectionClassBuilder install.
	self memberOfSlotInDomainClassBuilder
		slotClass: self codeCollectionClassBuilder installedClass
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> installCodesSlotInModule [
	self memberOfSlotInDomainClassBuilder install
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> installDomainClassSlot [
	self memberOfSlotInDomainClassBuilder install
]

{ #category : #configuration }
LcsDomainClassClassesBuilderJob >> installGlobalCollection: aString inSlotNamed: aSlotName inModule: aModuleClass [ 
	self codeCollectionClassBuilder rootName: aString.
	self memberOfSlotInDomainClassBuilder 
		slotName: aSlotName;
		moduleName: aModuleClass moduleName.
	self memberOfSlotInDomainClassBuilder 
		collectionSlotName: aSlotName;
		moduleName: aModuleClass moduleName
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> installSlotInDomainClass: aClass [ 
	self memberOfSlotInDomainClassBuilder target: aClass
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> memberOfSlotBuilder [
	^ memberOfSlotBuilder
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> memberOfSlotBuilder: anObject [ 
	memberOfSlotBuilder := anObject
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> memberOfSlotInDomainClassBuilder [
	^ collectionSlotBuilder
]
