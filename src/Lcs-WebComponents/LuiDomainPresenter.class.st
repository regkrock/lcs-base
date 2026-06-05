Class {
	#name : 'LuiDomainPresenter',
	#superclass : 'LuiPresenter',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'rendering' }
LuiDomainPresenter >> renderComponentOn: html [
	html section
		addCommonAttributes: self;
		with: [ self renderDetailsOn: html ]
]
