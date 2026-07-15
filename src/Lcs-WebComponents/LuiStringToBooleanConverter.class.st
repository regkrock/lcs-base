Class {
	#name : 'LuiStringToBooleanConverter',
	#superclass : 'LuiDisplayConverter',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'converting' }
LuiStringToBooleanConverter >> convertFromString: aString [
	^ aString = 'on'
]
