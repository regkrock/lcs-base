Class {
	#name : 'LuiCssClassesPropertyExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'tests' }
LuiCssClassesPropertyExamples >> testAddingCssClass [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesAttribute new.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.
	self assert: cssClassesProperty cssClasses first equals: 'testClass'.
	self assert: cssClassesProperty cssClassesString = 'testClass'.
	cssClassesProperty addCssClass: 'testClass2'.
	self assert: cssClassesProperty cssClassesString = 'testClass testClass2'.
]

{ #category : 'tests' }
LuiCssClassesPropertyExamples >> testAddingDuplicateCssClass [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesAttribute new.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.

]

{ #category : 'tests' }
LuiCssClassesPropertyExamples >> testCreation [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesAttribute new.
	self assert: cssClassesProperty cssClasses isEmpty.
	self assert: cssClassesProperty cssClassesString isEmpty
]

{ #category : 'tests' }
LuiCssClassesPropertyExamples >> testCssClassString [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesAttribute new.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty cssClassesString isEmpty.
	self assert: cssClassesProperty attributeValue isEmpty.
	
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty cssClassesString equals: 'testClass'.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty attributeValue equals: 'testClass'.
	self assert: cssClassesProperty attributeValue equals: cssClassesProperty cachedValue.

	cssClassesProperty removeCssClass: 'testClass'.
	self assert: cssClassesProperty cachedValue isNil.
	self assert: cssClassesProperty cssClassesString isEmpty.
	self assert: cssClassesProperty attributeValue isEmpty.

]

{ #category : 'tests' }
LuiCssClassesPropertyExamples >> testRemovingCssClass [
	| cssClassesProperty |
	cssClassesProperty := LuiCssClassesAttribute new.
	cssClassesProperty addCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses size = 1.
	cssClassesProperty removeCssClass: 'testClass'.
	self assert: cssClassesProperty cssClasses isEmpty. 
]
