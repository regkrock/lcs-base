Class {
	#name : #LcsCodeClassBuilderTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #test }
LcsCodeClassBuilderTest >> testCreationStringForCreatingLxxMaleSubclassOfLxxGender [
	| builder |
	builder := LcsCodeClassBuilder  new.
	builder 
		classPrefix: 'Lxx';
		codePackageName: 'Lcs-BarebonesSystem';
		superclassName: 'LxxGender';
		rootName: 'Male'.
	self assert: builder codeClassDefintion equals: 'LxxGender subclass: #LxxMale
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-BarebonesSystem'' '
]
