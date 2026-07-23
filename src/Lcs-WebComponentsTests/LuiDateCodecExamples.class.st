Class {
	#name : 'LuiDateCodecExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiDateCodecExamples >> dateConvertedToString [
	<gtExample>
	| result |
	result := (LuiDateCodec new encode: Date today).
	self assert: result equals: Date today yyyymmdd.
	^ result
]

{ #category : 'examples' }
LuiDateCodecExamples >> emptyStringToString [
	<gtExample>
	| result |
	result := (LuiDateCodec new encode: String new).
	self assert: result equals: ''.
	^ result
]

{ #category : 'examples' }
LuiDateCodecExamples >> invalidDateStringConvertedToNil [
	<gtExample>
	| result |
	result := (LuiDateCodec new decode: 'abc').
	self assert: result equals: nil.
	
	result := (LuiDateCodec new decode: nil).
	self assert: result equals: nil.
	^ result
]

{ #category : 'examples' }
LuiDateCodecExamples >> nilConvertedToString [
	<gtExample>
	| result |
	result := (LuiDateCodec new encode: nil).
	self assert: result equals: ''.
	^ result
]

{ #category : 'examples' }
LuiDateCodecExamples >> validDateStringConvertedToDate [
	<gtExample>
	| result |
	result := (LuiDateCodec new decode: '1955-08-02').
	self assert: result equals: (Date newDay: 2 month: 8 year: 1955).
	^ result
]
