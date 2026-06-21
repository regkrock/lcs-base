Class {
	#name : 'LuiUrlInput',
	#superclass : 'LuiAbstractTextAreaComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'gt views' }
LuiUrlInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''url'''
]

{ #category : 'rendering' }
LuiUrlInput >> renderComponentOn: html [
	html urlInput
		addCommonAttributes: self;
		value: self displayValue
]
