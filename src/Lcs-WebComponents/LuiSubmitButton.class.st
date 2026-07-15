Class {
	#name : 'LuiSubmitButton',
	#superclass : 'LuiButton',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'button action' }
LuiSubmitButton >> applyButtonAction [
	self subclassResponsibility
]

{ #category : 'initialize' }
LuiSubmitButton >> initialize [
	super initialize.
	"self beSubmitType"
]

{ #category : 'rendering' }
LuiSubmitButton >> renderComponentOn: html [
	html button
		addCommonAttributes: self;
		onClick: (
			html jQuery ajax
				serializeForm;
				callback: [ self applyButtonAction];
				onSuccess: ((html jQuery: #root)
					append: [ :h | h render: (html jQuery: #root) ]));
			"script: [ :s | self loggerOn: s ]);"
		with: [ self renderDetailsOn: html ]
]
