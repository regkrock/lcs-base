Class {
	#name : #LuiDateToStringConverterTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #tests }
LuiDateToStringConverterTest >> testConversion [
	| result |
	result := (LuiDateToStringConverter new
		value: Date today).
	self assert: result equals: Date today yyyymmdd
]

{ #category : #tests }
LuiDateToStringConverterTest >> testConversionOfDateTime [
	| result timestamp|
	timestamp := DateAndTime now.
	result := (LuiDateToStringConverter new
		value: timestamp).
	self assert: result equals: timestamp asDate yyyymmdd
]

{ #category : #tests }
LuiDateToStringConverterTest >> testConversionOfNilDate [
	| result |
	result := (LuiDateToStringConverter new
		value: nil).
	self assert: result equals: ''
]

{ #category : #tests }
LuiDateToStringConverterTest >> testConversionOfNoneDate [
	| result |
	result := (LuiDateToStringConverter new
		value: String new).
	self assert: result equals: ''
]
