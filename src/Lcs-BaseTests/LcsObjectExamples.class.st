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

{ #category : 'examples' }
LcsObjectExamples >> verifyAssertionMethods [
	<gtExample>
	self assertClass: Collection hasLocalSelector: #add:.
	self assertClass: Collection hasLocalClassSelector: #withAll:.
	self assertClass: Collection hasSelector: #assert:.
	self assertClass: Collection hasClassSelector: #assert:.
	self denyClass: Collection hasLocalSelector: #assert:.
	self denyClass: Collection hasLocalClassSelector: #assert:.
	self denyClass: Collection hasClassSelector: #xxxxx.
	self denyClass: Collection hasSelector: #xxxx.
	^ self
]
