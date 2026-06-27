Class {
	#name : 'LuiStringToTimeConverter',
	#superclass : 'LuiDisplayConverter',
	#category : 'Lcs-WebComponents-Transformers',
	#package : 'Lcs-WebComponents',
	#tag : 'Transformers'
}

{ #category : 'converting' }
LuiStringToTimeConverter >> convertFromString: aString [
	^ [ Time fromString: aString ] on: Error do: [ :s | s return: nil ]
]
