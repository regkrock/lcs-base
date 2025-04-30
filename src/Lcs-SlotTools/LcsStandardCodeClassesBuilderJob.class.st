Class {
	#name : #LcsStandardCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'defaultInstance',
		'prtoCodes'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #command }
LcsStandardCodeClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self addJobStep: self codeCollectionClassBuilder.
	self addJobStep: self globalCollectionReferenceSlotBuilder.
	self addJobStep: self codesGlobalCollectionSlotBuilder.
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

{ #category : #populate }
LcsStandardCodeClassesBuilderJob >> createProtoCodesFromLabels: aCollection [ 
	aCollection do: [ :eachLabel | 
		self protoCodes add: (
			eachLabel isEmpty 
				ifTrue: [ LcsProtoCode unknown]
				ifFalse: [ LcsProtoCode newFromLabel: eachLabel]) ]
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> defaultInstance [
	^defaultInstance
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> defaultInstance: aString [ 
	defaultInstance := aString
]

{ #category : #initialize }
LcsStandardCodeClassesBuilderJob >> initialize [
	super initialize.
	self protoCodes: OrderedCollection new
]

{ #category : #command }
LcsStandardCodeClassesBuilderJob >> populateSlotModel [
	self globalCollectionSlotDefinitionStep populateSlotModel.
	self protoCodes
		do: [ :each | 
			self codeClass new
				code: each code;
				description: each description;
				label: (each label);
				isDefaultInstance: each isDefaultInstance ].
	self currentSystem currentUnitOfWork applyChanges.
	self targetGlobalCollection hasUnknownInstance ifFalse: [
		self codeClass new
				code: 'unknown';
				description: 'Unknown';
				label: '';
				isDefaultInstance: self targetGlobalCollection hasDefaultInstance not].
	self currentSystem currentUnitOfWork applyChanges.

]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> protoCodes [
	^ prtoCodes
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> protoCodes: aCollection [
	prtoCodes := aCollection
]

{ #category : #command }
LcsStandardCodeClassesBuilderJob >> verifyPopulateSlotModel [
	self assert: self targetGlobalCollection parent == self targetModule.
	self assert: self targetGlobalCollection collectionSize = self protoCodes size.
	self protoCodes
		do: [ :each | 
			self assert: (self targetGlobalCollection findWithKey: each code) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
