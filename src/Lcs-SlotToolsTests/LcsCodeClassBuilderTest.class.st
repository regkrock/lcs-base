Class {
	#name : #LcsCodeClassBuilderTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #private }
LcsCodeClassBuilderTest >> newClassName [
	^ 'LxxMale1'
]

{ #category : #private }
LcsCodeClassBuilderTest >> targetSuperclassName [
	^ 'LxxGender1'
]

{ #category : #tests }
LcsCodeClassBuilderTest >> testCreationStringForCreatingLxxMaleSubclassOfLxxGender [
	| builder |
	builder := LcsCodeClassBuilder new.
	builder
		newClassName: self newClassName;
		targetPackageName: 'Lcs-Temp';
		targetSuperclassName: self targetSuperclassName;
		rootName: 'Male'.
	self
		assert: builder classCreationString
		equals: 
'LxxGender1 subclass: #LxxMale1
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-Temp'' '
]
