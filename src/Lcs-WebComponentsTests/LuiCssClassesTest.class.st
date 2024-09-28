Class {
	#name : #LuiCssClassesTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #'as yet unclassified' }
LuiCssClassesTest >> testAddingCssClass [
	| cssClasses |
	cssClasses := LuiCssClasses new.
	cssClasses addCssClass: 'testClass'.
	self assert: cssClasses cssClasses size = 1.
	self assert: cssClasses cssClasses first equals: 'testClass'.
	self assert: cssClasses cssClassesString = 'testClass'.
	cssClasses addCssClass: 'testClass2'.
	self assert: cssClasses cssClassesString = 'testClass testClass2'.
]

{ #category : #'as yet unclassified' }
LuiCssClassesTest >> testAddingDuplicateCssClass [
	| cssClasses |
	cssClasses := LuiCssClasses new.
	cssClasses addCssClass: 'testClass'.
	self assert: cssClasses cssClasses size = 1.
	cssClasses addCssClass: 'testClass'.
	self assert: cssClasses cssClasses size = 1.

]

{ #category : #'as yet unclassified' }
LuiCssClassesTest >> testCreation [
	| cssClasses |
	cssClasses := LuiCssClasses new.
	self assert: cssClasses cssClasses isEmpty.
	self assert: cssClasses cssClassesString isEmpty
]

{ #category : #'as yet unclassified' }
LuiCssClassesTest >> testRemovingCssClass [
	| cssClasses |
	cssClasses := LuiCssClasses new.
	cssClasses addCssClass: 'testClass'.
	self assert: cssClasses cssClasses size = 1.
	cssClasses removeCssClass: 'testClass'.
	self assert: cssClasses cssClasses size = 1. 
]
