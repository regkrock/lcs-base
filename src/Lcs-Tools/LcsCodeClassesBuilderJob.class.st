Class {
	#name : #LcsCodeClassesBuilderJob,
	#superclass : #LcsCodeBuilderJob,
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
LcsCodeClassesBuilderJob >> addCodeClassBuilder: aCodeClassBuilder [
	 aCodeClassBuilder parent: self.
	 aCodeClassBuilder superclassName: self codeSuperclassBuilder installClassName.
	 self codeClassBuilders add: aCodeClassBuilder
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeClassBuilders [
	^ codeClassBuilders
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeClassBuilders: anObject [ 
	codeClassBuilders := anObject
]

{ #category : #build }
LcsCodeClassesBuilderJob >> codeCollectionClassBuilder [
	^ codeCollectionClassBuilder
]

{ #category : #iniitialize }
LcsCodeClassesBuilderJob >> codeCollectionClassBuilder: anObject [ 
	codeCollectionClassBuilder := anObject
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeSuperclassBuilder [
	^ codeSuperclassBuilder
]

{ #category : #accessing }
LcsCodeClassesBuilderJob >> codeSuperclassBuilder: anObject [
	codeSuperclassBuilder := anObject
]

{ #category : #build }
LcsCodeClassesBuilderJob >> codeSuperclassRootName [
	^ self codeSuperclassBuilder rootName
]

{ #category : #accessing }
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

{ #category : #accessing }
LcsCodeClassesBuilderJob >> installSlotIn: aClass [ 
	self memberOfSlotBuilder target: aClass
]

{ #category : #build }
LcsCodeClassesBuilderJob >> memberOfSlotBuilder [
	^ memberOfSlotBuilder
]

{ #category : #iniitialize }
LcsCodeClassesBuilderJob >> memberOfSlotBuilder: anObject [ 
	memberOfSlotBuilder := anObject
]
