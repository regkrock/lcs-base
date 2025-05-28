Class {
	#name : #LcsSingletonCodeClassBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #private }
LcsSingletonCodeClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : #private }
LcsSingletonCodeClassBuilderTest >> targetSuperclassName [
	^ 'LcsCode'
]

{ #category : #tests }
LcsSingletonCodeClassBuilderTest >> testClassCreationString [
	| builder |
	builder := LcsSingletonCodeClassBuilder new.
	builder
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		targetSuperclassName: self targetSuperclassName;
		rootName: 'Male'.

	self assert: builder isDefaultInstance not.
	self assert: builder description = 'Male'.
	self assert: builder code = #male.
	self assert: builder label = 'Male'.

	self
		assert: builder classCreationString
		equals: 
'LcsCode subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]

{ #category : #tests }
LcsSingletonCodeClassBuilderTest >> testInstallClass [
	self subject: LcsSingletonCodeClassBuilder new.
	self subject
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		targetSuperclassName: self targetSuperclassName;
		rootName: 'Male'.

	self subject buildJobSteps.
	self assert: self subject jobSteps hasNoJobSteps .
	
	self should: [ self newClassName asClass ] raise: NotFound.
	self subject installCode.
	self shouldnt: [ self newClassName asClass ] raise: NotFound.
	self subject verifyCodeInstallation

]
