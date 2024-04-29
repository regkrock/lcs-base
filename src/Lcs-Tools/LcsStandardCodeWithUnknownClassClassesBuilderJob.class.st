Class {
	#name : #LcsStandardCodeWithUnknownClassClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeInstances'
	],
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeInstances [
	^ codeInstances
]

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeInstances: aCollection [
	codeInstances := aCollection
]

{ #category : #configuration }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> codeSuperclassRootName: aString [ 
	self codeSuperclassBuilder rootName: 'Base' , aString.
	self memberOfSlotBuilder slotName: ((aString first asLowercase asString) , (aString copyFrom: 2 to: aString size)).
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

{ #category : #accessing }
LcsStandardCodeWithUnknownClassClassesBuilderJob >> initialize [
	super initialize.
	self codeInstances: OrderedCollection new
]
