Class {
	#name : 'LcsModuleNameMethodBuilderTest',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotToolsTests-Examples',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsModuleNameMethodBuilderTest >> defaultModuleNameBuilderWithNameTestModule [
	<gtExample>
	| builder |
	builder := self moduleNameBuilder
		moduleName: 'Test Module';
		yourself.
	^ builder
]

{ #category : 'examples' }
LcsModuleNameMethodBuilderTest >> defaultModuleNameMethodSourceCode [
	<gtExample>
	| builder |
	builder := self defaultModuleNameBuilderWithNameTestModule.

	self
		assert: builder methodSource
		equals: 'defaultModuleName
	^ ''Test Module'''.
	self assert: builder refactoringText equals: 'LcsGeographyModule class >>defaultModuleName
	^ ''Test Module'''.
	^ builder
]

{ #category : 'examples' }
LcsModuleNameMethodBuilderTest >> moduleNameBuilder [
	<gtExample>
	| builder |
	builder := self newBuilder.
	builder targetClassName: 'LcsGeographyModule'.
	builder beClassMethod.
	self assert: builder targetClassName equals: 'LcsGeographyModule'.
	self assert: builder targetClass equals: LcsGeographyModule.
	self assert: builder isClassMethod.
	^ builder
]

{ #category : 'examples' }
LcsModuleNameMethodBuilderTest >> newBuilder [
	<gtExample>
	| builder |
	builder := LcsModuleNameMethodBuilder new.
	self assert: builder targetClassName isNil.
	self assert: builder targetClass isNil.
	self assert: builder isClassMethod not.
	self assert: builder categoryName equals: #'generated method'.
	^builder
]
