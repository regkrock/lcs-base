Class {
	#name : 'LuiFunctionalTest',
	#superclass : 'LuiRoot',
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'testing' }
LuiFunctionalTest class >> isLcsFunctionalTest [
	^ self name asString ~= 'LuiFunctionalTest'
]

{ #category : 'updating' }
LuiFunctionalTest >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot title: self class name greaseString
]
