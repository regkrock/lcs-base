Class {
	#name : 'LuiTableExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiTableExamples >> configuredPersonsTable [
	<gtExample>
	<after: #clearUnitOfWork>
	| component |
	component := self newComponent.
	component buildTable.
	^component
]

{ #category : 'examples' }
LuiTableExamples >> newComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| component domainCollection |
	domainCollection := LxxPersonsExamples new freemanClan.
	component := LuiTable onSlotNamed: 'persons' model: self currentSystem.
	self assert: component class equals: LuiTable.
	self assert: component componentName equals: 'personsTable'.
	self assert: component valueAccessor read == self currentSystem persons.
	self assert: component valueAccessor model == self currentSystem.
	self assert: component parentComponent isNil.
	self wrapComponent: component.
	^ component
]
