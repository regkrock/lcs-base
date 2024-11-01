Class {
	#name : #LuiStringToDateConverterTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #tests }
LuiStringToDateConverterTest >> testConversion [
	| result |
	result := (LuiStringToDateConverter new
		value: '1955-08-02').
	self assert: result equals: (Date newDay: 2 month: 8 year: 1955).
]

{ #category : #tests }
LuiStringToDateConverterTest >> testConversionOfNoneDate [
	| result |
	result := (LuiStringToDateConverter new
		value: 'abc').
	self assert: result equals: nil.
	
	result := (LuiStringToDateConverter new
		value: nil).
	self assert: result equals: nil.
]
