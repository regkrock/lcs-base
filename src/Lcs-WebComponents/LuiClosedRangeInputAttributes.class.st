Class {
	#name : 'LuiClosedRangeInputAttributes',
	#superclass : 'LuiSteppedInputAttributes',
	#category : 'Lcs-WebComponents-Attributes',
	#package : 'Lcs-WebComponents',
	#tag : 'Attributes'
}

{ #category : 'testing' }
LuiClosedRangeInputAttributes >> isReadOnly [
	self hasReadOnlyAttribute ifFalse: [ ^ false ].
	^ self readOnlyAttribute readOnly
]
