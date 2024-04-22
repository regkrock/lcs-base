Class {
	#name : #LcsSingletonCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#category : #'Lcs-Tools'
}

{ #category : #iniitialize }
LcsSingletonCodeClassesBuilderJob >> initialize [
	super initialize.
	self codeClassBuilders: OrderedCollection new.
	self codeSuperclassBuilder: (LcsCodeSuperClassBuilder newOn: self).
	self codeCollectionClassBuilder: (LcsCodeCollectionClassBuilder newOn: self).
	self collectionSlotBuilder: (LcsGlobalSlotDefinitionBuilder newOn: self).
	self memberOfSlotBuilder: (LcsMemberOfSlotBuilder newOn: self)
]

{ #category : #build }
LcsSingletonCodeClassesBuilderJob >> install [
	self installCodeSuperclass.
	self codeClassBuilders do: [ :each | each install ].
	self installCodesCollectionClass.
	self installCodesSlotInModule.
	self installDomainClassSlot
]

{ #category : #build }
LcsSingletonCodeClassesBuilderJob >> installCodeSuperclass [
	self codeSuperclassBuilder install.
	self collectionSlotBuilder addCollectionElementType: self codeSuperclassBuilder installedClass.
	self memberOfSlotBuilder addSlotType: self codeSuperclassBuilder installedClass.
]

{ #category : #build }
LcsSingletonCodeClassesBuilderJob >> installCodesCollectionClass [
	self codeCollectionClassBuilder install.
	self collectionSlotBuilder slotClass: 
		self codeCollectionClassBuilder installedClass
]

{ #category : #build }
LcsSingletonCodeClassesBuilderJob >> installCodesSlotInModule [
	self collectionSlotBuilder install
]

{ #category : #build }
LcsSingletonCodeClassesBuilderJob >> installDomainClassSlot [
	self memberOfSlotBuilder install
]

{ #category : #configuration }
LcsSingletonCodeClassesBuilderJob >> installGlobalCollection: aString inSlotNamed: aSlotName inModule: aModuleClass [ 
	self codeCollectionClassBuilder rootName: aString.
	self collectionSlotBuilder 
		slotName: aSlotName;
		moduleName: aModuleClass moduleName.
	self memberOfSlotBuilder 
		collectionSlotName: aSlotName;
		moduleName: aModuleClass moduleName
]
