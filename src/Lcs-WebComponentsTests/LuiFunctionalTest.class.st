Class {
	#name : 'LuiFunctionalTest',
	#superclass : 'LuiComponent',
	#category : 'Lcs-WebComponentsTests-Functional',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Functional'
}

{ #category : 'testing' }
LuiFunctionalTest class >> canBeRoot [
	^ true
]

{ #category : 'testing' }
LuiFunctionalTest class >> isLcsFunctionalTest [
	^ self name asString ~= 'LuiFunctionalTest'
]

{ #category : 'updating' }
LuiFunctionalTest >> updateRoot: aRoot [
	super updateRoot: aRoot.
	aRoot stylesheet url: LcsFunctionalTestFileLibrary / #mainCss
]
