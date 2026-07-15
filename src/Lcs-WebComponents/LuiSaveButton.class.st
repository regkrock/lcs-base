Class {
	#name : 'LuiSaveButton',
	#superclass : 'LuiSubmitButton',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'button action' }
LuiSaveButton >> applyButtonAction [
	self saveChanges
]

{ #category : 'initialize' }
LuiSaveButton >> initialize [
	super initialize.
	self componentName: 'saveButton'.
	self imageUrl: LcsFileLibrary / #check24Svg.
	self spanComponent text: 'Save'.
	"self callback: [ self saveChanges ]"
]

{ #category : 'button action' }
LuiSaveButton >> saveChanges [
	Transcript show: 'Saving Changes'; cr.
	^ LcsApplicationEnvironment currentSystem unitOfWork applyChanges
]
