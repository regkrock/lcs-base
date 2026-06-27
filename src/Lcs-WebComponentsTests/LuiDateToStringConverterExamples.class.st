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
		convertToString: Date today).
	self assert: result equals: Date today yyyymmdd.
	^ result
]

{ #category : 'examples' }
LuiDateToStringConverterExamples >> emptyStringToString [
	<gtExample>
	| result |
	result := (LuiDateToStringConverter new
		convertToString: String new).
	self assert: result equals: ''.
	^ result
]

{ #category : 'examples' }
LuiDateToStringConverterExamples >> nilConvertedToString [
	<gtExample>
	| result |
	result := (LuiDateToStringConverter new
		convertToString: nil).
	self assert: result equals: ''.
	^ result
]
