Class {
	#name : 'LuiDateAndTimeToStringConverterExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiDateAndTimeToStringConverterExamples >> dateAndTimeAsString [
	<gtExample>
	| result timestamp|
	timestamp := DateAndTime now.
	result := (LuiDateAndTimeToStringConverter new
		convertToString: timestamp).
	self assert: result equals: timestamp printString.
	result
]

{ #category : 'examples' }
LuiDateAndTimeToStringConverterExamples >> emptyStringToString [
	<gtExample>
	| result |
	result := (LuiDateAndTimeToStringConverter new
		convertToString: String new).
	self assert: result equals: ''.
	^ result
]

{ #category : 'examples' }
LuiDateAndTimeToStringConverterExamples >> nilConvertedToString [
	<gtExample>
	| result |
	result := (LuiDateAndTimeToStringConverter new
		convertToString: nil).
	self assert: result equals: ''.
	^ result
]
