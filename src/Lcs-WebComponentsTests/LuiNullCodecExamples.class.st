Class {
	#name : 'LuiNullCodecExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LuiNullCodecExamples >> simpleExample [
	<gtExample>
	| codec result |

	codec := LuiNullCodec new.

	result := codec encode: 'on'.
	self assert: result = 'on'.
	
	result :=  codec decode: 'on'.
	self assert: result equals: 'on'.
	
	^ codec
	
]
