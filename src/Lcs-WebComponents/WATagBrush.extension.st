Extension { #name : #WATagBrush }

{ #category : #'*Lcs-WebComponents' }
WATagBrush >> addCommonProperties: aComponent [
	aComponent properties addPropertiesToTag: self
]

{ #category : #'*Lcs-WebComponents' }
WATagBrush >> dataName: aString [

	self dataAttributeAt: 'name' put: aString
]

{ #category : #'*Lcs-WebComponents' }
WATagBrush >> dataStClass: anInstanceOrClass [
	| stClass |
	stClass := (anInstanceOrClass isClass) 
				ifTrue: [anInstanceOrClass] 
				ifFalse: [anInstanceOrClass class].
				
	self dataAttributeAt: 'StClass' put: stClass name asString
]

{ #category : #'*Lcs-WebComponents' }
WATagBrush >> direction: aString [
	"Set the text direction ltr (left-to-right) or right-to-left (rtl).

	Not supported on:
	APPLET, BASE, BASEFONT, BR, FRAME, FRAMESET, IFRAME, PARAM, SCRIPT"

	self attributes at: 'dir' put: aString
]

{ #category : #'*Lcs-WebComponents' }
WATagBrush >> required [
	"supported on:
	- Opera 9"
	self attributeAt: 'required' put: true
]

{ #category : #'*Lcs-WebComponents' }
WATagBrush >> required: aBoolean [
	"supported on:
	- Opera 9"
	self attributeAt: 'required' put: aBoolean
]

{ #category : #'*Lcs-WebComponents' }
WATagBrush >> visitComponentProperities: aComponent with: tag [ 
	aComponent addPropertiesTo: tag
]
