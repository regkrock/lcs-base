Class {
	#name : #LcsStandardCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeInstances'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #command }
LcsStandardCodeClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self addJobStep: self codeCollectionClassBuilder.
	self addJobStep: self globalCollectionReferenceSlotBuilder.
	self addJobStep: self codeGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> codeClass [
	^ self codeClassBuilderStep installedClass
]

{ #category : #'builder step' }
LcsStandardCodeClassesBuilderJob >> codeClassBuilderStep [
	^ (self jobSteps stepsWithClass: LcsCodeSuperClassBuilder) first
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> codeInstances [
	^ codeInstances
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> codeInstances: aCollection [
	codeInstances := aCollection
]

{ #category : #private }
LcsStandardCodeClassesBuilderJob >> codeNameFrom: anArray [ 
	| protoCode |
	protoCode := anArray at: 1.
	protoCode size = 1 ifTrue: [ ^protoCode ].
	^ protoCode asCamelCase asValidSelector asString
]

{ #category : #populate }
LcsStandardCodeClassesBuilderJob >> createCodeInstances: aCollection [ 
	self codeInstances addAll: aCollection
]

{ #category : #initialize }
LcsStandardCodeClassesBuilderJob >> initialize [
	super initialize.
	self codeInstances: OrderedCollection new
]

{ #category : #testing }
LcsStandardCodeClassesBuilderJob >> isDefaultInstanceFrom: anArray [
	anArray size < 4 ifTrue: [ ^ false ].
	^ anArray at: 4
]

{ #category : #command }
LcsStandardCodeClassesBuilderJob >> populateSlotModel [
	self globalCollectionSlotDefinitionStep populateSlotModel.
	self codeInstances
		do: [ :each | 
			self codeClass new
				codeName: (self codeNameFrom: each);
				codeDescription: (self codeDescriptionFrom: each);
				shortName: (self shortNameFrom: each);
				isDefaultInstance: (self isDefaultInstanceFrom: each) ].
	self currentSystem currentUnitOfWork applyChanges.
	self targetGlobalCollection hasUnknownInstance ifFalse: [
		self codeClass new
				codeName: 'unknown';
				codeDescription: '';
				shortName: '';
				isDefaultInstance: self targetGlobalCollection hasDefaultInstance not].
	self currentSystem currentUnitOfWork applyChanges.

]

{ #category : #command }
LcsStandardCodeClassesBuilderJob >> verifyPopulateSlotModel [
	self assert: self targetGlobalCollection parent == self targetModule.
	self assert: self targetGlobalCollection size = (self codeInstances size + 1).
	self codeInstances
		do: [ :each | 
			self assert: (self targetGlobalCollection findWithKey: (self codeNameFrom: each)) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
