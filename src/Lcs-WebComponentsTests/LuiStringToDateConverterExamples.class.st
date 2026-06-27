Class {
	#name : 'LuiStringToDateConverterExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiStringToDateConverterExamples >> invalidDateStringConvertedToNil [
	<gtExample>
	| result |
	result := (LuiStringToDateConverter new
		convertFromString: 'abc').
	self assert: result equals: nil.
	
	result := (LuiStringToDateConverter new
		convertFromString: nil).
	self assert: result equals: nil.
	^ result
]

{ #category : 'examples' }
LuiStringToDateConverterExamples >> validDateStringConvertedToDate [
	<gtExample>
	| result |
	result := (LuiStringToDateConverter new
		convertFromString: '1955-08-02').
	self assert: result equals: (Date newDay: 2 month: 8 year: 1955).
	^ result
]
