Class {
	#name : #LcsStandardCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'defaultInstance'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #command }
LcsStandardCodeClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self addJobStep: self codesCollectionClassBuilder.
	self addJobStep: self collectionReferenceSlotBuilder.
	self addJobStep: self codesGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses.
	self addJobStep: self codesLoaderBuilder
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
				ifTrue: [ LcsProtoCode unknown ]
				ifFalse: [ LcsProtoCode newFromLabel: eachLabel]) ].
	self protoCodes detect: [ :each | each code = 'unknown' ] ifNone: [ 
		aCollection add: LcsProtoCode unknown ]
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> defaultInstance [
	^defaultInstance
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> defaultInstance: aString [ 
	defaultInstance := aString
]

{ #category : #'as yet unclassified' }
LcsStandardCodeClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsCodesGlobalSlotDefinitionBuilder) first
]

{ #category : #initialize }
LcsStandardCodeClassesBuilderJob >> initialize [
	super initialize.
	self protoCodes: OrderedCollection new
]

{ #category : #command }
LcsStandardCodeClassesBuilderJob >> verifyPopulateSlotModel [
	super verifyPopulateSlotModel.
	self assert: self targetGlobalCollection parent == self targetModule.
	self assert: self targetGlobalCollection collectionSize = self protoCodes size.
	self protoCodes
		do: [ :each | 
			self assert: (self targetGlobalCollection findWithKey: each code) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
