Class {
	#name : 'LcsUnitsOfWorkExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsUnitsOfWorkExamples >> newCollection [
	<gtExample>
	| units |
	units := LcsUnitsOfWork new. 
	self assert: units collection isEmpty.
	^ units
]

{ #category : 'examples' }
LcsUnitsOfWorkExamples >> systemHasNoUnitOfWorkError [
	<gtExample>
	<noTest>
	| units |
	units := self newCollection. 
	self should: [ units unitOfWorkFor: 'dddd' ] raise: LcsSystemHasNoUnitOfWorkError.
	^ units unitOfWorkFor: 'dddd'
]
