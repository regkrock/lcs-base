Class {
	#name : #LcsSingletonUnknownCodeClassBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsSingletonUnknownCodeClassBuilderTest >> newClassName [
	^ 'XxxUnknownCode'
]

{ #category : #tests }
LcsSingletonUnknownCodeClassBuilderTest >> targetPackageName [
	^ 'Lcs-Temp'
]

{ #category : #tests }
LcsSingletonUnknownCodeClassBuilderTest >> targetSuperclassName [
	^ 'LcsSingletonCode'
]

{ #category : #tests }
LcsSingletonUnknownCodeClassBuilderTest >> testCreation [
	self subject: LcsSingletonUnknownCodeClassBuilder new.
	self subject newClassName: self newClassName.
	self subject targetSuperclassName: self targetSuperclassName.
	self subject targetPackageName: self targetPackageName.

	self assert: self subject defaultInstance = true.
	self assert: self subject description = ''.
	self assert: self subject label = ''.
	self assert: self subject code = 'unknown'.
	self assert: self subject newClassName = self newClassName.
	self
		assert: self subject classCreationString
		equals: 'LcsSingletonCode subclass: #XxxUnknownCode
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : #tests }
LcsSingletonUnknownCodeClassBuilderTest >> testInstallClass [
	self subject: LcsSingletonUnknownCodeClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: self targetPackageName;
		targetSuperclassName: self targetSuperclassName.

	self subject buildJobSteps.
	self assert: self subject jobSteps hasNoJobSteps.

	self should: [ self newClassName asClass ] raise: NotFound.
	self subject installCode.
	self shouldnt: [ self newClassName asClass ] raise: NotFound.
	self subject verifyCodeInstallation
]
