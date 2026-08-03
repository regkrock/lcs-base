Class {
	#name : 'LuiScaledDecimalCodecExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LuiScaledDecimalCodecExamples >> scaledDecimalToAndFromString [
	<gtExample>
	| codec result |

	codec := LuiScaledDecimalCodec new.
	codec numberOfDecimals: 2.

	result := codec encode: 123s0.
	self assert: result = '123'.
	
	result :=  codec decode: '123'.
	self assert: result asString equals: '123.00s2'.

	result := codec encode: 123.24s2.
	self assert: result = '123.24'.
	
	result :=  codec decode: '123.24s2'.
	self assert: result asString equals: '123.24s2'.
	
	^ codec
	
]
