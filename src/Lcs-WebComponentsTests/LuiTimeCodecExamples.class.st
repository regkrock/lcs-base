Class {
	#name : 'LuiTimeCodecExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiTimeCodecExamples >> dateAndTimeStringToDateAndTime [
	<gtExample>
	| result timestamp |
	timestamp := Time now.
	result := (LuiTimeCodec new encode: timestamp).
	self assert: result equals: timestamp asString.
	result
]

{ #category : 'examples' }
LuiTimeCodecExamples >> emptyStringToDateAndTime [
	<gtExample>
	| result timestampString|
	timestampString := ''.
	result := (LuiTimeCodec new encode: timestampString).
	self assert: result equals: ''.
	result
]

{ #category : 'examples' }
LuiTimeCodecExamples >> emptyStringToString [
	<gtExample>
	| result |
	result := (LuiTimeCodec new encode: String new).
	self assert: result equals: ''.
	^ result
]

{ #category : 'examples' }
LuiTimeCodecExamples >> nilConvertedToString [
	<gtExample>
	| result |
	result := (LuiTimeCodec new decode: nil).
	self assert: result equals: ''.
	^ result
]

{ #category : 'examples' }
LuiTimeCodecExamples >> nilToTime [
	<gtExample>
	| result timestampString|
	timestampString := nil.
	result := (LuiTimeCodec new decode: timestampString).
	self assert: result equals: ''.
	result
]

{ #category : 'examples' }
LuiTimeCodecExamples >> numberToDateAndTime [
	<gtExample>
	| result timestampString|
	timestampString := 12.
	result := (LuiTimeCodec new decode: timestampString).
	self assert: result equals: ''.
	result
]

{ #category : 'examples' }
LuiTimeCodecExamples >> timeAsString [
	<gtExample>
	| result timestamp|
	timestamp := Time now.
	result := (LuiTimeCodec new encode: timestamp).
	self assert: result equals: timestamp printString.
	^ result
]
