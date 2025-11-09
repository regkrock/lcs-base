Class {
	#name : #LcsDomainClassBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #private }
LcsDomainClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : #tests }
LcsDomainClassBuilderTest >> testClassCreationString [
	self subject: LcsDomainClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		targetPackageTagName: 'Core'.
	
	self
		assert: self subject classCreationString
		equals: 
'LcsDomainObject subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : #'as yet unclassified' }
LcsDomainClassBuilderTest >> testInstallClass [
	self should: [ self newClassName asClass ] raise: NotFound.

		self subject: LcsDomainClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		targetPackageTagName: 'Core'.

	self subject buildJobSteps.
	self assert: self subject jobSteps hasNoJobSteps .
	
	self should: [ self newClassName asClass ] raise: NotFound.
	self subject installCode.
	self shouldnt: [ self newClassName asClass ] raise: NotFound.
	self subject verifyCodeInstallation

]
