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

	^ self subclassResponsibility
]

{ #category : 'converting' }
LuiCodec >> encode: aString [
	^ self subclassResponsibility
]
