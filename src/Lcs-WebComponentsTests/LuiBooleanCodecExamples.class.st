Class {
	#name : 'LuiBooleanCodecExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LuiBooleanCodecExamples >> onOffExample [
	<gtExample>
	| codec result |

	codec := LuiBooleanCodec new.

	result := codec decode: 'on'.
	self assert: result == true.
	
	result :=  codec encode: true.
	self assert: result equals: 'on'.

	result := codec decode: 'off'.
	self assert: result == false.
	
	result :=  codec encode: false.
	self assert: result equals: 'off'.

	
	^ codec
	
]
