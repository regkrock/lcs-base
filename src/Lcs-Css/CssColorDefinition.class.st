Class {
	#name : #CssColorDefinition,
	#superclass : #CssObject,
	#category : #'Lcs-Css'
}

{ #category : #printing }
CssColorDefinition >> displayString [
	| stream |
	stream := WriteStream on: String new.
	self prettyPrintOn: stream.
	^ stream contents
]

{ #category : #printing }
CssColorDefinition >> prettyCssOn: aStream [ 
	self prettyPrintOn: aStream 
]
