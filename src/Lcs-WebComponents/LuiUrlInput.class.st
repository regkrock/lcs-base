Class {
	#name : 'LuiUrlInput',
	#superclass : 'LuiAbstractTextAreaComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'gt views' }
LuiUrlInput >> gtViewBaseTagName [
	^ super gtViewBaseTagName , ' type=''url'''
]

{ #category : 'rendering' }
LuiUrlInput >> renderComponentOn: html [
	html urlInput
		addCommonAttributes: self;
		value: self displayValue
]
