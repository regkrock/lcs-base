Class {
	#name : #LcsDomainClassWithGlobalCollectionBuilderJobTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #test }
LcsDomainClassWithGlobalCollectionBuilderJobTest >> testAddingAJobStep [
	| builderJob |
	builderJob := LcsDomainClassAndDomainCollectionClassBuilderJob new.
	builderJob addJobStep: LcsCodeSuperClassBuilder new.
	self assert: builderJob jobSteps hasJobSteps.
	self assert: builderJob jobSteps collection size equals: 1.
	self assert: builderJob jobSteps collection any parent equals: builderJob jobSteps.
	self assert: builderJob jobSteps collection any builderJob identicalTo: builderJob
]

{ #category : #test }
LcsDomainClassWithGlobalCollectionBuilderJobTest >> testCreation [
	| builderJob |
	builderJob := LcsDomainClassAndDomainCollectionClassBuilderJob new.
	self assert: (builderJob jobSteps isKindOf: LcsCodeBuilderJobSteps).
	self assert: builderJob jobSteps parent identicalTo: builderJob.
	self assert: builderJob jobSteps hasNoJobSteps.
	self assert: builderJob classPrefix equals: 'Lcs'.
	self assert: builderJob targetPackageName isNil.
	self assert: builderJob completedRefactorings isEmpty
]
