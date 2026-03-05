Class {
	#name : 'LcsDateRangeExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LcsDateRangeExamples >> newDateRange [
	<gtExample>
	| dateRange |
	self ensureCurrentSystemIsDemoSystem.
	dateRange :=  LcsDateRange new.
	self assert: dateRange isInEffect.
	self assert: dateRange effectiveDate equals: (Date newDay: 1 month: 1 year: 1970).
	self assert: dateRange expiryDate equals: (Date newDay: 31 month: 12 year: 2100).
	^ dateRange
]
