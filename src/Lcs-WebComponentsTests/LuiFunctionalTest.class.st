Class {
	#name : #LuiFunctionalTest,
	#superclass : #LuiComponent,
	#category : #'Lcs-WebComponentsTests-Functional'
}

{ #category : #testing }
LuiFunctionalTest class >> isLcsFunctionalTest [
	^ self name ~= #LcsFunctionalTest
]

{ #category : #updating }
LuiFunctionalTest >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot title: self class name greaseString
]
