Class {
	#name : 'LuiDateAndTimeCodecExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiDateAndTimeCodecExamples >> dateAndTimeAsString [
	<gtExample>
	| result timestamp|
	timestamp := DateAndTime now.
	result := (LuiDateAndTimeCodec new encode: timestamp).
	self assert: result equals: timestamp printString.
	^ result
]

{ #category : 'examples' }
LuiDateAndTimeCodecExamples >> dateAndTimeStringToDateAndTime [
	<gtExample>
	| result timestampString|
	timestampString := DateAndTime now printString.
	result := (LuiDateAndTimeCodec new decode: timestampString).
	self assert: result printString equals: timestampString.
	result
]

{ #category : 'examples' }
LuiDateAndTimeCodecExamples >> emptyStringToDateAndTime [
	<gtExample>
	| result timestampString|
	timestampString := ''.
	result := (LuiDateAndTimeCodec new decode: timestampString).
	self assert: result equals: nil.
	result
]

{ #category : 'examples' }
LuiDateAndTimeCodecExamples >> emptyStringToString [
	<gtExample>
	| result |
	result := (LuiDateAndTimeCodec new encode: String new).
	self assert: result equals: ''.
	^ result
]

{ #category : 'examples' }
LuiDateAndTimeCodecExamples >> nilConvertedToString [
	<gtExample>
	| result |
	result := (LuiDateAndTimeCodec new encode: nil).
	self assert: result equals: ''.
	^ result
]

{ #category : 'examples' }
LuiDateAndTimeCodecExamples >> nilToDateAndTime [
	<gtExample>
	| result timestampString|
	timestampString := nil.
	result := (LuiDateAndTimeCodec new decode: timestampString).
	self assert: result equals: nil.
	result
]

{ #category : 'examples' }
LuiDateAndTimeCodecExamples >> numberToDateAndTime [
	<gtExample>
	| result timestampString|
	timestampString := 12.
	result := (LuiDateAndTimeCodec new decode: timestampString).
	self assert: result equals: nil.
	result
]
