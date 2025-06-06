Class {
	#name : #LcsSingletonUnknownValueObjectClassBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #tests }
LcsSingletonUnknownValueObjectClassBuilderTest >> newClassName [
	^ 'XxxUnknownCode'
]

{ #category : #tests }
LcsSingletonUnknownValueObjectClassBuilderTest >> targetPackageName [
	^ 'Lcs-Temp'
]

{ #category : #tests }
LcsSingletonUnknownValueObjectClassBuilderTest >> targetSuperclassName [
	^ 'LcsSingletonValueObject'
]

{ #category : #tests }
LcsSingletonUnknownValueObjectClassBuilderTest >> testCreation [
	self subject: LcsSingletonUnknownValueObjectClassBuilder new.
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
		equals: 'LcsSingletonValueObject subclass: #XxxUnknownCode
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : #tests }
LcsSingletonUnknownValueObjectClassBuilderTest >> testInstallClass [
	self subject: LcsSingletonUnknownValueObjectClassBuilder new.
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
