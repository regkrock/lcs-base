Class {
	#name : 'LcsTableColumnDefinitionExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SystemManagementTests-Examples',
	#package : 'Lcs-SystemManagementTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsTableColumnDefinitionExamples >> newColumnDefinition [
	<gtExample>
	<after: #clearUnitOfWork>
	| columnDefinition |
	self ensureCurrentSystemIsPrototypeSystem.
	columnDefinition := LcsTableColumnDefinition new.
	self assert: columnDefinition class equals: LcsTableColumnDefinition.
	self assert: columnDefinition slotName isEmpty.
	self assert: columnDefinition label isEmpty.
	self assert: columnDefinition justification code equals: 'left'.
	columnDefinition beRightJustified.
	self assert: columnDefinition justification code equals: 'right'.
	columnDefinition beCentered.
	self assert: columnDefinition justification code equals: 'center'.
	columnDefinition beLeftJustified.
	self assert: columnDefinition justification code equals: 'left'.
	^ columnDefinition
]

{ #category : 'examples' }
LcsTableColumnDefinitionExamples >> newColumnFromStringSlotDefinition [
	<gtExample>
	<after: #clearUnitOfWork>
	| columnDefinition |
	self ensureCurrentSystemIsPrototypeSystem.
	columnDefinition := LcsTableColumnDefinition newOn: LxxCountry isoCode3SlotDefinition.
	self assert: columnDefinition label = 'Iso Code3'.
	self assert: columnDefinition slotName equals: 'isoCode3'.
	self assert: columnDefinition isLeftJustified.
]
