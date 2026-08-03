Class {
	#name : 'LuiCodec',
	#superclass : 'LcsObject',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'testing' }
LuiCodec >> canCreate: anObject [

	^self subclassResponsibility
]

{ #category : 'converting' }
LuiCodec >> decode: aString [
	"Converts a aString to an anObject"
	^ self subclassResponsibility
]

{ #category : 'converting' }
LuiCodec >> encode: anObject [
	"Converts an anObject to a string"
	^ self subclassResponsibility
]
