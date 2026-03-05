Class {
	#name : 'LcsObjectExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-BaseTests-Examples',
	#package : 'Lcs-BaseTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsObjectExamples >> newLcsObject [
	<gtExample>
	| object |
	object := LcsObject new.
	self deny: LcsObject isDomainClass.
	self deny: object isDomainClass.
	self deny: object isApplicationSystem.
	self assert: (LcsObject new selectorNameFrom: 'IsSelector') equals: #isSelector.
	self assert: (LcsObject new selectorNameFrom: 'Is Selector') equals: #isSelector.
	^ object
]
