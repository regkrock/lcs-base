Class {
	#name : 'LuiObjectToDateAndTimeExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiObjectToDateAndTimeExamples >> dateAndTimeStringToDateAndTime [
	<gtExample>
	| result timestampString|
	timestampString := DateAndTime now printString.
	result := (LuiStringToDateAndTimeConverter new
		convertFromString: timestampString).
	self assert: result printString equals: timestampString.
	result
]

{ #category : 'examples' }
LuiObjectToDateAndTimeExamples >> emptyStringToDateAndTime [
	<gtExample>
	| result timestampString|
	timestampString := ''.
	result := (LuiStringToDateAndTimeConverter new
		convertFromString: timestampString).
	self assert: result equals: nil.
	result
]

{ #category : 'examples' }
LuiObjectToDateAndTimeExamples >> nilToDateAndTime [
	<gtExample>
	| result timestampString|
	timestampString := nil.
	result := (LuiStringToDateAndTimeConverter new
		convertFromString: timestampString).
	self assert: result equals: nil.
	result
]

{ #category : 'examples' }
LuiObjectToDateAndTimeExamples >> numberToDateAndTime [
	<gtExample>
	| result timestampString|
	timestampString := 12.
	result := (LuiStringToDateAndTimeConverter new
		convertFromString: timestampString).
	self assert: result equals: nil.
	result
]
