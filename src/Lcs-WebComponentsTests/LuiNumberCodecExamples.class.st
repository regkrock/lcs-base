Class {
	#name : 'LuiNumberCodecExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LuiNumberCodecExamples >> floatToString [
	<gtExample>
	| codec result |

	codec := LuiNumberCodec new.

	result := codec encode: 3.14169.
	self assert: result = '3.14169'.
	
	result :=  codec decode: '3.14169'.
	self assert: result equals: 3.14169.
	
	^ codec
	
]

{ #category : 'as yet unclassified' }
LuiNumberCodecExamples >> integerToString [
	<gtExample>
	| codec result |

	codec := LuiNumberCodec new.

	result := codec encode: 123.
	self assert: result = '123'.
	
	result :=  codec decode: '123'.
	self assert: result equals: 123.
	
	^ codec
	
]
