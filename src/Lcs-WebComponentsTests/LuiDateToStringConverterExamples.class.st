Class {
	#name : 'LuiDateToStringConverterExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiDateToStringConverterExamples >> dateConvertedToString [
	<gtExample>
	| result |
	result := (LuiDateToStringConverter new
		value: Date today).
	self assert: result equals: Date today yyyymmdd.
	^ result
]

{ #category : 'examples' }
LuiDateToStringConverterExamples >> emptyStringToString [
	<gtExample>
	| result |
	result := (LuiDateToStringConverter new
		value: String new).
	self assert: result equals: ''.
	^ result
]

{ #category : 'examples' }
LuiDateToStringConverterExamples >> nilConvertedToString [
	<gtExample>
	| result |
	result := (LuiDateToStringConverter new
		value: nil).
	self assert: result equals: ''.
	^ result
]
