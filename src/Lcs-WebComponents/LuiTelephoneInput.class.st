Class {
	#name : 'LuiTelephoneInput',
	#superclass : 'LuiAbstractTextAreaComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'gt views' }
LuiTelephoneInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''tel'''
]

{ #category : 'rendering' }
LuiTelephoneInput >> renderComponentOn: html [
	html telephoneInput
		addCommonAttributes: self;
		onBlur: (self handleCallbackAndRenderDependents: html);
		value: self displayValue
]
