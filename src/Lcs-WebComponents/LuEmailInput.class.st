Class {
	#name : 'LuEmailInput',
	#superclass : 'LuiAbstractTextAreaComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'gt views' }
LuEmailInput >> gtViewBaseTagName [
	^ super gtViewBaseTagName , ' type=''email'''
]

{ #category : 'rendering' }
LuEmailInput >> renderComponentOn: html [
	html emailInput 
		addCommonAttributes: self;
		onBlur: (self handleCallbackAndRenderDependents: html);
		value: self displayValue
]
