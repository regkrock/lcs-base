Class {
	#name : #LcsCodeBuilderJobSteps,
	#superclass : #LcsCodeBuilderStep,
	#instVars : [
		'classPrefix',
		'codePackageName',
		'collection'
	],
	#category : #'Lcs-Tools'
}

{ #category : #accessing }
LcsCodeBuilderJobSteps class >> collectionClass [
	^OrderedCollection
]

{ #category : #'instance creation' }
LcsCodeBuilderJobSteps class >> newOn: anObject [
	^ self new
		initializeOn: anObject;
		yourself 
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> addCompletedRefactoring: aRefactoring [
	self parent addCompletedRefactoring: aRefactoring
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> addJobStep: aJobStep [
	aJobStep parent: self.
	self collection add: aJobStep.
	"StringSignal emit: 'add job step'"
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> allStepsAfter: aJobStep [
	self collection last == aJobStep ifTrue: [ ^ OrderedCollection new ].
	^ self collection
		copyFrom: (self collection indexOf: aJobStep) + 1
		to: self collection size
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> classPrefix: aString [
	self collection do: [ :each | (each respondsTo: #classPrefix:) ifTrue: [each classPrefix: aString]].
]

{ #category : #collection }
LcsCodeBuilderJobSteps >> collect: aCollectBlock [
	^ self collection collect: aCollectBlock
]

{ #category : #collection }
LcsCodeBuilderJobSteps >> collect: aCollectBlock thenSelect: aSelectBlock [
	^ self collection collect: aCollectBlock thenSelect: aSelectBlock
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> collection [
	^ collection
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> collection: aCollection [
	^ collection := aCollection
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> completedRefactorings [
	^ self parent completedRefactorings
]

{ #category : #collection }
LcsCodeBuilderJobSteps >> do: aCollectBlock [
	^ self collection do: aCollectBlock
]

{ #category : #collection }
LcsCodeBuilderJobSteps >> do: aDoBlock separatedBy: aBlock [
	self collection do: aDoBlock separatedBy: aBlock
]

{ #category : #testing }
LcsCodeBuilderJobSteps >> hasJobSteps [
	^ self collection notEmpty
]

{ #category : #testing }
LcsCodeBuilderJobSteps >> hasNoJobSteps [
	^ self collection isEmpty
]

{ #category : #testing }
LcsCodeBuilderJobSteps >> hasSteps [
	^ self collection notEmpty
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> inStepsAfter: aJobStep removeTargetClass: aClass [
	(self allStepsAfter: aJobStep) do: [ :eachStep | eachStep clearTargetClass: aClass ]
]

{ #category : #asking }
LcsCodeBuilderJobSteps >> indexOf: aJobStep [
	^ self collection indexOf: aJobStep
]

{ #category : #initialize }
LcsCodeBuilderJobSteps >> initialize [
	super initialize.
	self collection: OrderedCollection new
]

{ #category : #initialize }
LcsCodeBuilderJobSteps >> initializeOn: anObject [ 
	self parent: anObject
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> installCode [
	self collection do: [ :each | each installCode ]
]

{ #category : #collection }
LcsCodeBuilderJobSteps >> isEmpty [
	^ self collection isEmpty
]

{ #category : #testing }
LcsCodeBuilderJobSteps >> isNotEmpty [
	^ self collection isNotEmpty
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> jobStepAt: anIndex [
	^ self collection at: anIndex
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> jobSteps [
	^ self collection
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> populateSlotModel [
	self collection reverse do: [ :each | each populateSlotModel ]
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> stepsWithClass: aClass [
	^ self collection select: [ :each | each class  == aClass ]
]

{ #category : #'as yet unclassified' }
LcsCodeBuilderJobSteps >> targetClassName [
	^ self parent targetClassName
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> targetPackageName [
	^ codePackageName
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> targetPackageName: aString [
	self collection
		do: [ :each | (each respondsTo: #targetPackageName:) ifTrue: [ each targetPackageName: aString ] ]
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> uninstall [
	self collection reverseDo: [ :each | each uninstall ]
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> updateSlotModel [
	self collection do: [ :each | each updateSlotModel ]
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> verifyCodeInstallation [
	self collection do: [ :each | each verifyCodeInstallation ]
]

{ #category : #accessing }
LcsCodeBuilderJobSteps >> verifySlotModelUpdates [
	self collection do: [ :each | each verifySlotModelUpdates ]
]
