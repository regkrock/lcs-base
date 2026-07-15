Class {
	#name : 'LuiBooleanToStringConverter',
	#superclass : 'LuiDisplayConverter',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'converting' }
LuiBooleanToStringConverter >> convertToString: aBoolean [
	^ aBoolean == true ifTrue: [ 'on' ] ifFalse: [ 'off' ]
]
