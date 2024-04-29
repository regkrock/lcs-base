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

{ #category : #configuration }
LcsDomainClassClassesBuilderJob >> addCodeClassBuilder: aCodeClassBuilder [
	 aCodeClassBuilder parent: self.
	 aCodeClassBuilder superclassName: self codeSuperclassBuilder installClassName.
	 self codeClassBuilders add: aCodeClassBuilder
]

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
	self memberOfSlotBuilder slotName: aString
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> collectionSlotBuilder [
	^ collectionSlotBuilder
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> collectionSlotBuilder: anObject [
	collectionSlotBuilder := anObject
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> install [
	self installCodeSuperclass.
	self codeClassBuilders do: [ :each | each install ].
	self installCodesCollectionClass.
	self installCodesSlotInModule.
	self installDomainClassSlot
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> installCodeSuperclass [
	self codeSuperclassBuilder install.
	self collectionSlotBuilder
		addCollectionElementType: self codeSuperclassBuilder installedClass.
	self memberOfSlotBuilder addSlotType: self codeSuperclassBuilder installedClass
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> installCodesCollectionClass [
	self codeCollectionClassBuilder install.
	self collectionSlotBuilder
		slotClass: self codeCollectionClassBuilder installedClass
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> installCodesSlotInModule [
	self collectionSlotBuilder install
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> installDomainClassSlot [
	self memberOfSlotBuilder install
]

{ #category : #configuration }
LcsDomainClassClassesBuilderJob >> installGlobalCollection: aString inSlotNamed: aSlotName inModule: aModuleClass [ 
	self codeCollectionClassBuilder rootName: aString.
	self collectionSlotBuilder 
		slotName: aSlotName;
		moduleName: aModuleClass moduleName.
	self memberOfSlotBuilder 
		collectionSlotName: aSlotName;
		moduleName: aModuleClass moduleName
]

{ #category : #build }
LcsDomainClassClassesBuilderJob >> installSlotIn: aClass [ 
	self memberOfSlotBuilder target: aClass
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> memberOfSlotBuilder [
	^ memberOfSlotBuilder
]

{ #category : #accessing }
LcsDomainClassClassesBuilderJob >> memberOfSlotBuilder: anObject [ 
	memberOfSlotBuilder := anObject
]
