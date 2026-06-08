Class {
	#name : 'LuiDomainPresenter',
	#superclass : 'LuiPresenter',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'rendering' }
LuiDomainPresenter >> renderComponentOn: html [
	html div
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
