Class {
	#name : #LcsStandardValueObjectClassesBuilderJob,
	#superclass : #LcsValueObjectClassesBuilderJob,
	#instVars : [
		'defaultInstance'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #command }
LcsStandardValueObjectClassesBuilderJob >> buildJobSteps [
	self addJobStep: self valueObjectClassBuilder.
	self addJobStep: self valueObjectsCollectionClassBuilder.
	self addJobStep: self valueObjectsLoaderBuilder.
	self addJobStep: self collectionReferenceSlotBuilder.
	self addJobStep: self valueObjectsGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses

]

{ #category : #populate }
LcsStandardValueObjectClassesBuilderJob >> createProtoCodesFromLabels: aCollection [ 
	aCollection do: [ :eachLabel | 
		self protoCodes add: (
			eachLabel isEmpty 
				ifTrue: [ LcsProtoCode unknown ]
				ifFalse: [ LcsProtoCode newFromLabel: eachLabel]) ].
	self protoCodes detect: [ :each | each code = 'unknown' ] ifNone: [ 
		aCollection add: LcsProtoCode unknown ]
]

{ #category : #accessing }
LcsStandardValueObjectClassesBuilderJob >> defaultInstance [
	^defaultInstance
]

{ #category : #accessing }
LcsStandardValueObjectClassesBuilderJob >> defaultInstance: aString [ 
	defaultInstance := aString
]

{ #category : #'as yet unclassified' }
LcsStandardValueObjectClassesBuilderJob >> globalCollectionSlotDefinitionStep [
	^ (self jobSteps stepsWithClass: LcsValueObjectsGlobalCollectionSlotBuilder) first
]

{ #category : #initialize }
LcsStandardValueObjectClassesBuilderJob >> initialize [
	super initialize.
	self protoCodes: OrderedCollection new
]

{ #category : #command }
LcsStandardValueObjectClassesBuilderJob >> verifyPopulateSlotModel [
	super verifyPopulateSlotModel.
	self assert: self targetGlobalCollection parent == self targetModule.
	self assert: self targetGlobalCollection collectionSize = self protoCodes size.
	self protoCodes
		do: [ :each | 
			self assert: (self targetGlobalCollection findWithKey: each code) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
