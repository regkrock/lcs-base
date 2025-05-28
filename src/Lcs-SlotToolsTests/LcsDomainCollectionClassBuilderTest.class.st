Class {
	#name : #LcsDomainCollectionClassBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #private }
LcsDomainCollectionClassBuilderTest >> newClassName [
	^ 'LxxMales'
]

{ #category : #tests }
LcsDomainCollectionClassBuilderTest >> testClassCreationString [
	self subject: LcsDomainCollectionClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp'.
	
	self
		assert: self subject classCreationString
		equals: 
'LcsDomainCollection subclass: #LxxMales
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : #'as yet unclassified' }
LcsDomainCollectionClassBuilderTest >> testInstallClass [
	self subject: LcsDomainCollectionClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp'.

	self subject buildJobSteps.
	self assert: self subject jobSteps hasNoJobSteps .
	
	self should: [ self newClassName asClass ] raise: NotFound.
	self subject installCode.
	self shouldnt: [ self newClassName asClass ] raise: NotFound.
	self subject verifyCodeInstallation

]
