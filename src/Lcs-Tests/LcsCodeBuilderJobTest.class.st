Class {
	#name : #LcsCodeBuilderJobTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-Tests-Tests'
}

{ #category : #test }
LcsCodeBuilderJobTest >> testAddingAJobStep [
	| builderJob |
	builderJob := LcsCodeBuilderJob new.
	builderJob addJobStep: LcsCodeSuperClassBuilder new.
	self assert: builderJob jobSteps hasJobSteps.
	self assert: builderJob jobSteps collection size equals: 1.
	self assert: builderJob jobSteps collection any parent equals: builderJob jobSteps.
	self assert: builderJob jobSteps collection any builderJob identicalTo: builderJob
]

{ #category : #test }
LcsCodeBuilderJobTest >> testCreation [
	| builderJob |
	builderJob := LcsCodeBuilderJob new.
	self assert: (builderJob jobSteps isKindOf: LcsCodeBuilderJobSteps).
	self assert: builderJob jobSteps parent identicalTo: builderJob.
	self assert: builderJob jobSteps hasNoJobSteps.
	self assert: builderJob classPrefix equals: 'Lcs'.
	self assert: builderJob targetPackageName isNil.
	self assert: builderJob completedRefactorings isEmpty
]
