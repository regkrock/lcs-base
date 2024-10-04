Class {
	#name : #LuiMainPage,
	#superclass : #LuiPage,
	#instVars : [
		'pageTitle'
	],
	#category : #'Lcs-WebComponents-Base'
}

{ #category : #initialize }
LuiMainPage >> initialize [
	| header |
	super initialize.
	self addComponent: (header := LuiHeader named: 'header' on: self).
	header addComponent: (LuiHeading named: 'title' on: header).
	header addComponent: (LuiMainMenu named: 'navigation' on: header).
	"self addComponent:  (LuiButtonBar named: 'actionBar' on: self)."
	self addComponent: (LuiApplicationArea named: 'application' on: self).
]

{ #category : #accessing }
LuiMainPage >> pageTitle [
	^ pageTitle
]

{ #category : #accessing }
LuiMainPage >> pageTitle: anObject [
	pageTitle := anObject
]

{ #category : #rendering }
LuiMainPage >> renderComponentOn: html [
	"self pageTitle isEmptyOrNil ifTrue: [
		self removeComponent: (self componentNamed: 'title')]."
	super renderComponentOn: html
]
