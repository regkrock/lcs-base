Class {
	#name : #LcsCodeCollectionClassBuilderTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-Tests'
}

{ #category : #test }
LcsCodeCollectionClassBuilderTest >> testCreationStringForCreatingLxxGendersSubclassOfLcsCodes [
	| builder |
	builder := LcsCodeCollectionClassBuilder  new.
	builder 
		classPrefix: 'Lxx';
		codePackageName: 'Lcs-BarebonesSystem';
		rootName: 'Genders'.
	self assert: builder codeClassDefintion equals: 'LcsCodes subclass: #LxxGenders
		instanceVariableNames: ''''
		classVariableNames: ''''
		poolDictionaries: ''''
		package: ''Lcs-BarebonesSystem'' '
]