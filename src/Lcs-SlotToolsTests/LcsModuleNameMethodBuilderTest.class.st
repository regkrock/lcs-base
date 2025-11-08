Class {
	#name : #LcsModuleNameMethodBuilderTest,
	#superclass : #LcsCodeBuilderStepTest,
	#category : #'Lcs-SlotToolsTests-Tests'
}

{ #category : #examples }
LcsModuleNameMethodBuilderTest >> moduleNameBuilder [
	<gtExample>
	
	self subject: LcsModuleNameMethodBuilder new.
	self subject targetClassName: 'LcsGeographyModule'.
	self assert: self subject targetClassName equals: 'LcsGeographyModule'.
	self assert: self subject targetClass equals: LcsGeographyModule.
	self assert: self subject isClassMethod not.
	self assert: self subject categoryName equals: #'generated method'.
	
	^ self subject
]

{ #category : #testing }
LcsModuleNameMethodBuilderTest >> testMethodSource [
	
	self subject: self moduleNameBuilder.

	self subject beClassMethod.
	self assert: self subject isClassMethod.
	
	self subject moduleName: 'Test Module'.
	self assert: self subject moduleName equals: 'Test Module'.
	
	self assert: self subject methodSource equals: 'defaultModuleName
	^ ''Test Module'''
]

{ #category : #examples }
LcsModuleNameMethodBuilderTest >> testRefactoringDetails [
	| stream |
	stream := WriteStream on: String new.
	self subject: self moduleNameBuilder.
	self subject moduleName: 'Test Module'.
	
	self subject addRefactoringTextDetailsTo: stream.
	
	self assert: stream contents equals: 'LcsGeographyModule >> defaultModuleName
	^ ''Test Module'''
]

{ #category : #examples }
LcsModuleNameMethodBuilderTest >> testRefactoringDetailsWithClassMethod [
	| stream |
	stream := WriteStream on: String new.
	self subject: self moduleNameBuilder.
	self subject moduleName: 'Test Module'.
	self subject beClassMethod.
	
	self subject addRefactoringTextDetailsTo: stream.
	
	self assert: stream contents equals: 'LcsGeographyModule class >>defaultModuleName
	^ ''Test Module'''
]
