Class {
	#name : #LuiAnchor,
	#superclass : #LuiButton,
	#category : #'Lcs-WebComponents-Buttons'
}

{ #category : #properties }
LuiAnchor >> anchorClicked [
	Transcript show: 'Clicked ' , self label; cr 
]

{ #category : #properties }
LuiAnchor >> label [
	^ self properties label
]

{ #category : #properties }
LuiAnchor >> label: aString [
	self properties labelBlock: [ aString ]
]

{ #category : #properties }
LuiAnchor >> labelBlock: aBlock [
	self properties labelBlock: aBlock
]

{ #category : #rendering }
LuiAnchor >> renderComponentOn: html [
	html anchor
		addCommonProperties: self;
		callback: [ self showLabelOnTranscript.
					"self mainPage nextApplicationAreaClass: self targetClass" ];
		with: self label asString 
]
